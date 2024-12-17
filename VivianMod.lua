--- STEAMODDED HEADER
--- MOD_NAME: Vivian Joker
--- MOD_ID: vivian_mod
--- MOD_AUTHOR: [Onekone]
--- MOD_DESCRIPTION: A mod with a joker and a deck that starts with it
--- VERSION: 0.1.1
--- PREFIX: viv
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({key = 'VivianAtlas', path = 'Viv.png', px = 71, py = 95})

viv = SMODS.Joker{
    key = 'vivian_joker',
    rarity = 3,
    atlas = 'VivianAtlas',
    discovered = true,
    cost = 7,
    face_pos  = {x = 1, y= 0},
    blueprint_compat = true,
    pos = { x = 0, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.effect == 'Stone Card' then
                return {}
            end

            if context.other_card:is_suit('Spades') then
                local value = context.other_card.base.nominal

                if ((context.other_card.ability or nil) ~= nil) then
                  value = value + math.max((context.other_card.ability.bonus or 0),0)
                end

                if ((context.other_card.edition or nil) ~= nil) then
                  value = value + math.max((context.other_card.edition.chips or 0),0)
                end

                if value <= 0 then
                    return {}
                end

                return {
                    chips = -value,
                    mult = value,
                    card = card,
                    message = 'Swap!'
                }
            end
        end
    end
}

--

SMODS.Back{
    key = 'vivian_deck',
    discovered = true,
    atlas = 'VivianAtlas',
    pos = {x = 2, y = 0},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
                        func = function()
                            addYoker("j_viv_vivian_joker","e_base")
                        return true
                        end
                    }))
    end,
    trigger_effect = function(self, args)
    end
}

a = SMODS.Sticker{
    key = 'freebie',
    badge_colour = HEX("f8f800"),
    atlas = 'VivianAtlas',
    pos = {
        x = 3,
        y = 0
    },
    loc_txt = {
        label = 'Not for resale',
        name = 'Not for resale',
        text = {
            '{C:attention}Sell value{} is always {C:gold}$0{}',
        }
    },
    rate = 0.0
}


function addYoker(yoker, edition)
    edition = edition or "e_base"
    local j = create_card("Joker", G.jokers, nil, nil, nil, nil, yoker)
    j:add_to_deck()
    j:set_edition(edition, true)
    a:apply(j,true)
    j:set_cost()

    G.jokers:emplace(j)
end

----------------------------------------------
------------MOD CODE END----------------------
