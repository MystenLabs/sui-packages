module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect {
    struct Effect has copy, drop, store {
        kind: u8,
        element: 0x1::string::String,
        value: u32,
        value_max: u32,
        area_shape: u8,
        area_size: u8,
        target_filter: u8,
        chance_bp: u16,
        turns: u8,
        stat: u8,
    }

    struct SpellLevel has copy, drop, store {
        ap_cost: u8,
        range_min: u8,
        range_max: u8,
        modifiable_range: bool,
        line_of_sight: bool,
        line_launch: bool,
        free_cell: bool,
        casts_per_turn: u8,
        casts_per_target: u8,
        cooldown_turns: u8,
        crit_1_in: u16,
        effects: vector<Effect>,
        crit_effects: vector<Effect>,
    }

    public fun aims_only_at_allies(arg0: &SpellLevel) : bool {
        if (!0x1::vector::is_empty<Effect>(&arg0.effects) || !0x1::vector::is_empty<Effect>(&arg0.crit_effects)) {
            if (rows_aim_only_at_allies(&arg0.effects)) {
                rows_aim_only_at_allies(&arg0.crit_effects)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun aims_only_at_caster(arg0: &SpellLevel) : bool {
        if (!0x1::vector::is_empty<Effect>(&arg0.effects) || !0x1::vector::is_empty<Effect>(&arg0.crit_effects)) {
            if (rows_aim_only_at_caster(&arg0.effects)) {
                rows_aim_only_at_caster(&arg0.crit_effects)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun ap_cost(arg0: &SpellLevel) : u8 {
        arg0.ap_cost
    }

    public fun area_shape(arg0: &Effect) : u8 {
        arg0.area_shape
    }

    public fun area_size(arg0: &Effect) : u8 {
        arg0.area_size
    }

    public fun casts_per_target(arg0: &SpellLevel) : u8 {
        arg0.casts_per_target
    }

    public fun casts_per_turn(arg0: &SpellLevel) : u8 {
        arg0.casts_per_turn
    }

    public fun chance_bp(arg0: &Effect) : u16 {
        arg0.chance_bp
    }

    public fun chatiment_turns() : u8 {
        5
    }

    public fun cooldown_turns(arg0: &SpellLevel) : u8 {
        arg0.cooldown_turns
    }

    public fun crit_1_in(arg0: &SpellLevel) : u16 {
        arg0.crit_1_in
    }

    public fun crit_effects(arg0: &SpellLevel) : vector<Effect> {
        arg0.crit_effects
    }

    public fun displacement_last(arg0: &vector<Effect>) : vector<Effect> {
        let v0 = 0x1::vector::empty<Effect>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Effect>(arg0)) {
            if (!is_displacement(0x1::vector::borrow<Effect>(arg0, v1))) {
                0x1::vector::push_back<Effect>(&mut v0, *0x1::vector::borrow<Effect>(arg0, v1));
            };
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<Effect>(arg0)) {
            if (is_displacement(0x1::vector::borrow<Effect>(arg0, v1))) {
                0x1::vector::push_back<Effect>(&mut v0, *0x1::vector::borrow<Effect>(arg0, v1));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun effects(arg0: &SpellLevel) : vector<Effect> {
        arg0.effects
    }

    public fun element(arg0: &Effect) : 0x1::string::String {
        arg0.element
    }

    public fun free_cell(arg0: &SpellLevel) : bool {
        arg0.free_cell
    }

    public fun has_direct_damage(arg0: &vector<Effect>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Effect>(arg0)) {
            let v1 = 0x1::vector::borrow<Effect>(arg0, v0);
            let v2 = v1.kind;
            let v3 = if (v2 == 0) {
                true
            } else if (v2 == 1) {
                true
            } else if (v2 == 3) {
                true
            } else if (v2 == 6) {
                if (v1.stat == 12) {
                    v1.turns == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun has_displacement(arg0: &vector<Effect>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Effect>(arg0)) {
            if (is_displacement(0x1::vector::borrow<Effect>(arg0, v0))) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun has_heal(arg0: &SpellLevel) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Effect>(&arg0.effects)) {
            if (0x1::vector::borrow<Effect>(&arg0.effects, v0).kind == 4 && 0x1::vector::borrow<Effect>(&arg0.effects, v0).stat == 12) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_displacement(arg0: &Effect) : bool {
        if (arg0.kind == 8) {
            true
        } else if (arg0.kind == 9) {
            true
        } else if (arg0.kind == 10) {
            true
        } else {
            arg0.kind == 11
        }
    }

    public fun is_zone_placement(arg0: &Effect) : bool {
        arg0.kind == 12 || arg0.kind == 13
    }

    public fun kind(arg0: &Effect) : u8 {
        arg0.kind
    }

    public fun line_launch(arg0: &SpellLevel) : bool {
        arg0.line_launch
    }

    public fun line_of_sight(arg0: &SpellLevel) : bool {
        arg0.line_of_sight
    }

    public fun modifiable_range(arg0: &SpellLevel) : bool {
        arg0.modifiable_range
    }

    public fun new_effect(arg0: u8, arg1: 0x1::string::String, arg2: u32, arg3: u32, arg4: u8, arg5: u8, arg6: u8, arg7: u16, arg8: u8, arg9: u8) : Effect {
        assert!(arg0 < 21, 1401);
        assert!(arg4 < 10, 1402);
        assert!(arg5 <= 10, 1411);
        assert!(arg6 < 5, 1403);
        assert!(0x1::string::is_empty(&arg1) || 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::is_element(&arg1), 1404);
        assert!(arg2 <= arg3, 1405);
        assert!(arg7 <= 10000, 1406);
        let v0 = if (arg0 <= 3) {
            true
        } else if (arg0 >= 8 && arg0 <= 12) {
            true
        } else {
            arg0 == 16
        };
        let v1 = if (arg0 == 13) {
            true
        } else if (arg0 == 14) {
            true
        } else if (arg0 == 15) {
            true
        } else if (arg0 == 17) {
            true
        } else if (arg0 == 18) {
            true
        } else {
            arg0 == 19
        };
        if (v0) {
            assert!(arg8 == 0, 1409);
        };
        if (v1) {
            assert!(arg8 >= 1, 1409);
        };
        let v2 = if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 6
        };
        if (v2) {
            assert!(arg9 < 13, 1408);
            if (arg9 == 12) {
                if (arg0 == 5) {
                    assert!(arg8 >= 1, 1408);
                };
                if (arg0 == 5 || arg0 == 6) {
                    assert!(!0x1::string::is_empty(&arg1), 1404);
                } else {
                    assert!(0x1::string::is_empty(&arg1), 1404);
                };
            };
        };
        if (arg0 == 7) {
            assert!(arg9 <= 5 || arg9 >= 8 && arg9 <= 10, 1408);
            assert!(arg8 == 5, 1409);
            assert!(0x1::string::is_empty(&arg1), 1404);
        };
        if (arg0 == 20) {
            assert!(arg9 == 6 || arg9 == 7, 1408);
            assert!(0x1::string::is_empty(&arg1), 1404);
        };
        Effect{
            kind          : arg0,
            element       : arg1,
            value         : arg2,
            value_max     : arg3,
            area_shape    : arg4,
            area_size     : arg5,
            target_filter : arg6,
            chance_bp     : arg7,
            turns         : arg8,
            stat          : arg9,
        }
    }

    public fun new_spell_level(arg0: u8, arg1: u8, arg2: u8, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: u8, arg8: u8, arg9: u8, arg10: u16, arg11: vector<Effect>, arg12: vector<Effect>) : SpellLevel {
        assert!(arg0 > 0 && arg1 <= arg2, 1407);
        assert!(arg10 != 1, 1407);
        assert!(0x1::vector::length<Effect>(&arg11) <= 8 && 0x1::vector::length<Effect>(&arg12) <= 8, 1410);
        SpellLevel{
            ap_cost          : arg0,
            range_min        : arg1,
            range_max        : arg2,
            modifiable_range : arg3,
            line_of_sight    : arg4,
            line_launch      : arg5,
            free_cell        : arg6,
            casts_per_turn   : arg7,
            casts_per_target : arg8,
            cooldown_turns   : arg9,
            crit_1_in        : arg10,
            effects          : arg11,
            crit_effects     : arg12,
        }
    }

    public fun range_max(arg0: &SpellLevel) : u8 {
        arg0.range_max
    }

    public fun range_min(arg0: &SpellLevel) : u8 {
        arg0.range_min
    }

    fun rows_aim_only_at_allies(arg0: &vector<Effect>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Effect>(arg0)) {
            let v1 = 0x1::vector::borrow<Effect>(arg0, v0).target_filter;
            if (v1 != 3 && v1 != 4) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun rows_aim_only_at_caster(arg0: &vector<Effect>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Effect>(arg0)) {
            if (0x1::vector::borrow<Effect>(arg0, v0).target_filter != 4) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun shape_allmap() : u8 {
        6
    }

    public fun shape_blob() : u8 {
        9
    }

    public fun shape_circle() : u8 {
        1
    }

    public fun shape_cone() : u8 {
        7
    }

    public fun shape_cross() : u8 {
        2
    }

    public fun shape_line() : u8 {
        3
    }

    public fun shape_podium() : u8 {
        8
    }

    public fun shape_point() : u8 {
        0
    }

    public fun shape_ring() : u8 {
        5
    }

    public fun shape_tbar() : u8 {
        4
    }

    public fun split_placements(arg0: &vector<Effect>) : (vector<Effect>, vector<Effect>) {
        let v0 = 0x1::vector::empty<Effect>();
        let v1 = 0x1::vector::empty<Effect>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Effect>(arg0)) {
            let v3 = *0x1::vector::borrow<Effect>(arg0, v2);
            if (is_zone_placement(&v3)) {
                0x1::vector::push_back<Effect>(&mut v0, v3);
            } else {
                0x1::vector::push_back<Effect>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun stat(arg0: &Effect) : u8 {
        arg0.stat
    }

    public fun target_allowed(arg0: u8, arg1: u8, arg2: u8, arg3: bool) : bool {
        arg0 == 1 && arg2 != arg1 || arg0 == 2 && !arg3 || arg0 == 3 && arg2 == arg1 || arg0 == 4 && arg3 || true
    }

    public fun target_filter(arg0: &Effect) : u8 {
        arg0.target_filter
    }

    public fun turns(arg0: &Effect) : u8 {
        arg0.turns
    }

    public fun value(arg0: &Effect) : u32 {
        arg0.value
    }

    public fun value_max(arg0: &Effect) : u32 {
        arg0.value_max
    }

    public fun with_area(arg0: &Effect, arg1: u8, arg2: u8) : Effect {
        let v0 = *arg0;
        v0.area_shape = arg1;
        v0.area_size = arg2;
        v0
    }

    // decompiled from Move bytecode v7
}

