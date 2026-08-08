module 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::skill_mechanics {
    struct CharacterInfo has copy, drop {
        name: 0x1::string::String,
        level: u64,
        level_title: 0x1::string::String,
        next_level_title: 0x1::string::String,
        current_exp: u64,
        base_level_exp: u64,
        next_level_exp: u64,
        exp_into_level: u64,
        current_exp_percent: u64,
        skills: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct NameRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        names: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct SkillChange has copy, drop {
        nft_id: 0x2::object::ID,
        skill_levels: vector<u64>,
    }

    struct ExpChange has copy, drop {
        nft_id: 0x2::object::ID,
        character_exp: u64,
        next_level_exp: u64,
    }

    struct LevelChange has copy, drop {
        nft_id: 0x2::object::ID,
        level: u64,
        level_title: 0x1::string::String,
    }

    struct NameChange has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    fun assert_version(arg0: &NameRegistry) {
        assert!(arg0.version == 1, 13906834672560898069);
    }

    public fun change_name(arg0: &mut 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet, arg1: &mut NameRegistry, arg2: 0x1::string::String, arg3: &mut 0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::TreasuryCapHolder, arg4: 0x2::coin::Coin<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET> {
        assert_version(arg1);
        let v0 = 0x1::string::length(&arg2);
        assert!(1 <= v0 && v0 <= 25, 13906835441359519757);
        assert!(0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::string_util::is_alphanumeric(arg2), 13906835445654618127);
        assert!(0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::string_util::has_valid_spaces(arg2), 13906835449949716497);
        let v1 = normalize(arg2);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.names, v1), 13906835462834749459);
        assert!(0x2::coin::value<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>(&arg4) >= 360000000000, 13906835471424159755);
        0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::burn(arg3, 0x2::coin::split<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>(&mut arg4, 360000000000, arg5));
        let v2 = normalize(0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_name(arg0));
        if (0x2::table::contains<0x1::string::String, bool>(&arg1.names, v2)) {
            0x2::table::remove<0x1::string::String, bool>(&mut arg1.names, v2);
        };
        0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::set_name_internal(arg0, arg2);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.names, v1, true);
        let v3 = NameChange{
            nft_id : 0x2::object::id<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet>(arg0),
            name   : arg2,
        };
        0x2::event::emit<NameChange>(v3);
        arg4
    }

    fun detective_titles() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Junior Detective"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Detective Constable"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Detective Sergeant"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Detective Inspector"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Detective Chief Inspector"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Detective Superintendent"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Detective Chief Superintendent"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Assistant Chief Constable"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Deputy Chief Constable"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Chief Constable"));
        v0
    }

    fun emit_upgrade_events(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet, arg1: u64) {
        let v0 = 0x2::object::id<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet>(arg0);
        let v1 = SkillChange{
            nft_id       : v0,
            skill_levels : get_skill_levels(arg0),
        };
        0x2::event::emit<SkillChange>(v1);
        let v2 = ExpChange{
            nft_id         : v0,
            character_exp  : get_character_exp(arg0),
            next_level_exp : get_next_level_exp(arg0),
        };
        0x2::event::emit<ExpChange>(v2);
        let v3 = get_level(arg0);
        if (v3 != arg1) {
            let v4 = LevelChange{
                nft_id      : v0,
                level       : v3,
                level_title : get_level_title(arg0),
            };
            0x2::event::emit<LevelChange>(v4);
        };
    }

    fun gangster_titles() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Casino Worker"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Moon Shiner"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Smuggler"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Body Guard"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Associate"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Soldier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Captain"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Under Boss"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right-hand Person"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Mob Boss"));
        v0
    }

    public fun get_base_level_exp(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet) : u64 {
        (get_level(arg0) - 1) * 50
    }

    public fun get_character_exp(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skills_len(arg0)) {
            let (_, v3) = 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skill_at(arg0, v1);
            v0 = v0 + v3;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_character_info(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet) : CharacterInfo {
        let v0 = get_character_exp(arg0);
        let v1 = get_level(arg0);
        let v2 = (v1 - 1) * 50;
        let v3 = if (v1 + 1 > 10) {
            10
        } else {
            v1 + 1
        };
        let v4 = if (0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_is_gangster(arg0)) {
            gangster_titles()
        } else {
            detective_titles()
        };
        let v5 = v4;
        CharacterInfo{
            name                : 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_name(arg0),
            level               : v1,
            level_title         : *0x1::vector::borrow<0x1::string::String>(&v5, v1 - 1),
            next_level_title    : *0x1::vector::borrow<0x1::string::String>(&v5, v3 - 1),
            current_exp         : v0,
            base_level_exp      : v2,
            next_level_exp      : v2 + 50,
            exp_into_level      : v0 - v2,
            current_exp_percent : (v0 - v2) * 100 / 50,
            skills              : *0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skills(arg0),
        }
    }

    public fun get_level(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet) : u64 {
        let v0 = get_character_exp(arg0) / 50 + 1;
        if (v0 > 10) {
            10
        } else {
            v0
        }
    }

    public fun get_level_title(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet) : 0x1::string::String {
        let v0 = if (0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_is_gangster(arg0)) {
            gangster_titles()
        } else {
            detective_titles()
        };
        let v1 = v0;
        *0x1::vector::borrow<0x1::string::String>(&v1, get_level(arg0) - 1)
    }

    public fun get_next_level_exp(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet) : u64 {
        get_base_level_exp(arg0) + 50
    }

    public fun get_skill_levels(arg0: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skills_len(arg0)) {
            let (_, v3) = 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skill_at(arg0, v1);
            0x1::vector::push_back<u64>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_skill_upgrade_cost(arg0: u64, arg1: u64) : u64 {
        let (v0, _) = get_skill_upgrade_cost_breakdown(arg0, arg1);
        v0
    }

    public fun get_skill_upgrade_cost_breakdown(arg0: u64, arg1: u64) : (u64, vector<vector<u64>>) {
        let v0 = arg0 + arg1;
        assert!(v0 <= 500, 13906835046221742081);
        let v1 = per_point_cost();
        let v2 = 0;
        let v3 = vector[];
        let v4 = arg0;
        while (v4 < v0) {
            let v5 = v4 / 50;
            let v6 = (v5 + 1) * 50;
            let v7 = if (v0 < v6) {
                v0
            } else {
                v6
            };
            let v8 = v7 - arg0;
            let v9 = (((v8 as u128) * (*0x1::vector::borrow<u64>(&v1, v5) as u128) * (1000000000 as u128)) as u64);
            v2 = v2 + v9;
            let v10 = 0x1::vector::empty<u64>();
            let v11 = &mut v10;
            0x1::vector::push_back<u64>(v11, v8);
            0x1::vector::push_back<u64>(v11, v9);
            0x1::vector::push_back<vector<u64>>(&mut v3, v10);
            v4 = v7;
        };
        (v2, v3)
    }

    public fun increase_skill_level(arg0: &mut 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet, arg1: vector<u64>, arg2: &mut 0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::TreasuryCapHolder, arg3: 0x2::coin::Coin<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET> {
        assert!(0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skills_len(arg0) == 5, 13906835183661219849);
        assert!(0x1::vector::length<u64>(&arg1) == 5, 13906835187956056071);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 5) {
            let (_, v3) = 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skill_at(arg0, v1);
            assert!(v3 + *0x1::vector::borrow<u64>(&arg1, v1) <= 100, 13906835218020564995);
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 13906835235200565253);
        let v4 = get_character_exp(arg0);
        assert!(v4 + v0 <= 500, 13906835252380172289);
        let v5 = get_skill_upgrade_cost(v4, v0);
        assert!(0x2::coin::value<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>(&arg3) >= v5, 13906835269560696843);
        0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::burn(arg2, 0x2::coin::split<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>(&mut arg3, v5, arg4));
        v1 = 0;
        while (v1 < 5) {
            let (_, v7) = 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_skill_at(arg0, v1);
            0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::set_skill_at(arg0, v1, v7 + *0x1::vector::borrow<u64>(&arg1, v1));
            v1 = v1 + 1;
        };
        emit_upgrade_events(arg0, get_level(arg0));
        arg3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NameRegistry{
            id      : 0x2::object::new(arg0),
            version : 1,
            names   : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<NameRegistry>(v0);
    }

    public fun migrate(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut NameRegistry) {
        assert!(arg1.version < 1, 13906834698330832919);
        arg1.version = 1;
    }

    fun normalize(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::to_ascii(arg0);
        0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::string_util::remove_space(0x1::string::from_ascii(0x1::ascii::to_lowercase(&v0)))
    }

    fun per_point_cost() : vector<u64> {
        vector[7, 14, 21, 35, 49, 70, 91, 114, 135, 171]
    }

    public fun version(arg0: &NameRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

