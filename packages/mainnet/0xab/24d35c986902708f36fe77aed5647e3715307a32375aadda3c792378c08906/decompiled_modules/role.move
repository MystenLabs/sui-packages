module 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role {
    struct Global has key {
        id: 0x2::object::UID,
        charactors: 0x2::vec_map::VecMap<0x1::string::String, Role>,
    }

    struct Role has copy, drop, store {
        class: 0x1::string::String,
        attack: u64,
        hp: u64,
        speed: u64,
        sp: u8,
        level: u8,
        gold_cost: u8,
        sp_cap: u8,
        effect: 0x1::string::String,
        effect_value: 0x1::string::String,
        effect_type: 0x1::string::String,
    }

    public fun empty() : Role {
        new_role(0x1::string::utf8(b"none"), 0, 0, 0, 0, 0, 0, 0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""))
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
            assert!(v1.level == v2.level, 4);
            v0 = v0 + 1;
        };
        true
    }

    public fun create_random_role_for_cards(arg0: &Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Role {
        let v0 = 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_random_num(0, 1000, arg1, arg2);
        get_random_role_by_level(arg0, 1, v0, arg2)
    }

    public fun decrease_hp(arg0: &mut Role, arg1: u64) {
        arg0.hp = arg0.hp - arg1;
    }

    public fun delete_role_global(arg0: Global) {
        let Global {
            id         : v0,
            charactors : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun generate_role_global(arg0: &mut 0x2::tx_context::TxContext) : Global {
        let v0 = Global{
            id         : 0x2::object::new(arg0),
            charactors : 0x2::vec_map::empty<0x1::string::String, Role>(),
        };
        let v1 = &mut v0;
        init_charactors1(v1);
        let v2 = &mut v0;
        init_charactors2(v2);
        v0
    }

    public fun get_attack(arg0: &Role) : u64 {
        arg0.attack
    }

    public fun get_chars_keys(arg0: &Global) : vector<0x1::string::String> {
        0x2::vec_map::keys<0x1::string::String, Role>(&arg0.charactors)
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
        if (arg1 == 1) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, Role>(&arg0.charactors, 5 * arg2 % 0x2::vec_map::size<0x1::string::String, Role>(&arg0.charactors) / 5);
            *v2
        } else {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, Role>(&arg0.charactors, arg1 / 3 + 1 + 5 * arg2 % 0x2::vec_map::size<0x1::string::String, Role>(&arg0.charactors) / 5);
            *v4
        }
    }

    public fun get_random_role_by_power(arg0: &Global, arg1: u8, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Role {
        let v0 = 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_random_num(0, 1000, arg1, arg4);
        if (v0 < arg3) {
            get_random_role_by_level(arg0, 9, v0, arg4)
        } else if (v0 < arg2) {
            get_random_role_by_level(arg0, 3, v0, arg4)
        } else {
            get_random_role_by_level(arg0, 1, v0, arg4)
        }
    }

    public fun get_role_by_class(arg0: &Global, arg1: 0x1::string::String) : Role {
        *0x2::vec_map::get<0x1::string::String, Role>(&arg0.charactors, &arg1)
    }

    public fun get_sell_gold_cost(arg0: &Role) : u8 {
        let v0 = arg0.level;
        if (v0 < 3) {
            2
        } else if (v0 < 6) {
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

    public fun get_speed(arg0: &Role) : u64 {
        arg0.speed
    }

    public fun increase_attack(arg0: &mut Role, arg1: u64) {
        arg0.attack = arg0.attack + arg1;
    }

    public fun increase_hp(arg0: &mut Role, arg1: u64) {
        arg0.hp = arg0.hp + arg1;
    }

    public fun increase_speed(arg0: &mut Role, arg1: u64) {
        arg0.speed = arg0.speed + arg1;
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
            speed        : 10,
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
            speed        : 10,
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
            speed        : 12,
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
            speed        : 12,
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
            speed        : 14,
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
            speed        : 5,
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
            speed        : 5,
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
            speed        : 7,
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
            speed        : 7,
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
            speed        : 10,
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
            speed        : 6,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter1"), v10);
        let v11 = Role{
            class        : 0x1::string::utf8(b"fighter1_1"),
            attack       : 4,
            hp           : 9,
            speed        : 6,
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
            speed        : 8,
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
            speed        : 8,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter2_1"), v13);
        let v14 = Role{
            class        : 0x1::string::utf8(b"fighter3"),
            attack       : 24,
            hp           : 45,
            speed        : 12,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 2,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter3"), v14);
        let v15 = Role{
            class        : 0x1::string::utf8(b"golem1"),
            attack       : 4,
            hp           : 12,
            speed        : 4,
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
            speed        : 4,
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
            speed        : 8,
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
            speed        : 8,
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
            speed        : 13,
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
            speed        : 4,
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
            speed        : 4,
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
            speed        : 6,
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
            speed        : 6,
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
            speed        : 8,
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
            speed        : 6,
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
            speed        : 6,
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
            speed        : 8,
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
            speed        : 8,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
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
            speed        : 10,
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
            speed        : 6,
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
            speed        : 6,
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
            speed        : 8,
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
            speed        : 8,
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
            speed        : 10,
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
            speed        : 5,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega1"), v35);
        let v36 = Role{
            class        : 0x1::string::utf8(b"firemega1_1"),
            attack       : 6,
            hp           : 8,
            speed        : 5,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega1_1"), v36);
        let v37 = Role{
            class        : 0x1::string::utf8(b"firemega2"),
            attack       : 12,
            hp           : 15,
            speed        : 9,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega2"), v37);
        let v38 = Role{
            class        : 0x1::string::utf8(b"firemega2_1"),
            attack       : 12,
            hp           : 15,
            speed        : 9,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega2_1"), v38);
        let v39 = Role{
            class        : 0x1::string::utf8(b"firemega3"),
            attack       : 24,
            hp           : 37,
            speed        : 11,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 0,
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
            speed        : 5,
            sp           : 0,
            level        : 1,
            gold_cost    : 3,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime1"), v0);
        let v1 = Role{
            class        : 0x1::string::utf8(b"slime1_1"),
            attack       : 6,
            hp           : 9,
            speed        : 5,
            sp           : 0,
            level        : 2,
            gold_cost    : 5,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime1_1"), v1);
        let v2 = Role{
            class        : 0x1::string::utf8(b"slime2"),
            attack       : 10,
            hp           : 30,
            speed        : 7,
            sp           : 0,
            level        : 3,
            gold_cost    : 8,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime2"), v2);
        let v3 = Role{
            class        : 0x1::string::utf8(b"slime2_1"),
            attack       : 10,
            hp           : 30,
            speed        : 7,
            sp           : 0,
            level        : 6,
            gold_cost    : 9,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime2_1"), v3);
        let v4 = Role{
            class        : 0x1::string::utf8(b"slime3"),
            attack       : 20,
            hp           : 65,
            speed        : 10,
            sp           : 0,
            level        : 9,
            gold_cost    : 10,
            sp_cap       : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime3"), v4);
        let v5 = Role{
            class        : 0x1::string::utf8(b"ani1"),
            attack       : 4,
            hp           : 12,
            speed        : 7,
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
            speed        : 7,
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
            speed        : 8,
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
            speed        : 8,
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
            speed        : 9,
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
            speed        : 7,
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
            speed        : 7,
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
            speed        : 8,
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
            speed        : 8,
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
            speed        : 10,
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
            speed        : 7,
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
            speed        : 7,
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
            speed        : 9,
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
            speed        : 9,
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
            speed        : 12,
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
            speed        : 4,
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
            speed        : 4,
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
            speed        : 6,
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
            speed        : 6,
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
            speed        : 9,
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
            speed        : 6,
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
            speed        : 6,
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
            speed        : 8,
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
            speed        : 8,
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
            speed        : 10,
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
            speed        : 8,
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
            speed        : 8,
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
            speed        : 10,
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
            speed        : 10,
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
            speed        : 12,
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
            speed        : 7,
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
            speed        : 7,
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
            speed        : 9,
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
            speed        : 9,
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
            speed        : 12,
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

    public fun new_role(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String) : Role {
        Role{
            class        : arg0,
            attack       : arg1,
            hp           : arg2,
            speed        : arg3,
            sp           : arg4,
            level        : arg5,
            gold_cost    : arg6,
            sp_cap       : arg7,
            effect       : arg8,
            effect_value : arg9,
            effect_type  : arg10,
        }
    }

    public fun new_role_from_reference(arg0: &Role) : Role {
        Role{
            class        : arg0.class,
            attack       : arg0.attack,
            hp           : arg0.hp,
            speed        : arg0.speed,
            sp           : arg0.sp,
            level        : arg0.level,
            gold_cost    : arg0.gold_cost,
            sp_cap       : arg0.sp_cap,
            effect       : arg0.effect,
            effect_value : arg0.effect_value,
            effect_type  : arg0.effect_type,
        }
    }

    public fun permenant_increase_role_hp(arg0: &mut vector<Role>, arg1: &0x2::vec_map::VecMap<0x1::string::String, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::Int_wrapper>) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::Int_wrapper>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&v0, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<Role>(arg0)) {
                if (&0x1::vector::borrow_mut<Role>(arg0, v3).class == v2) {
                    let v4 = 0x1::vector::borrow_mut<Role>(arg0, v3);
                    increase_hp(v4, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_int(0x2::vec_map::get<0x1::string::String, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::Int_wrapper>(arg1, v2)));
                    break
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun print_role(arg0: &Role) {
        let v0 = arg0.class;
        0x1::string::append(&mut v0, 0x1::string::utf8(b", level: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u8_to_string(arg0.level));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", attack: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.attack));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", hp: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.hp));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", speed: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.speed));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", sp: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u8_to_string(arg0.sp));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", sp_cap: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u8_to_string(arg0.sp_cap));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", effect: "));
        0x1::string::append(&mut v0, arg0.effect);
        0x1::string::append(&mut v0, 0x1::string::utf8(b", effect_type: "));
        0x1::string::append(&mut v0, arg0.effect_type);
        0x1::string::append(&mut v0, 0x1::string::utf8(b", effect_value: "));
        0x1::string::append(&mut v0, arg0.effect_value);
        0x1::string::append(&mut v0, 0x1::string::utf8(b", gold_cost: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u8_to_string(arg0.gold_cost));
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public fun print_role_short(arg0: &Role) {
        let v0 = arg0.class;
        0x1::string::append(&mut v0, 0x1::string::utf8(b", attack: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.attack));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", hp: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.hp));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", speed: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.speed));
        0x1::string::append(&mut v0, 0x1::string::utf8(b", sp: "));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u8_to_string(arg0.sp));
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public fun print_roles(arg0: &vector<Role>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Role>(arg0)) {
            print_role(0x1::vector::borrow<Role>(arg0, v0));
            v0 = v0 + 1;
        };
    }

    public fun print_roles_short(arg0: &vector<Role>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Role>(arg0)) {
            print_role_short(0x1::vector::borrow<Role>(arg0, v0));
            v0 = v0 + 1;
        };
    }

    public fun remove_none_roles(arg0: &mut vector<Role>) {
        let v0 = 0x1::vector::length<Role>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            if (get_class(0x1::vector::borrow<Role>(arg0, v1)) == 0x1::string::utf8(b"none")) {
                0x1::vector::remove<Role>(arg0, v1);
                v0 = v0 - 1;
                continue
            };
            v1 = v1 + 1;
        };
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

    public fun set_role(arg0: &mut Role, arg1: &Role) {
        arg0.class = arg1.class;
        arg0.attack = arg1.attack;
        arg0.hp = arg1.hp;
        arg0.speed = arg1.speed;
        arg0.sp = arg1.sp;
        arg0.level = arg1.level;
        arg0.gold_cost = arg1.gold_cost;
        arg0.sp_cap = arg1.sp_cap;
        arg0.effect = arg1.effect;
        arg0.effect_value = arg1.effect_value;
        arg0.effect_type = arg1.effect_type;
    }

    public fun set_sp(arg0: &mut Role, arg1: u8) {
        arg0.sp = arg1;
    }

    public fun upgrade(arg0: &Global, arg1: &Role, arg2: &mut Role) : bool {
        if (0x1::string::sub_string(&arg1.class, 0, 3) != 0x1::string::sub_string(&arg2.class, 0, 3)) {
            return false
        };
        let v0 = arg1.level;
        let v1 = arg2.level;
        if (v0 < 9 && v1 < 9) {
            let v2 = if (v0 + v1 < 9) {
                v0 + v1
            } else {
                9
            };
            let v3 = v2;
            0x1::debug::print<u8>(&v3);
            let v4 = get_role_by_class(arg0, arg1.class);
            let v5 = get_role_by_class(arg0, arg2.class);
            let v6 = arg1.hp - v4.hp;
            let v7 = arg2.hp - v5.hp;
            let v8 = if (v6 > v7) {
                v6
            } else {
                v7
            };
            let v9 = 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_class_by_level(0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::removeSuffix(arg2.class), v3);
            0x1::debug::print<0x1::string::String>(&v9);
            let v10 = get_role_by_class(arg0, v9);
            set_role(arg2, &v10);
            increase_hp(arg2, v8);
            arg2.level = v3;
            return true
        };
        false
    }

    // decompiled from Move bytecode v6
}

