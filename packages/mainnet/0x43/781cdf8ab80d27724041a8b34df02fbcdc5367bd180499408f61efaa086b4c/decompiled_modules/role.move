module 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role {
    struct Global has key {
        id: 0x2::object::UID,
        charactors: 0x2::vec_map::VecMap<0x1::string::String, Role>,
    }

    struct Role has copy, drop, store {
        class: 0x1::string::String,
        attack: u64,
        hp: u64,
        sp: u8,
        level: u8,
        gold_cost: u8,
        sp_cap: u8,
        effect: 0x1::string::String,
        effect_value: 0x1::string::String,
        effect_type: 0x1::string::String,
    }

    public fun empty() : Role {
        Role{
            class        : 0x1::string::utf8(b"none"),
            attack       : 0,
            hp           : 0,
            sp           : 0,
            level        : 0,
            gold_cost    : 0,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b""),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b""),
        }
    }

    public fun check_roles_equality(arg0: &vector<Role>, arg1: &vector<Role>) : bool {
        assert!(0x1::vector::length<Role>(arg0) == 6, 1);
        assert!(0x1::vector::length<Role>(arg1) == 6, 1);
        let v0 = 0;
        while (v0 < 6) {
            let v1 = 0x1::vector::borrow<Role>(arg0, v0);
            let v2 = 0x1::vector::borrow<Role>(arg1, v0);
            if (v1.class == 0x1::string::utf8(b"none") && v2.class == 0x1::string::utf8(b"none")) {
                v0 = v0 + 1;
                continue
            };
            assert!(v1.class == v2.class, 2);
            assert!(v1.hp == v2.hp, 3);
            assert!(v1.attack == v2.attack, 4);
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun create_random_role_for_cards(arg0: &Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Role {
        let v0 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_random_num(0, 1000, arg1, arg2);
        get_random_role_by_level(arg0, 1, v0, arg2)
    }

    public fun get_attack(arg0: &Role) : u64 {
        arg0.attack
    }

    public fun get_class(arg0: &Role) : 0x1::string::String {
        arg0.class
    }

    public fun get_effect(arg0: &Role) : 0x1::string::String {
        arg0.effect
    }

    public fun get_effect_type(arg0: &Role) : 0x1::string::String {
        arg0.effect_type
    }

    public fun get_effect_value(arg0: &Role) : 0x1::string::String {
        arg0.effect_value
    }

    public fun get_gold_cost(arg0: &Role) : u8 {
        let v0 = arg0.level;
        if (v0 == 1) {
            3
        } else if (v0 == 2) {
            5
        } else {
            6
        }
    }

    public fun get_hp(arg0: &Role) : u64 {
        arg0.hp
    }

    public fun get_level(arg0: &Role) : u8 {
        arg0.level
    }

    fun get_random_role_by_level(arg0: &Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Role {
        if (arg1 == 3) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, Role>(&arg0.charactors, 2 + 5 * arg2 % 0x2::vec_map::size<0x1::string::String, Role>(&arg0.charactors) / 5);
            *v2
        } else if (arg1 == 9) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, Role>(&arg0.charactors, 4 + 5 * arg2 % 0x2::vec_map::size<0x1::string::String, Role>(&arg0.charactors) / 5);
            *v4
        } else {
            let (_, v6) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, Role>(&arg0.charactors, 5 * arg2 % 0x2::vec_map::size<0x1::string::String, Role>(&arg0.charactors) / 5);
            *v6
        }
    }

    public(friend) fun get_random_role_by_power(arg0: &Global, arg1: u8, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Role {
        let v0 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_random_num(0, 1000, arg1, arg4);
        if (v0 < arg3) {
            get_random_role_by_level(arg0, 9, v0, arg4)
        } else if (v0 < arg2) {
            get_random_role_by_level(arg0, 3, v0, arg4)
        } else {
            get_random_role_by_level(arg0, 1, v0, arg4)
        }
    }

    public fun get_role_by_class(arg0: &Global, arg1: 0x1::string::String) : Role {
        0x1::debug::print<0x1::string::String>(&arg1);
        *0x2::vec_map::get<0x1::string::String, Role>(&arg0.charactors, &arg1)
    }

    public fun get_sell_gold_cost(arg0: &Role) : u8 {
        let v0 = arg0.level;
        if (v0 < 3) {
            2
        } else if (v0 < 9) {
            6
        } else {
            8
        }
    }

    public fun get_sp(arg0: &Role) : u8 {
        arg0.sp
    }

    public fun get_sp_cap(arg0: &Role) : u8 {
        arg0.sp_cap
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id         : 0x2::object::new(arg0),
            charactors : 0x2::vec_map::empty<0x1::string::String, Role>(),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun init_charactors1(arg0: &mut Global) {
        let v0 = Role{
            class        : 0x1::string::utf8(b"assa1"),
            attack       : 6,
            hp           : 8,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa1"), v0);
        let v1 = Role{
            class        : 0x1::string::utf8(b"assa1_1"),
            attack       : 6,
            hp           : 8,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa1_1"), v1);
        let v2 = Role{
            class        : 0x1::string::utf8(b"assa2"),
            attack       : 12,
            hp           : 15,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"12"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa2"), v2);
        let v3 = Role{
            class        : 0x1::string::utf8(b"assa2_1"),
            attack       : 12,
            hp           : 15,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"12"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa2_1"), v3);
        let v4 = Role{
            class        : 0x1::string::utf8(b"assa3"),
            attack       : 24,
            hp           : 37,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"18"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa3"), v4);
        let v5 = Role{
            class        : 0x1::string::utf8(b"cleric1"),
            attack       : 3,
            hp           : 8,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric1"), v5);
        let v6 = Role{
            class        : 0x1::string::utf8(b"cleric1_1"),
            attack       : 3,
            hp           : 8,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric1_1"), v6);
        let v7 = Role{
            class        : 0x1::string::utf8(b"cleric2"),
            attack       : 6,
            hp           : 15,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric2"), v7);
        let v8 = Role{
            class        : 0x1::string::utf8(b"cleric2_1"),
            attack       : 6,
            hp           : 15,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric2_1"), v8);
        let v9 = Role{
            class        : 0x1::string::utf8(b"cleric3"),
            attack       : 12,
            hp           : 37,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric3"), v9);
        let v10 = Role{
            class        : 0x1::string::utf8(b"fighter1"),
            attack       : 4,
            hp           : 9,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter1"), v10);
        let v11 = Role{
            class        : 0x1::string::utf8(b"fighter1_1"),
            attack       : 4,
            hp           : 9,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter1_1"), v11);
        let v12 = Role{
            class        : 0x1::string::utf8(b"fighter2"),
            attack       : 12,
            hp           : 18,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter2"), v12);
        let v13 = Role{
            class        : 0x1::string::utf8(b"fighter2_1"),
            attack       : 12,
            hp           : 18,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter2_1"), v13);
        let v14 = Role{
            class        : 0x1::string::utf8(b"fighter3"),
            attack       : 24,
            hp           : 45,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter3"), v14);
        let v15 = Role{
            class        : 0x1::string::utf8(b"golem1"),
            attack       : 4,
            hp           : 12,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem1"), v15);
        let v16 = Role{
            class        : 0x1::string::utf8(b"golem1_1"),
            attack       : 4,
            hp           : 12,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem1_1"), v16);
        let v17 = Role{
            class        : 0x1::string::utf8(b"golem2"),
            attack       : 8,
            hp           : 24,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem2"), v17);
        let v18 = Role{
            class        : 0x1::string::utf8(b"golem2_1"),
            attack       : 8,
            hp           : 24,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem2_1"), v18);
        let v19 = Role{
            class        : 0x1::string::utf8(b"golem3"),
            attack       : 16,
            hp           : 60,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem3"), v19);
        let v20 = Role{
            class        : 0x1::string::utf8(b"tank1"),
            attack       : 3,
            hp           : 12,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank1"), v20);
        let v21 = Role{
            class        : 0x1::string::utf8(b"tank1_1"),
            attack       : 3,
            hp           : 12,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank1_1"), v21);
        let v22 = Role{
            class        : 0x1::string::utf8(b"tank2"),
            attack       : 6,
            hp           : 24,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank2"), v22);
        let v23 = Role{
            class        : 0x1::string::utf8(b"tank2_1"),
            attack       : 6,
            hp           : 24,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank2_1"), v23);
        let v24 = Role{
            class        : 0x1::string::utf8(b"tank3"),
            attack       : 12,
            hp           : 60,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank3"), v24);
        let v25 = Role{
            class        : 0x1::string::utf8(b"mega1"),
            attack       : 4,
            hp           : 11,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega1"), v25);
        let v26 = Role{
            class        : 0x1::string::utf8(b"mega1_1"),
            attack       : 4,
            hp           : 11,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega1_1"), v26);
        let v27 = Role{
            class        : 0x1::string::utf8(b"mega2"),
            attack       : 8,
            hp           : 21,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega2"), v27);
        let v28 = Role{
            class        : 0x1::string::utf8(b"mega2_1"),
            attack       : 8,
            hp           : 21,
            sp           : 0,
            level        : 6,
            gold_cost    : 8,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega2_1"), v28);
        let v29 = Role{
            class        : 0x1::string::utf8(b"mega3"),
            attack       : 16,
            hp           : 50,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"16"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega3"), v29);
        let v30 = Role{
            class        : 0x1::string::utf8(b"shaman1"),
            attack       : 5,
            hp           : 9,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman1"), v30);
        let v31 = Role{
            class        : 0x1::string::utf8(b"shaman1_1"),
            attack       : 5,
            hp           : 9,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman1_1"), v31);
        let v32 = Role{
            class        : 0x1::string::utf8(b"shaman2"),
            attack       : 10,
            hp           : 21,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman2"), v32);
        let v33 = Role{
            class        : 0x1::string::utf8(b"shaman2_1"),
            attack       : 10,
            hp           : 21,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman2_1"), v33);
        let v34 = Role{
            class        : 0x1::string::utf8(b"shaman3"),
            attack       : 20,
            hp           : 65,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman3"), v34);
        let v35 = Role{
            class        : 0x1::string::utf8(b"firemega1"),
            attack       : 6,
            hp           : 8,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega1"), v35);
        let v36 = Role{
            class        : 0x1::string::utf8(b"firemega1_1"),
            attack       : 6,
            hp           : 8,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega1_1"), v36);
        let v37 = Role{
            class        : 0x1::string::utf8(b"firemega2"),
            attack       : 12,
            hp           : 15,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega2"), v37);
        let v38 = Role{
            class        : 0x1::string::utf8(b"firemega2_1"),
            attack       : 12,
            hp           : 15,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega2_1"), v38);
        let v39 = Role{
            class        : 0x1::string::utf8(b"firemega3"),
            attack       : 24,
            hp           : 37,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega3"), v39);
    }

    public fun init_charactors2(arg0: &mut Global) {
        let v0 = Role{
            class        : 0x1::string::utf8(b"slime1"),
            attack       : 6,
            hp           : 9,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime1"), v0);
        let v1 = Role{
            class        : 0x1::string::utf8(b"slime1_1"),
            attack       : 6,
            hp           : 9,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime1_1"), v1);
        let v2 = Role{
            class        : 0x1::string::utf8(b"slime2"),
            attack       : 10,
            hp           : 30,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime2"), v2);
        let v3 = Role{
            class        : 0x1::string::utf8(b"slime2_1"),
            attack       : 10,
            hp           : 30,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime2_1"), v3);
        let v4 = Role{
            class        : 0x1::string::utf8(b"slime3"),
            attack       : 20,
            hp           : 65,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"10"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime3"), v4);
        let v5 = Role{
            class        : 0x1::string::utf8(b"ani1"),
            attack       : 4,
            hp           : 12,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani1"), v5);
        let v6 = Role{
            class        : 0x1::string::utf8(b"ani1_1"),
            attack       : 4,
            hp           : 12,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani1_1"), v6);
        let v7 = Role{
            class        : 0x1::string::utf8(b"ani2"),
            attack       : 8,
            hp           : 24,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani2"), v7);
        let v8 = Role{
            class        : 0x1::string::utf8(b"ani2_1"),
            attack       : 8,
            hp           : 24,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani2_1"), v8);
        let v9 = Role{
            class        : 0x1::string::utf8(b"ani3"),
            attack       : 16,
            hp           : 60,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"9"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani3"), v9);
        let v10 = Role{
            class        : 0x1::string::utf8(b"tree1"),
            attack       : 5,
            hp           : 11,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree1"), v10);
        let v11 = Role{
            class        : 0x1::string::utf8(b"tree1_1"),
            attack       : 5,
            hp           : 11,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree1_1"), v11);
        let v12 = Role{
            class        : 0x1::string::utf8(b"tree2"),
            attack       : 10,
            hp           : 21,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree2"), v12);
        let v13 = Role{
            class        : 0x1::string::utf8(b"tree2_1"),
            attack       : 10,
            hp           : 21,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree2_1"), v13);
        let v14 = Role{
            class        : 0x1::string::utf8(b"tree3"),
            attack       : 20,
            hp           : 50,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"9"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree3"), v14);
        let v15 = Role{
            class        : 0x1::string::utf8(b"wizard1"),
            attack       : 5,
            hp           : 9,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp_cap"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard1"), v15);
        let v16 = Role{
            class        : 0x1::string::utf8(b"wizard1_1"),
            attack       : 5,
            hp           : 9,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp_cap"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard1_1"), v16);
        let v17 = Role{
            class        : 0x1::string::utf8(b"wizard2"),
            attack       : 10,
            hp           : 18,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp_cap"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard2"), v17);
        let v18 = Role{
            class        : 0x1::string::utf8(b"wizard2_1"),
            attack       : 10,
            hp           : 18,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp_cap"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard2_1"), v18);
        let v19 = Role{
            class        : 0x1::string::utf8(b"wizard3"),
            attack       : 20,
            hp           : 45,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_sp_cap"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard3"), v19);
        let v20 = Role{
            class        : 0x1::string::utf8(b"priest1"),
            attack       : 3,
            hp           : 12,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest1"), v20);
        let v21 = Role{
            class        : 0x1::string::utf8(b"priest1_1"),
            attack       : 3,
            hp           : 12,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest1_1"), v21);
        let v22 = Role{
            class        : 0x1::string::utf8(b"priest2"),
            attack       : 6,
            hp           : 24,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest2"), v22);
        let v23 = Role{
            class        : 0x1::string::utf8(b"priest2_1"),
            attack       : 6,
            hp           : 24,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest2_1"), v23);
        let v24 = Role{
            class        : 0x1::string::utf8(b"priest3"),
            attack       : 12,
            hp           : 60,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"12"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest3"), v24);
        let v25 = Role{
            class        : 0x1::string::utf8(b"shinobi1"),
            attack       : 4,
            hp           : 12,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"attack_by_hp_percent"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi1"), v25);
        let v26 = Role{
            class        : 0x1::string::utf8(b"shinobi1_1"),
            attack       : 4,
            hp           : 12,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"attack_by_hp_percent"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi1_1"), v26);
        let v27 = Role{
            class        : 0x1::string::utf8(b"shinobi2"),
            attack       : 8,
            hp           : 24,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_by_hp_percent"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi2"), v27);
        let v28 = Role{
            class        : 0x1::string::utf8(b"shinobi2_1"),
            attack       : 8,
            hp           : 24,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_by_hp_percent"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi2_1"), v28);
        let v29 = Role{
            class        : 0x1::string::utf8(b"shinobi3"),
            attack       : 16,
            hp           : 60,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"attack_by_hp_percent"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi3"), v29);
        let v30 = Role{
            class        : 0x1::string::utf8(b"kunoichi1"),
            attack       : 6,
            hp           : 9,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi1"), v30);
        let v31 = Role{
            class        : 0x1::string::utf8(b"kunoichi1_1"),
            attack       : 6,
            hp           : 9,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi1_1"), v31);
        let v32 = Role{
            class        : 0x1::string::utf8(b"kunoichi2"),
            attack       : 12,
            hp           : 18,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi2"), v32);
        let v33 = Role{
            class        : 0x1::string::utf8(b"kunoichi2_1"),
            attack       : 12,
            hp           : 18,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi2_1"), v33);
        let v34 = Role{
            class        : 0x1::string::utf8(b"kunoichi3"),
            attack       : 24,
            hp           : 45,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi3"), v34);
        let v35 = Role{
            class        : 0x1::string::utf8(b"archer1"),
            attack       : 6,
            hp           : 9,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"7"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer1"), v35);
        let v36 = Role{
            class        : 0x1::string::utf8(b"archer1_1"),
            attack       : 6,
            hp           : 9,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"7"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer1_1"), v36);
        let v37 = Role{
            class        : 0x1::string::utf8(b"archer2"),
            attack       : 12,
            hp           : 18,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"14"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer2"), v37);
        let v38 = Role{
            class        : 0x1::string::utf8(b"archer2_1"),
            attack       : 12,
            hp           : 18,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"14"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer2_1"), v38);
        let v39 = Role{
            class        : 0x1::string::utf8(b"archer3"),
            attack       : 24,
            hp           : 45,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 1,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"24"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer3"), v39);
    }

    public fun init_role() : Role {
        Role{
            class        : 0x1::string::utf8(b"init"),
            attack       : 0,
            hp           : 0,
            sp           : 0,
            level        : 0,
            gold_cost    : 0,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b""),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b""),
        }
    }

    public fun set_attack(arg0: &mut Role, arg1: u64) {
        arg0.attack = arg1;
    }

    public fun set_class(arg0: &mut Role, arg1: 0x1::string::String) {
        arg0.class = arg1;
    }

    public fun set_hp(arg0: &mut Role, arg1: u64) {
        arg0.hp = arg1;
    }

    public fun set_level(arg0: &mut Role, arg1: u8) {
        arg0.level = arg1;
    }

    public fun set_sp(arg0: &mut Role, arg1: u8) {
        arg0.sp = arg1;
    }

    public fun upgrade(arg0: &Global, arg1: &Role, arg2: &mut Role) : bool {
        if (0x1::string::sub_string(&arg1.class, 0, 3) != 0x1::string::sub_string(&arg2.class, 0, 3)) {
            return false
        };
        let v0 = arg1.level;
        let v1 = v0;
        let v2 = arg2.level;
        let v3 = v2;
        let v4 = arg1.hp;
        let v5 = v4;
        let v6 = arg2.hp;
        let v7 = v6;
        let v8 = arg1.attack;
        let v9 = v8;
        let v10 = arg2.attack;
        let v11 = v10;
        if (v0 > v2) {
            v7 = v4;
            v5 = v6;
            v11 = v8;
            v9 = v10;
            v3 = v0;
            v1 = v2;
        };
        if (v1 < 9 && v3 < 9) {
            let v12 = v1 + v3;
            let v13 = v12;
            if (v12 > 9) {
                v13 = 9;
            };
            arg2.level = v13;
            let v14 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::removeSuffix(arg2.class);
            let v15 = get_role_by_class(arg0, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_class_by_level(v14, v1));
            let v16 = get_role_by_class(arg0, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_class_by_level(v14, v3));
            let v17 = v5 - v15.hp;
            let v18 = v7 - v16.hp;
            let v19 = if (v17 > v18) {
                v17
            } else {
                v18
            };
            let v20 = v9 - v15.attack;
            let v21 = v11 - v16.attack;
            let v22 = if (v20 > v21) {
                v20
            } else {
                v21
            };
            let v23 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_class_by_level(v14, v13);
            let v24 = get_role_by_class(arg0, v23);
            arg2.class = v23;
            arg2.sp_cap = v24.sp_cap;
            arg2.gold_cost = v24.gold_cost;
            arg2.attack = v24.attack + v22;
            arg2.hp = v24.hp + v19;
            arg2.effect_value = v24.effect_value;
            return true
        };
        false
    }

    // decompiled from Move bytecode v6
}

