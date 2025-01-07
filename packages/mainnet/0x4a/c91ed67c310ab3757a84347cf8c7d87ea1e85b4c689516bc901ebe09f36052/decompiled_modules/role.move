module 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role {
    struct Global has key {
        id: 0x2::object::UID,
        charactors: 0x2::vec_map::VecMap<0x1::string::String, Role>,
    }

    struct Role has copy, drop, store {
        name: 0x1::string::String,
        attack: u64,
        life: u64,
        magic: u8,
        level: u8,
        price: u8,
        max_magic: u8,
        effect: 0x1::string::String,
        effect_value: 0x1::string::String,
        effect_type: 0x1::string::String,
    }

    public fun empty() : Role {
        Role{
            name         : 0x1::string::utf8(b"none"),
            attack       : 0,
            life         : 0,
            magic        : 0,
            level        : 0,
            price        : 0,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b""),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b""),
        }
    }

    public fun check_roles_equal(arg0: &vector<Role>, arg1: &vector<Role>) : bool {
        assert!(0x1::vector::length<Role>(arg0) == 6, 1);
        assert!(0x1::vector::length<Role>(arg1) == 6, 1);
        let v0 = 0;
        while (v0 < 6) {
            let v1 = 0x1::vector::borrow<Role>(arg0, v0);
            let v2 = 0x1::vector::borrow<Role>(arg1, v0);
            if (v1.name == 0x1::string::utf8(b"none") && v2.name == 0x1::string::utf8(b"none")) {
                v0 = v0 + 1;
                continue
            };
            assert!(v1.name == v2.name, 2);
            assert!(v1.life == v2.life, 3);
            assert!(v1.attack == v2.attack, 4);
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun create_random_role_for_cards(arg0: &Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Role {
        let v0 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_random_num(0, 1000, arg1, arg2);
        random_select_role_by_level(arg0, 1, v0, arg2)
    }

    public(friend) fun create_random_role_for_lineup(arg0: &Global, arg1: u8, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Role {
        let v0 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_random_num(0, 1000, arg1, arg4);
        if (v0 < arg3) {
            random_select_role_by_level(arg0, 9, v0, arg4)
        } else if (v0 < arg2) {
            random_select_role_by_level(arg0, 3, v0, arg4)
        } else {
            random_select_role_by_level(arg0, 1, v0, arg4)
        }
    }

    public fun get_attack(arg0: &Role) : u64 {
        arg0.attack
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

    public fun get_level(arg0: &Role) : u8 {
        arg0.level
    }

    public fun get_life(arg0: &Role) : u64 {
        arg0.life
    }

    public fun get_magic(arg0: &Role) : u8 {
        arg0.magic
    }

    public fun get_max_magic(arg0: &Role) : u8 {
        arg0.max_magic
    }

    public fun get_name(arg0: &Role) : 0x1::string::String {
        arg0.name
    }

    public fun get_price(arg0: &Role) : u8 {
        let v0 = arg0.level;
        if (v0 == 1) {
            3
        } else if (v0 == 2) {
            5
        } else {
            6
        }
    }

    public fun get_role_by_name(arg0: &Global, arg1: 0x1::string::String) : Role {
        0x1::debug::print<0x1::string::String>(&arg1);
        *0x2::vec_map::get<0x1::string::String, Role>(&arg0.charactors, &arg1)
    }

    public fun get_sell_price(arg0: &Role) : u8 {
        let v0 = arg0.level;
        if (v0 < 3) {
            2
        } else if (v0 < 9) {
            6
        } else {
            8
        }
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
            name         : 0x1::string::utf8(b"assa1"),
            attack       : 6,
            life         : 8,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa1"), v0);
        let v1 = Role{
            name         : 0x1::string::utf8(b"assa1_1"),
            attack       : 6,
            life         : 8,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa1_1"), v1);
        let v2 = Role{
            name         : 0x1::string::utf8(b"assa2"),
            attack       : 12,
            life         : 15,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"12"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa2"), v2);
        let v3 = Role{
            name         : 0x1::string::utf8(b"assa2_1"),
            attack       : 12,
            life         : 15,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"12"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa2_1"), v3);
        let v4 = Role{
            name         : 0x1::string::utf8(b"assa3"),
            attack       : 24,
            life         : 37,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"attack_lowest_hp"),
            effect_value : 0x1::string::utf8(b"18"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"assa3"), v4);
        let v5 = Role{
            name         : 0x1::string::utf8(b"cleric1"),
            attack       : 3,
            life         : 8,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric1"), v5);
        let v6 = Role{
            name         : 0x1::string::utf8(b"cleric1_1"),
            attack       : 3,
            life         : 8,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric1_1"), v6);
        let v7 = Role{
            name         : 0x1::string::utf8(b"cleric2"),
            attack       : 6,
            life         : 15,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric2"), v7);
        let v8 = Role{
            name         : 0x1::string::utf8(b"cleric2_1"),
            attack       : 6,
            life         : 15,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric2_1"), v8);
        let v9 = Role{
            name         : 0x1::string::utf8(b"cleric3"),
            attack       : 12,
            life         : 37,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"add_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"cleric3"), v9);
        let v10 = Role{
            name         : 0x1::string::utf8(b"fighter1"),
            attack       : 4,
            life         : 9,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter1"), v10);
        let v11 = Role{
            name         : 0x1::string::utf8(b"fighter1_1"),
            attack       : 4,
            life         : 9,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter1_1"), v11);
        let v12 = Role{
            name         : 0x1::string::utf8(b"fighter2"),
            attack       : 12,
            life         : 18,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter2"), v12);
        let v13 = Role{
            name         : 0x1::string::utf8(b"fighter2_1"),
            attack       : 12,
            life         : 18,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter2_1"), v13);
        let v14 = Role{
            name         : 0x1::string::utf8(b"fighter3"),
            attack       : 24,
            life         : 45,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_all_tmp_attack"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"fighter3"), v14);
        let v15 = Role{
            name         : 0x1::string::utf8(b"golem1"),
            attack       : 4,
            life         : 12,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem1"), v15);
        let v16 = Role{
            name         : 0x1::string::utf8(b"golem1_1"),
            attack       : 4,
            life         : 12,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem1_1"), v16);
        let v17 = Role{
            name         : 0x1::string::utf8(b"golem2"),
            attack       : 8,
            life         : 24,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem2"), v17);
        let v18 = Role{
            name         : 0x1::string::utf8(b"golem2_1"),
            attack       : 8,
            life         : 24,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem2_1"), v18);
        let v19 = Role{
            name         : 0x1::string::utf8(b"golem3"),
            attack       : 16,
            life         : 60,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"add_all_tmp_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"golem3"), v19);
        let v20 = Role{
            name         : 0x1::string::utf8(b"tank1"),
            attack       : 3,
            life         : 12,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank1"), v20);
        let v21 = Role{
            name         : 0x1::string::utf8(b"tank1_1"),
            attack       : 3,
            life         : 12,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank1_1"), v21);
        let v22 = Role{
            name         : 0x1::string::utf8(b"tank2"),
            attack       : 6,
            life         : 24,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank2"), v22);
        let v23 = Role{
            name         : 0x1::string::utf8(b"tank2_1"),
            attack       : 6,
            life         : 24,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank2_1"), v23);
        let v24 = Role{
            name         : 0x1::string::utf8(b"tank3"),
            attack       : 12,
            life         : 60,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"add_all_tmp_hp"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tank3"), v24);
        let v25 = Role{
            name         : 0x1::string::utf8(b"mega1"),
            attack       : 4,
            life         : 11,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega1"), v25);
        let v26 = Role{
            name         : 0x1::string::utf8(b"mega1_1"),
            attack       : 4,
            life         : 11,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"4"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega1_1"), v26);
        let v27 = Role{
            name         : 0x1::string::utf8(b"mega2"),
            attack       : 8,
            life         : 21,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega2"), v27);
        let v28 = Role{
            name         : 0x1::string::utf8(b"mega2_1"),
            attack       : 8,
            life         : 21,
            magic        : 0,
            level        : 6,
            price        : 8,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega2_1"), v28);
        let v29 = Role{
            name         : 0x1::string::utf8(b"mega3"),
            attack       : 16,
            life         : 50,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"aoe"),
            effect_value : 0x1::string::utf8(b"16"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"mega3"), v29);
        let v30 = Role{
            name         : 0x1::string::utf8(b"shaman1"),
            attack       : 5,
            life         : 9,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman1"), v30);
        let v31 = Role{
            name         : 0x1::string::utf8(b"shaman1_1"),
            attack       : 5,
            life         : 9,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman1_1"), v31);
        let v32 = Role{
            name         : 0x1::string::utf8(b"shaman2"),
            attack       : 10,
            life         : 21,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman2"), v32);
        let v33 = Role{
            name         : 0x1::string::utf8(b"shaman2_1"),
            attack       : 10,
            life         : 21,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman2_1"), v33);
        let v34 = Role{
            name         : 0x1::string::utf8(b"shaman3"),
            attack       : 20,
            life         : 65,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shaman3"), v34);
        let v35 = Role{
            name         : 0x1::string::utf8(b"firemega1"),
            attack       : 6,
            life         : 8,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega1"), v35);
        let v36 = Role{
            name         : 0x1::string::utf8(b"firemega1_1"),
            attack       : 6,
            life         : 8,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega1_1"), v36);
        let v37 = Role{
            name         : 0x1::string::utf8(b"firemega2"),
            attack       : 12,
            life         : 15,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega2"), v37);
        let v38 = Role{
            name         : 0x1::string::utf8(b"firemega2_1"),
            attack       : 12,
            life         : 15,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega2_1"), v38);
        let v39 = Role{
            name         : 0x1::string::utf8(b"firemega3"),
            attack       : 24,
            life         : 37,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"forbid_debuff"),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"firemega3"), v39);
    }

    public fun init_charactors2(arg0: &mut Global) {
        let v0 = Role{
            name         : 0x1::string::utf8(b"slime1"),
            attack       : 6,
            life         : 9,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime1"), v0);
        let v1 = Role{
            name         : 0x1::string::utf8(b"slime1_1"),
            attack       : 6,
            life         : 9,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime1_1"), v1);
        let v2 = Role{
            name         : 0x1::string::utf8(b"slime2"),
            attack       : 10,
            life         : 30,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime2"), v2);
        let v3 = Role{
            name         : 0x1::string::utf8(b"slime2_1"),
            attack       : 10,
            life         : 30,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime2_1"), v3);
        let v4 = Role{
            name         : 0x1::string::utf8(b"slime3"),
            attack       : 20,
            life         : 65,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"forbid_buff"),
            effect_value : 0x1::string::utf8(b"10"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"slime3"), v4);
        let v5 = Role{
            name         : 0x1::string::utf8(b"ani1"),
            attack       : 4,
            life         : 12,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani1"), v5);
        let v6 = Role{
            name         : 0x1::string::utf8(b"ani1_1"),
            attack       : 4,
            life         : 12,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani1_1"), v6);
        let v7 = Role{
            name         : 0x1::string::utf8(b"ani2"),
            attack       : 8,
            life         : 24,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani2"), v7);
        let v8 = Role{
            name         : 0x1::string::utf8(b"ani2_1"),
            attack       : 8,
            life         : 24,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani2_1"), v8);
        let v9 = Role{
            name         : 0x1::string::utf8(b"ani3"),
            attack       : 16,
            life         : 60,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"9"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"ani3"), v9);
        let v10 = Role{
            name         : 0x1::string::utf8(b"tree1"),
            attack       : 5,
            life         : 11,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree1"), v10);
        let v11 = Role{
            name         : 0x1::string::utf8(b"tree1_1"),
            attack       : 5,
            life         : 11,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree1_1"), v11);
        let v12 = Role{
            name         : 0x1::string::utf8(b"tree2"),
            attack       : 10,
            life         : 21,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree2"), v12);
        let v13 = Role{
            name         : 0x1::string::utf8(b"tree2_1"),
            attack       : 10,
            life         : 21,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree2_1"), v13);
        let v14 = Role{
            name         : 0x1::string::utf8(b"tree3"),
            attack       : 20,
            life         : 50,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"reduce_tmp_attack"),
            effect_value : 0x1::string::utf8(b"9"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"tree3"), v14);
        let v15 = Role{
            name         : 0x1::string::utf8(b"wizard1"),
            attack       : 5,
            life         : 9,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_max_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard1"), v15);
        let v16 = Role{
            name         : 0x1::string::utf8(b"wizard1_1"),
            attack       : 5,
            life         : 9,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_max_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard1_1"), v16);
        let v17 = Role{
            name         : 0x1::string::utf8(b"wizard2"),
            attack       : 10,
            life         : 18,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_max_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard2"), v17);
        let v18 = Role{
            name         : 0x1::string::utf8(b"wizard2_1"),
            attack       : 10,
            life         : 18,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_max_magic"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard2_1"), v18);
        let v19 = Role{
            name         : 0x1::string::utf8(b"wizard3"),
            attack       : 20,
            life         : 45,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b"add_all_tmp_max_magic"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"ring"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"wizard3"), v19);
        let v20 = Role{
            name         : 0x1::string::utf8(b"priest1"),
            attack       : 3,
            life         : 12,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest1"), v20);
        let v21 = Role{
            name         : 0x1::string::utf8(b"priest1_1"),
            attack       : 3,
            life         : 12,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"6"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest1_1"), v21);
        let v22 = Role{
            name         : 0x1::string::utf8(b"priest2"),
            attack       : 6,
            life         : 24,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest2"), v22);
        let v23 = Role{
            name         : 0x1::string::utf8(b"priest2_1"),
            attack       : 6,
            life         : 24,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"8"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest2_1"), v23);
        let v24 = Role{
            name         : 0x1::string::utf8(b"priest3"),
            attack       : 12,
            life         : 60,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"all_max_hp_to_back1"),
            effect_value : 0x1::string::utf8(b"12"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"priest3"), v24);
        let v25 = Role{
            name         : 0x1::string::utf8(b"shinobi1"),
            attack       : 4,
            life         : 12,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"attack_by_life_percent"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi1"), v25);
        let v26 = Role{
            name         : 0x1::string::utf8(b"shinobi1_1"),
            attack       : 4,
            life         : 12,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"attack_by_life_percent"),
            effect_value : 0x1::string::utf8(b"1"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi1_1"), v26);
        let v27 = Role{
            name         : 0x1::string::utf8(b"shinobi2"),
            attack       : 8,
            life         : 24,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_by_life_percent"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi2"), v27);
        let v28 = Role{
            name         : 0x1::string::utf8(b"shinobi2_1"),
            attack       : 8,
            life         : 24,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_by_life_percent"),
            effect_value : 0x1::string::utf8(b"2"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi2_1"), v28);
        let v29 = Role{
            name         : 0x1::string::utf8(b"shinobi3"),
            attack       : 16,
            life         : 60,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"attack_by_life_percent"),
            effect_value : 0x1::string::utf8(b"3"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"shinobi3"), v29);
        let v30 = Role{
            name         : 0x1::string::utf8(b"kunoichi1"),
            attack       : 6,
            life         : 9,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi1"), v30);
        let v31 = Role{
            name         : 0x1::string::utf8(b"kunoichi1_1"),
            attack       : 6,
            life         : 9,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi1_1"), v31);
        let v32 = Role{
            name         : 0x1::string::utf8(b"kunoichi2"),
            attack       : 12,
            life         : 18,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi2"), v32);
        let v33 = Role{
            name         : 0x1::string::utf8(b"kunoichi2_1"),
            attack       : 12,
            life         : 18,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi2_1"), v33);
        let v34 = Role{
            name         : 0x1::string::utf8(b"kunoichi3"),
            attack       : 24,
            life         : 45,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"attack_sputter_to_second_by_percent"),
            effect_value : 0x1::string::utf8(b"5"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"kunoichi3"), v34);
        let v35 = Role{
            name         : 0x1::string::utf8(b"archer1"),
            attack       : 6,
            life         : 9,
            magic        : 0,
            level        : 1,
            price        : 3,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"7"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer1"), v35);
        let v36 = Role{
            name         : 0x1::string::utf8(b"archer1_1"),
            attack       : 6,
            life         : 9,
            magic        : 0,
            level        : 2,
            price        : 5,
            max_magic    : 3,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"7"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer1_1"), v36);
        let v37 = Role{
            name         : 0x1::string::utf8(b"archer2"),
            attack       : 12,
            life         : 18,
            magic        : 0,
            level        : 3,
            price        : 8,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"14"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer2"), v37);
        let v38 = Role{
            name         : 0x1::string::utf8(b"archer2_1"),
            attack       : 12,
            life         : 18,
            magic        : 0,
            level        : 6,
            price        : 9,
            max_magic    : 2,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"14"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer2_1"), v38);
        let v39 = Role{
            name         : 0x1::string::utf8(b"archer3"),
            attack       : 24,
            life         : 45,
            magic        : 0,
            level        : 9,
            price        : 10,
            max_magic    : 1,
            effect       : 0x1::string::utf8(b"attack_last_char"),
            effect_value : 0x1::string::utf8(b"24"),
            effect_type  : 0x1::string::utf8(b"skill"),
        };
        0x2::vec_map::insert<0x1::string::String, Role>(&mut arg0.charactors, 0x1::string::utf8(b"archer3"), v39);
    }

    public fun init_role() : Role {
        Role{
            name         : 0x1::string::utf8(b"init"),
            attack       : 0,
            life         : 0,
            magic        : 0,
            level        : 0,
            price        : 0,
            max_magic    : 0,
            effect       : 0x1::string::utf8(b""),
            effect_value : 0x1::string::utf8(b""),
            effect_type  : 0x1::string::utf8(b""),
        }
    }

    fun random_select_role_by_level(arg0: &Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Role {
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

    public fun set_attack(arg0: &mut Role, arg1: u64) {
        arg0.attack = arg1;
    }

    public fun set_level(arg0: &mut Role, arg1: u8) {
        arg0.level = arg1;
    }

    public fun set_life(arg0: &mut Role, arg1: u64) {
        arg0.life = arg1;
    }

    public fun set_magic(arg0: &mut Role, arg1: u8) {
        arg0.magic = arg1;
    }

    public fun set_name(arg0: &mut Role, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public fun upgrade(arg0: &Global, arg1: &Role, arg2: &mut Role) : bool {
        if (0x1::string::sub_string(&arg1.name, 0, 3) != 0x1::string::sub_string(&arg2.name, 0, 3)) {
            return false
        };
        let v0 = arg1.level;
        let v1 = v0;
        let v2 = arg2.level;
        let v3 = v2;
        let v4 = arg1.life;
        let v5 = v4;
        let v6 = arg2.life;
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
            let v14 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::removeSuffix(arg2.name);
            let v15 = get_role_by_name(arg0, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_name_by_level(v14, v1));
            let v16 = get_role_by_name(arg0, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_name_by_level(v14, v3));
            let v17 = v5 - v15.life;
            let v18 = v7 - v16.life;
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
            let v23 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_name_by_level(v14, v13);
            let v24 = get_role_by_name(arg0, v23);
            arg2.name = v23;
            arg2.max_magic = v24.max_magic;
            arg2.price = v24.price;
            arg2.attack = v24.attack + v22;
            arg2.life = v24.life + v19;
            return true
        };
        false
    }

    // decompiled from Move bytecode v6
}

