--- STEAMODDED HEADER
--- MOD_NAME: JankJonklersMod
--- MOD_ID: JankJonklersMod
--- MOD_AUTHOR: [Lyman]
--- MOD_DESCRIPTION: Adds a bunch of Jank Jonklers.

----------------------------------------------
------------MOD CODE -------------------------

local MOD_ID = "JankJonklersMod";

-- Lyman: i am continuing the tradition of grifting off everyone else >:)
-- Thanks GoldenEpsilon!
-- https://github.com/GoldenEpsilon/ShamPack/blob/main/ShamPack.lua
local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front);
    if _center then
        if _center.set then
            if (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and _center.atlas then
                self.children.center.atlas = G.ASSET_ATLAS
                    [(_center.atlas or (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and _center.set) or 'centers']
                self.children.center:set_sprite_pos(_center.pos)
            end
        end
    end
end

-- https://github.com/GoldenEpsilon/ShamPack/blob/main/ShamPack.lua
function add_item(mod_id, pool, id, data, desc)
    -- Add Sprite
    data.pos = { x = 0, y = 0 };
    data.key = id;
    data.atlas = mod_id .. id;
    SMODS.Sprite:new(mod_id .. id, SMODS.findModByID(mod_id).path, id .. ".png", 71, 95, "asset_atli"):register();

    data.key = id
    data.order = #G.P_CENTER_POOLS[pool] + 1
    G.P_CENTERS[id] = data
    table.insert(G.P_CENTER_POOLS[pool], data)

    if pool == "Joker" then
        table.insert(G.P_JOKER_RARITY_POOLS[data.rarity], data)
    end

    G.localization.descriptions[pool][id] = desc;
end

-- https://github.com/GoldenEpsilon/ShamPack/blob/main/ShamPack.lua
function refresh_items()
    for k, v in pairs(G.P_CENTER_POOLS) do
        table.sort(v, function(a, b) return a.order < b.order end)
    end

    -- Update localization
    for g_k, group in pairs(G.localization) do
        if g_k == 'descriptions' then
            for _, set in pairs(group) do
                for _, center in pairs(set) do
                    center.text_parsed = {}
                    for _, line in ipairs(center.text) do
                        center.text_parsed[#center.text_parsed + 1] = loc_parse_string(line)
                    end
                    center.name_parsed = {}
                    for _, line in ipairs(type(center.name) == 'table' and center.name or { center.name }) do
                        center.name_parsed[#center.name_parsed + 1] = loc_parse_string(line)
                    end
                    if center.unlock then
                        center.unlock_parsed = {}
                        for _, line in ipairs(center.unlock) do
                            center.unlock_parsed[#center.unlock_parsed + 1] = loc_parse_string(line)
                        end
                    end
                end
            end
        end
    end

    for k, v in pairs(G.P_JOKER_RARITY_POOLS) do
        table.sort(G.P_JOKER_RARITY_POOLS[k], function(a, b) return a.order < b.order end)
    end
end

function SMODS.INIT.JankJonklersModJankJonklersMod()
    add_item(MOD_ID, "Joker", "j_devilish", {
        unlocked = true,
        discovered = true,
        rarity = 2,
        cost = 5,
        name = "Devilish Joker",
        set = "Joker",
        config = {
            extra = { x_mult = 3 },
        },
    }, {
        name = "Devilish Joker",
        text = {
            "{X:mult,C:white}x3{} Mult if played",
            "hand contains only {C:attention}6s{}",
            "or {C:attention}Gold Cards{}"
        }
    });

    -- add_item(MOD_ID, "Joker", "j_alloyed", {
    --     unlocked = true,
    --     discovered = true,
    --     rarity = 3,
    --     cost = 8,
    --     name = "Alloyed Joker",
    --     set = "Joker",
    --     config = {
    --         extra = { 
    --             x_mult = 1.5,
    --             dollars = 3 },
    --     },
    -- }, {
    --     name = "Alloyed Joker",
    --     text = {
    --         "Each {C:attention}Gold Card{} held in hand",
    --         "gives {X:mult,C:white}x1.5{} Mult. Each {C:attention}Steel Card{}",
    --         "held in hand give {C:attention}$3{} at the",
    --         "end of the round"
    --     }
    -- });

    add_item(MOD_ID, "Joker", "j_devoted", {
        unlocked = true,
        discovered = true,
        rarity = 3,
        cost = 8,
        name = "Devoted Joker",
        set = "Joker",
        config = {
            extra = {
                x_mult = 1
            },
        },
    }, {
        name = "Devoted Joker",
        text = {
            "When {C:attention}Boss Blind{} is selected",
            "gain {X:mult,C:white}x0.5{} Mult, then",
            "set your {C:attention}money{} to {C:attention}$0{}",
            "{C:inactive}(Currently {X:mult,C:white}x#1#{C:inactive})"
        }
    });

    add_item(MOD_ID, "Joker", "j_mind_mage", {
        unlocked = true,
        discovered = true,
        rarity = 2,
        cost = 6,
        name = "Mind Mage",
        set = "Joker",
        config = {
            extra = {
                h_size = 3
            },
        },
    }, {
        name = "Mind Mage",
        text = {
            "{C:attention}+3{} hand size",
            "Discard the 2 rightmost",
            "cards per hand played"
        }
    });

    add_item(MOD_ID, "Joker", "j_fortuno", {
        unlocked = true,
        discovered = true,
        rarity = 4,
        cost = 12,
        name = "Fortuno",
        set = "Joker",
        config = {
            extra = {
                dollars = 3
            },
        },
    }, {
        name = "Fortuno",
        text = {
            "Whenever you score a",
            "{C:attention}numbered card{} in your",
            "first hand each round,",
            "destroy it and gain {C:attention}$3{}"
        }
    });

    add_item(MOD_ID, "Joker", "j_old_man", {
        unlocked = true,
        discovered = true,
        rarity = 3,
        cost = 8,
        name = "Old Man Joker",
        set = "Joker",
        config = {
            extra = {
            },
        },
    }, {
        name = "Old Man Joker",
        text = {
            "When {C:attention}Boss Blind{} is selected",
            "create a free {C:attention}Ethereal Tag{}"
        }
    });

    add_item(MOD_ID, "Joker", "j_box_of_stuff", {
        unlocked = true,
        discovered = true,
        rarity = 2,
        cost = 5,
        name = "Box of Stuff",
        set = "Joker",
        eternal_compat = false,
        config = {
            extra = {
            },
        },
    }, {
        name = "Box of Stuff",
        text = {
            "When {C:attention}Boss Blind{} is selected",
            "create three free {C:attention}Standard Tags{},",
            "then destroy this card"
        }
    });

    add_item(MOD_ID, "Joker", "j_expanded_art", {
        unlocked = true,
        discovered = true,
        rarity = 1,
        cost = 4,
        name = "Expanded Art Joker",
        set = "Joker",
        config = {
            extra = { chips = 30 },
        },
    }, {
        name = "Expanded Art Joker",
        text = {
            "{C:attention}Enhanced Cards{} gives",
            "{C:chips}+30{} Chips when scored"
        }
    });

    add_item(MOD_ID, "Joker", "j_highlander", {
        unlocked = true,
        discovered = true,
        rarity = 1,
        cost = 4,
        name = "Highlander Joker",
        set = "Joker",
        config = {
            extra = 20,
        },
    }, {
        name = "Highlander Joker",
        text = {
            "Every scoring card permanently",
            "gains {C:chips}+20{} Chips when scored if",
            "your hand is a {C:attention}High Card{}."
        }
    });

    add_item(MOD_ID, "Joker", "j_lieutenant", {
        unlocked = true,
        discovered = true,
        rarity = 3,
        cost = 8,
        name = "Lieutenant Joker",
        set = "Joker",
        config = {
        },
    }, {
        name = "Lieutenant Joker",
        text = {
            "After you play a {C:attention}High Card{}",
            "increase the {C:attention}rank{}",
            "of each card played."
        }
    });

    add_item(MOD_ID, "Joker", "j_shady_dealer", {
        unlocked = true,
        discovered = true,
        rarity = 3,
        cost = 8,
        name = "Shady Dealer",
        set = "Joker",
        config = {
        },
    }, {
        name = "Shady Dealer",
        text = {
            "Sell this card to create",
            "a free {C:attention}Negative Tag{}"
        }
    });

    add_item(MOD_ID, "Joker", "j_suspicious_vase", {
        unlocked = true,
        discovered = true,
        rarity = 2,
        cost = 5,
        name = "Suspicious Vase",
        set = "Joker",
        config = {
            extra = 2,
        },
    }, {
        name = "Suspicious Vase",
        text = {
            "All {C:attention}2s{}, {C:attention}3s{} and {C:attention}4s{}",
            "become {C:attention}Glass Cards{}",
            "when played."
        }
    });
    -- Apply our changes
    refresh_items();
end

function table_length(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local calculate_jokerref = Card.calculate_joker;

function Card:calculate_joker(context)
    local ret_val = calculate_jokerref(self, context)
    if self.ability.set == "Joker" and not self.debuff then
        if context.individual then
            if context.cardarea == G.play then
                if self.ability.name == 'Expanded Art Joker' and context.other_card.ability.set == 'Enhanced' then
                    return {
                        chips = self.ability.extra.chips,
                        colour = G.C.RED,
                        card = self
                    }
                end
                if self.ability.name == 'Fortuno' and not context.blueprint and G.GAME.current_round.hands_played == 0 then
                    if context.other_card:is_face() or context.other_card:get_id() == 14 then
                        return nil
                    end
                    local card_to_destroy = context.other_card or nil
                    card_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        (context.blueprint_card or self):juice_up(0.8, 0.8)
                        card_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                    ease_dollars(self.ability.extra.dollars)
                    return {
                        message = localize('$')..self.ability.extra.dollars,
                        colour = G.C.MONEY,
                        delay = 0.45, 
                        remove = true,
                        card = self
                    }
                end
                if self.ability.name == 'Suspicious Vase' and (context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 4) then
                    if context.other_card.ability.name == 'Glass Card' then
                        return nil
                    end
                    context.other_card:set_ability(G.P_CENTERS.m_glass, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.other_card:juice_up()
                            return true
                        end
                    }))
                    return {
                        x_mult = self.ability.extra,
                        card = self
                    } 
                end
                if self.ability.name == "Highlander Joker" and context.scoring_name == "High Card" and not context.blueprint then
                    if not context.other_card.debuff then
                        context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                        context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + self.ability.extra
                        return {
                            extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                            colour = G.C.CHIPS,
                            card = self
                        }
                    end
                end
                if self.ability.name == "Lieutenant Joker" and context.scoring_name == "High Card" then
                    for k, v in ipairs(context.full_hand) do
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                            local card = v
                            local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                            local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id+1, 14)
                            if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                            elseif rank_suffix == 10 then rank_suffix = 'T'
                            elseif rank_suffix == 11 then rank_suffix = 'J'
                            elseif rank_suffix == 12 then rank_suffix = 'Q'
                            elseif rank_suffix == 13 then rank_suffix = 'K'
                            elseif rank_suffix == 14 then rank_suffix = 'A'
                            end
                            card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                        return true end }))
                    end
                end
            end
            if context.cardarea == G.hand then
                if self.ability.name == 'Alloyed Joker' and not context.blueprint then
                    if context.other_card.ability.name == 'Gold Card' then
                        if context.other_card.debuff then
                            return {
                                message = localize('k_debuffed'),
                                colour = G.C.RED,
                                card = self,
                            }
                        else
                            return {
                                x_mult = self.ability.extra.x_mult,
                                card = self
                            }
                        end
                    end
                end
            end
        elseif context.cardarea == G.jokers then
            if context.joker_main then
                if self.ability.name == 'Devilish Joker' then
                    local onlySixes = true
                    for k, v in ipairs(context.full_hand) do
                        onlySixes = onlySixes and (v:get_id() == 6 or v.ability.name == 'Gold Card')
                    end
                    if not onlySixes then
                        return nil
                    end
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult } },
                        Xmult_mod = self.ability.extra.x_mult
                    }
                end
                if self.ability.name == "Devoted Joker" then
                    if self.ability.extra.x_mult > 1 then
                        return {
                            message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult } },
                            Xmult_mod = self.ability.extra.x_mult
                        }
                    end
                    return nil
                end
            elseif context.before then
                if self.ability.name == 'Mind Mage' then
                    G.E_MANAGER:add_event(Event({ func = function()
                        local any_selected = nil
                        local _cards = {}
                        for k, v in ipairs(G.hand.cards) do
                            _cards[#_cards+1] = v
                        end
                        for i = 1, 2 do
                            if G.hand.cards[i] then 
                                local last_index = #_cards
                                local selected_card = _cards[last_index]
                                G.hand:add_to_highlighted(selected_card, true)
                                table.remove(_cards, last_index)
                                any_selected = true
                                play_sound('card1', 1)
                            end
                        end
                        if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                    return true end })) 
                end
            end
        elseif context.end_of_round then
            if context.individual then
                if self.ability.name == 'Alloyed Joker' then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 5
                    G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                end
            end
        elseif context.setting_blind and not self.getting_sliced then
            if self.ability.name == 'Devoted Joker' and not context.blueprint
            and context.blind.boss and not self.getting_sliced then
                ease_dollars(-G.GAME.dollars, true)
                self.ability.extra.x_mult = self.ability.extra.x_mult + 0.5
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
            if self.ability.name == 'Old Man Joker' and not context.blueprint
            and context.blind.boss and not self.getting_sliced then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_ethereal'))
                        play_sound('generic1', 0.6 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.1 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
            if self.ability.name == 'Box of Stuff' and not context.blueprint
            and context.blind.boss and not self.getting_sliced then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_standard'))
                        add_tag(Tag('tag_standard'))
                        add_tag(Tag('tag_standard'))
                        play_sound('generic1', 0.6 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.1 + math.random()*0.1, 0.4)
                        self.T.r = -0.2
                        self:juice_up(0.3, 0.4)
                        self.states.drag.is = true
                        self.children.center.pinch.x = true
                        return true
                    end)
                }))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                func = function()
                        G.jokers:remove_card(self)
                        self:remove()
                        self = nil
                    return true; end})) 
            end
        elseif context.selling_self then
            if self.ability.name == 'Shady Dealer' then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_negative'))
                        play_sound('generic1', 0.6 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.1 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
        end
    end
    return ret_val
end

function Card:add_to_deck(from_debuff)
    if not self.added_to_deck then
        self.added_to_deck = true
        if self.ability.name == 'Mind Mage' then
            G.hand:change_size(self.ability.extra.h_size)
        end
    end
end


function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        self.added_to_deck = false
        if self.ability.name == 'Mind Mage' then
            G.hand:change_size(-self.ability.extra.h_size)
        end
    end
end

local card_uiref = Card.generate_UIBox_ability_table;
function Card:generate_UIBox_ability_table()
    local badges = {}
    local card_type = self.ability.set or "None"
    local loc_vars = nil

    if self.ability.name == 'Devilish Joker' then
        loc_vars = { self.ability.extra.x_mult }
    end

    if self.ability.name == 'Devoted Joker' then
        loc_vars = { self.ability.extra.x_mult }
    end

    if (card_type ~= 'Locked' and card_type ~= 'Undiscovered' and card_type ~= 'Default') or self.debuff then
        badges.card_type = card_type
    end
    if self.ability.set == 'Joker' and self.bypass_discovery_ui then
        badges.force_rarity = true
    end
    if self.edition then
        if self.edition.type == 'negative' and self.ability.consumeable then
            badges[#badges + 1] = 'negative_consumable'
        else
            badges[#badges + 1] = (self.edition.type == 'holo' and 'holographic' or self.edition.type)
        end
    end
    if self.seal then badges[#badges + 1] = string.lower(self.seal) .. '_seal' end
    if self.ability.eternal then badges[#badges + 1] = 'eternal' end
    if self.pinned then badges[#badges + 1] = 'pinned_left' end

    if self.sticker then
        loc_vars = loc_vars or {}; loc_vars.sticker = self.sticker
    end

    if self.ability.name == 'Devilish Joker' or self.ability.name == 'Devoted Joker' then
        return generate_card_ui(self.config.center, nil, loc_vars, card_type, badges, false, nil, nil)
    end

    return card_uiref(self)
end


----------------------------------------------
------------MOD CODE END----------------------