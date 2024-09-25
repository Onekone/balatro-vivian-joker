--- STEAMODDED HEADER
--- MOD_NAME: Vivian Joker
--- MOD_ID: vivian_mod
--- MOD_AUTHOR: [Onekone]
--- MOD_DESCRIPTION: A mod with a joker and a deck that starts with it
--- VERSION: 1.0.0
--- PREFIX: viv
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({key = 'VivianAtlas', path = 'Viv.png', px = 71, py = 95})

--[[G.localization.misc.challenge_names['c_mod_GenChal'] = 'General Challenge'
table.insert(G.CHALLENGES,1,{
   name = 'Custom Generated Challenge',
   id = 'c_mod_GenChal',

   rules = {
       custom = {
       },
       modifiers = {
       }
   },
   jokers = {
      {id = 'j_vivian_vivian_joker', eternal = true, edition = 'base'} ,
   },
   vouchers = {
      {id = 'v_palette'}
   },
   deck = {
       cards = {
                   {s='S', r='2',e='m_stone'},
                   {s='S', r='3',e='m_stone'},
                   {s='S', r='4',e='m_stone'},
                   {s='S', r='5',e='m_stone'},
                   {s='S', r='6',e='m_stone'},
                   {s='S', r='7',e='m_stone'},
                   {s='S', r='8',e='m_stone'},
                   {s='S', r='9',e='m_stone'},
                   {s='S', r='T',e='m_stone'},
                   {s='S', r='A',e='m_stone'},
                   {s='S', r='J',e='m_stone'},
                   {s='S', r='Q',e='m_stone'},
                   {s='S', r='K',e='m_stone'},

            {s='S', r='2',d='foil'},
            {s='S', r='3',d='foil'},
            {s='S', r='4',d='foil'},
            {s='S', r='5',d='foil'},
            {s='S', r='6',d='foil'},
            {s='S', r='7',d='foil'},
            {s='S', r='8',d='foil'},
            {s='S', r='9',d='foil'},
            {s='S', r='T',d='foil'},
            {s='S', r='A',d='foil'},
            {s='S', r='J',d='foil'},
            {s='S', r='Q',d='foil'},
            {s='S', r='K',d='foil'},

            {s='S', r='2',d='foil',e='m_bonus'},
            {s='S', r='3',d='foil',e='m_bonus'},
            {s='S', r='4',d='foil',e='m_bonus'},
            {s='S', r='5',d='foil',e='m_bonus'},
            {s='S', r='6',d='foil',e='m_bonus'},
            {s='S', r='7',d='foil',e='m_bonus'},
            {s='S', r='8',d='foil',e='m_bonus'},
            {s='S', r='9',d='foil',e='m_bonus'},
            {s='S', r='T',d='foil',e='m_bonus'},
            {s='S', r='A',d='foil',e='m_bonus'},
            {s='S', r='J',d='foil',e='m_bonus'},
            {s='S', r='Q',d='foil',e='m_bonus'},
            {s='S', r='K',d='foil',e='m_bonus'},

            {s='S', r='2',e='m_bonus'},
            {s='S', r='3',e='m_bonus'},
            {s='S', r='4',e='m_bonus'},
            {s='S', r='5',e='m_bonus'},
            {s='S', r='6',e='m_bonus'},
            {s='S', r='7',e='m_bonus'},
            {s='S', r='8',e='m_bonus'},
            {s='S', r='9',e='m_bonus'},
            {s='S', r='T',e='m_bonus'},
            {s='S', r='A',e='m_bonus'},
            {s='S', r='J',e='m_bonus'},
            {s='S', r='Q',e='m_bonus'},
            {s='S', r='K',e='m_bonus'},
        },
       type = 'Plasma Deck'
  },
   restrictions = {
       banned_cards = {
       },
       banned_tags = {
       },
       banned_other = {
       }
   }
})]]--

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
    calculate = function(self, card, context)
    end
}

viv.calculate = function(self,card,context)
    if context.individual and context.cardarea == G.play then
        if context.other_card.ability.effect == 'Stone Card' then
            return {}
        end

        if context.other_card:is_suit('Spades') then
            local value = context.other_card.base.nominal + context.other_card.ability.bonus + context.other_card.edition.chips
            return {
                chips = -value,
                mult = value,
                card = card,
                message = localize {
                    type = 'variable',
                    key = 'a_mult',
                    vars = { value }
                }
            }
        end
    end
end

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
                            local viv_1 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_viv_vivian_joker")
                            viv_1:add_to_deck()
                            viv_1:set_edition('e_base', true)
                            G.jokers:emplace(viv_1)

                            local viv_2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_viv_vivian_joker")
                            viv_2:add_to_deck()
                            viv_2:set_edition('e_foil', true)
                            G.jokers:emplace(viv_2)

                            local viv_3 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_viv_vivian_joker")
                            viv_3:add_to_deck()
                            viv_3:set_edition('e_holo', true)
                            G.jokers:emplace(viv_3)

                            local viv_4 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_viv_vivian_joker")
                            viv_4:add_to_deck()
                            viv_4:set_edition('e_polychrome', true)
                            G.jokers:emplace(viv_4)

                            local viv_5 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_viv_vivian_joker")
                            viv_5:add_to_deck()
                            viv_5:set_edition('e_negative', true)
                            G.jokers:emplace(viv_5)
                        return true
                        end
                    }))
    end,
    trigger_effect = function(self, args)
    end
}

----------------------------------------------
------------MOD CODE END----------------------