module 0x2ca61670c77b0fb32ab2b62b209d260531a1303936e365ae3154bc3d0eb7ec48::martian {
    struct MARTIAN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        mint_price_mist: u64,
        mint_enabled: bool,
        battle_fee_bps: u64,
        heal_fee_mist: u64,
        hardcore_enabled: bool,
        death_at_zero_hp: bool,
        rip_enabled: bool,
        match_timeout_ms: u64,
        spirit_to_guardian_ms: u64,
        guardian_to_enlightened_ms: u64,
        champion_xp_min: u32,
        emperor_xp_min: u32,
        starting_stat_max: u16,
        starting_health_base: u16,
        xp_per_win: u32,
        xp_per_loss: u32,
        breed_cooldown_ms: u64,
    }

    struct Martian has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        seed: u64,
        stage: u8,
        attack: u16,
        defense: u16,
        speed: u16,
        created_at: u64,
        wins: u16,
        losses: u16,
        xp: u32,
        current_health: u16,
        max_health: u16,
        scars: u8,
        broken_horns: u8,
        torn_wings: u8,
        is_dead: bool,
        death_count: u8,
        last_breed: u64,
        parent1: 0x1::option::Option<0x2::object::ID>,
        parent2: 0x1::option::Option<0x2::object::ID>,
    }

    struct MartianMatch has key {
        id: 0x2::object::UID,
        player_a: address,
        player_b: address,
        martian_a: 0x1::option::Option<Martian>,
        martian_b: 0x1::option::Option<Martian>,
        stake_a: 0x2::balance::Balance<0x2::sui::SUI>,
        stake_b: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        mode: u8,
        battle_attack_a: u16,
        battle_defense_a: u16,
        battle_speed_a: u16,
        battle_attack_b: u16,
        battle_defense_b: u16,
        battle_speed_b: u16,
        created_at: u64,
        last_update: u64,
    }

    struct MemorialMartian has store, key {
        id: 0x2::object::UID,
        original_martian_id: 0x2::object::ID,
        stage: u8,
        wins: u16,
        losses: u16,
        xp: u32,
        scars: u8,
        attack: u16,
        defense: u16,
        speed: u16,
        death_reason: u8,
        died_at: u64,
    }

    struct Minted has copy, drop {
        martian_id: 0x2::object::ID,
        owner: address,
        paid_mist: u64,
    }

    struct MemorialMinted has copy, drop {
        memorial_id: 0x2::object::ID,
        original_martian_id: 0x2::object::ID,
        owner: address,
    }

    struct Bred has copy, drop {
        child_id: 0x2::object::ID,
        parent1_id: 0x2::object::ID,
        parent2_id: 0x2::object::ID,
        owner: address,
    }

    public entry fun admin_cancel(arg0: &mut MartianMatch, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0 || arg0.status == 1, 10);
        if (0x1::option::is_some<Martian>(&arg0.martian_a)) {
            0x2::transfer::public_transfer<Martian>(0x1::option::extract<Martian>(&mut arg0.martian_a), arg0.player_a);
        };
        if (0x1::option::is_some<Martian>(&arg0.martian_b)) {
            0x2::transfer::public_transfer<Martian>(0x1::option::extract<Martian>(&mut arg0.martian_b), arg0.player_b);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_a) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_a), arg2), arg0.player_a);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_b) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_b), arg2), arg0.player_b);
        };
        arg0.status = 3;
    }

    public fun attach_item<T0: store + key>(arg0: &mut Martian, arg1: T0, arg2: vector<u8>) {
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut arg0.id, arg2, arg1);
    }

    public entry fun breed(arg0: &mut Martian, arg1: &mut Martian, arg2: &GameConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(!arg0.is_dead, 11);
        assert!(!arg1.is_dead, 11);
        sync_stage(arg0, arg2, arg3);
        sync_stage(arg1, arg2, arg3);
        assert!(arg0.stage == 2, 15);
        assert!(arg1.stage == 2, 15);
        assert!(v1 >= arg0.last_breed + arg2.breed_cooldown_ms, 16);
        assert!(v1 >= arg1.last_breed + arg2.breed_cooldown_ms, 16);
        assert!(0x2::object::id<Martian>(arg0) != 0x2::object::id<Martian>(arg1), 17);
        let v2 = arg0.seed ^ arg1.seed ^ v1 ^ (arg0.xp as u64) ^ (arg1.xp as u64);
        let v3 = ((v2 % 7) as u16);
        let v4 = Martian{
            id             : 0x2::object::new(arg4),
            name           : generate_name(v2),
            seed           : v2,
            stage          : 0,
            attack         : ((((arg0.attack as u32) + (arg1.attack as u32)) / 2) as u16) + v3 % 3,
            defense        : ((((arg0.defense as u32) + (arg1.defense as u32)) / 2) as u16) + (v3 >> 2) % 3,
            speed          : ((((arg0.speed as u32) + (arg1.speed as u32)) / 2) as u16) + (v3 >> 4) % 3,
            created_at     : v1,
            wins           : 0,
            losses         : 0,
            xp             : ((((arg0.xp as u64) + (arg1.xp as u64)) / 2 * 40 / 100) as u32),
            current_health : arg2.starting_health_base,
            max_health     : arg2.starting_health_base,
            scars          : 0,
            broken_horns   : 0,
            torn_wings     : 0,
            is_dead        : false,
            death_count    : 0,
            last_breed     : 0,
            parent1        : 0x1::option::some<0x2::object::ID>(0x2::object::id<Martian>(arg0)),
            parent2        : 0x1::option::some<0x2::object::ID>(0x2::object::id<Martian>(arg1)),
        };
        arg0.last_breed = v1;
        arg1.last_breed = v1;
        let v5 = Bred{
            child_id   : 0x2::object::id<Martian>(&v4),
            parent1_id : 0x2::object::id<Martian>(arg0),
            parent2_id : 0x2::object::id<Martian>(arg1),
            owner      : v0,
        };
        0x2::event::emit<Bred>(v5);
        0x2::transfer::public_transfer<Martian>(v4, v0);
    }

    public entry fun create_match(arg0: &GameConfig, arg1: &0x2::clock::Clock, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 != arg2, 19);
        assert!(arg3 == 0 || arg3 == 1, 13);
        if (arg3 == 1) {
            assert!(arg0.hardcore_enabled, 12);
        };
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = MartianMatch{
            id               : 0x2::object::new(arg4),
            player_a         : v0,
            player_b         : arg2,
            martian_a        : 0x1::option::none<Martian>(),
            martian_b        : 0x1::option::none<Martian>(),
            stake_a          : 0x2::balance::zero<0x2::sui::SUI>(),
            stake_b          : 0x2::balance::zero<0x2::sui::SUI>(),
            status           : 0,
            mode             : arg3,
            battle_attack_a  : 0,
            battle_defense_a : 0,
            battle_speed_a   : 0,
            battle_attack_b  : 0,
            battle_defense_b : 0,
            battle_speed_b   : 0,
            created_at       : v1,
            last_update      : v1,
        };
        0x2::transfer::share_object<MartianMatch>(v2);
    }

    public fun current_form(arg0: &Martian, arg1: &GameConfig, arg2: &0x2::clock::Clock) : u8 {
        let v0 = 0x2::clock::timestamp_ms(arg2) - arg0.created_at;
        if (v0 < arg1.spirit_to_guardian_ms) {
            0
        } else if (v0 < arg1.guardian_to_enlightened_ms) {
            1
        } else {
            2
        }
    }

    public fun current_rank(arg0: &Martian, arg1: &GameConfig) : u8 {
        if (arg0.xp >= arg1.emperor_xp_min) {
            3
        } else if (arg0.xp >= arg1.champion_xp_min) {
            2
        } else {
            1
        }
    }

    public entry fun deposit_martian(arg0: &mut MartianMatch, arg1: Martian, arg2: &GameConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        assert!(!arg1.is_dead, 11);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        let v1 = &mut arg1;
        sync_stage(v1, arg2, arg3);
        if (v0 == arg0.player_a) {
            assert!(!0x1::option::is_some<Martian>(&arg0.martian_a), 6);
            arg0.battle_attack_a = arg1.attack;
            arg0.battle_defense_a = arg1.defense;
            arg0.battle_speed_a = arg1.speed;
            0x1::option::fill<Martian>(&mut arg0.martian_a, arg1);
        } else {
            assert!(!0x1::option::is_some<Martian>(&arg0.martian_b), 6);
            arg0.battle_attack_b = arg1.attack;
            arg0.battle_defense_b = arg1.defense;
            arg0.battle_speed_b = arg1.speed;
            0x1::option::fill<Martian>(&mut arg0.martian_b, arg1);
        };
        arg0.last_update = 0x2::clock::timestamp_ms(arg3);
        if (0x1::option::is_some<Martian>(&arg0.martian_a) && 0x1::option::is_some<Martian>(&arg0.martian_b)) {
            arg0.status = 1;
        };
    }

    public entry fun deposit_stake(arg0: &mut MartianMatch, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        if (v0 == arg0.player_a) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.stake_a, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.stake_b, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        };
        arg0.last_update = 0x2::clock::timestamp_ms(arg2);
    }

    fun generate_name(arg0: u64) : 0x1::string::String {
        let v0 = vector[b"Zo", b"Lu", b"Ka", b"Py", b"Neo", b"Aqua", b"Sha", b"Elec", b"Ter", b"Vra"];
        let v1 = vector[b"nar", b"mov", b"vra", b"ram", b"mir", b"zoi", b"dow", b"lec", b"mot", b"vex"];
        let v2 = vector[b"ling", b"ra", b"mite", b"beast", b"moth", b"oid", b"born", b"max", b"nyx", b"zor"];
        let v3 = 0x1::vector::empty<u8>();
        let v4 = &mut v3;
        push_bytes(v4, 0x1::vector::borrow<vector<u8>>(&v0, (((arg0 >> 0) % 10) as u64)));
        let v5 = &mut v3;
        push_bytes(v5, 0x1::vector::borrow<vector<u8>>(&v1, (((arg0 >> 8) % 10) as u64)));
        let v6 = &mut v3;
        push_bytes(v6, 0x1::vector::borrow<vector<u8>>(&v2, (((arg0 >> 16) % 10) as u64)));
        0x1::string::utf8(v3)
    }

    public fun has_item(arg0: &Martian, arg1: vector<u8>) : bool {
        0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public entry fun heal(arg0: &mut Martian, arg1: &mut GameConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_dead, 11);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg1.heal_fee_mist, 14);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.current_health = arg0.max_health;
    }

    fun init(arg0: MARTIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MARTIAN>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = GameConfig{
            id                         : 0x2::object::new(arg1),
            fees                       : 0x2::balance::zero<0x2::sui::SUI>(),
            mint_price_mist            : 0,
            mint_enabled               : true,
            battle_fee_bps             : 100,
            heal_fee_mist              : 0,
            hardcore_enabled           : false,
            death_at_zero_hp           : true,
            rip_enabled                : true,
            match_timeout_ms           : 1800000,
            spirit_to_guardian_ms      : 10800000,
            guardian_to_enlightened_ms : 21600000,
            champion_xp_min            : 100,
            emperor_xp_min             : 300,
            starting_stat_max          : 25,
            starting_health_base       : 100,
            xp_per_win                 : 15,
            xp_per_loss                : 5,
            breed_cooldown_ms          : 86400000,
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"collection"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(x"4d61727469616e20416c69656e20e280a220466f726d3a207b73746167657d20e280a220573a7b77696e737d204c3a7b6c6f737365737d20e280a22058503a7b78707d20e280a22048503a7b63757272656e745f6865616c74687d2f7b6d61785f6865616c74687d"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://your-renderer.example/martian/{id}.svg"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://your-renderer.example/martian/{id}.svg"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://martians.game"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://martians.game/martians/{id}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Martians Collection"));
        let v8 = 0x2::display::new_with_fields<Martian>(&v0, v4, v6, arg1);
        0x2::display::update_version<Martian>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_transfer<0x2::display::Display<Martian>>(v8, v1);
        0x2::transfer::public_transfer<AdminCap>(v2, v1);
        0x2::transfer::share_object<GameConfig>(v3);
    }

    public entry fun list_for_sale(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: Martian, arg3: u64) {
        0x2::kiosk::place_and_list<Martian>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut GameConfig, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.mint_price_mist, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x1::bcs::to_bytes<address>(&v1);
        let v3 = v0 ^ (*0x1::vector::borrow<u8>(&v2, 0) as u64) << 56 ^ (*0x1::vector::borrow<u8>(&v2, 1) as u64) << 48 ^ (*0x1::vector::borrow<u8>(&v2, 2) as u64) << 40;
        let v4 = (arg0.starting_stat_max as u64);
        let v5 = Martian{
            id             : 0x2::object::new(arg3),
            name           : generate_name(v3),
            seed           : v3,
            stage          : 0,
            attack         : ((v3 % (v4 + 1)) as u16),
            defense        : (((v3 >> 8) % (v4 + 1)) as u16),
            speed          : (((v3 >> 16) % (v4 + 1)) as u16),
            created_at     : v0,
            wins           : 0,
            losses         : 0,
            xp             : 0,
            current_health : arg0.starting_health_base,
            max_health     : arg0.starting_health_base,
            scars          : 0,
            broken_horns   : 0,
            torn_wings     : 0,
            is_dead        : false,
            death_count    : 0,
            last_breed     : 0,
            parent1        : 0x1::option::none<0x2::object::ID>(),
            parent2        : 0x1::option::none<0x2::object::ID>(),
        };
        let v6 = Minted{
            martian_id : 0x2::object::id<Martian>(&v5),
            owner      : v1,
            paid_mist  : arg0.mint_price_mist,
        };
        0x2::event::emit<Minted>(v6);
        0x2::transfer::public_transfer<Martian>(v5, v1);
    }

    public fun power(arg0: &Martian, arg1: &GameConfig, arg2: &0x2::clock::Clock) : u64 {
        let v0 = (current_form(arg0, arg1, arg2) as u64);
        let v1 = (current_rank(arg0, arg1) as u64);
        let v2 = if (v0 == (0 as u64)) {
            0
        } else if (v0 == (1 as u64)) {
            20
        } else {
            40
        };
        let v3 = if (v1 == (1 as u64)) {
            0
        } else if (v1 == (2 as u64)) {
            25
        } else {
            60
        };
        (arg0.attack as u64) * 3 + (arg0.defense as u64) * 2 + (arg0.speed as u64) + v2 + v3 + (arg0.xp as u64) / 20
    }

    fun push_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_battle_fee_bps(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u64) {
        arg0.battle_fee_bps = arg2;
    }

    public entry fun set_breed_cooldown_ms(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u64) {
        arg0.breed_cooldown_ms = arg2;
    }

    public entry fun set_champion_xp_min(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u32) {
        arg0.champion_xp_min = arg2;
    }

    public entry fun set_death_enabled(arg0: &mut GameConfig, arg1: &AdminCap, arg2: bool) {
        arg0.death_at_zero_hp = arg2;
    }

    public entry fun set_emperor_xp_min(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u32) {
        arg0.emperor_xp_min = arg2;
    }

    public entry fun set_guardian_to_enlightened_ms(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u64) {
        arg0.guardian_to_enlightened_ms = arg2;
    }

    public entry fun set_hardcore_enabled(arg0: &mut GameConfig, arg1: &AdminCap, arg2: bool) {
        arg0.hardcore_enabled = arg2;
    }

    public entry fun set_heal_fee(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u64) {
        arg0.heal_fee_mist = arg2;
    }

    public entry fun set_match_timeout(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u64) {
        arg0.match_timeout_ms = arg2;
    }

    public entry fun set_mint_enabled(arg0: &mut GameConfig, arg1: &AdminCap, arg2: bool) {
        arg0.mint_enabled = arg2;
    }

    public entry fun set_mint_price(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u64) {
        arg0.mint_price_mist = arg2;
    }

    public entry fun set_rip_enabled(arg0: &mut GameConfig, arg1: &AdminCap, arg2: bool) {
        arg0.rip_enabled = arg2;
    }

    public entry fun set_spirit_to_guardian_ms(arg0: &mut GameConfig, arg1: &AdminCap, arg2: u64) {
        arg0.spirit_to_guardian_ms = arg2;
    }

    public entry fun start_battle(arg0: &mut MartianMatch, arg1: &mut GameConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 7);
        assert!(0x1::option::is_some<Martian>(&arg0.martian_a) && 0x1::option::is_some<Martian>(&arg0.martian_b), 7);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stake_a);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stake_b);
        assert!(v1 == v2, 9);
        let v3 = 0x1::option::extract<Martian>(&mut arg0.martian_a);
        let v4 = 0x1::option::extract<Martian>(&mut arg0.martian_b);
        let v5 = &mut v3;
        sync_stage(v5, arg1, arg2);
        let v6 = &mut v4;
        sync_stage(v6, arg1, arg2);
        let v7 = power(&v3, arg1, arg2);
        let v8 = power(&v4, arg1, arg2);
        let v9 = v7 > v8 || v8 > v7 && false || v3.seed <= v4.seed;
        let v10 = if (v7 > v8) {
            v7 - v8
        } else {
            v8 - v7
        };
        let v11 = 20 + ((v10 % 100) as u16);
        if (v9) {
            v3.wins = v3.wins + 1;
            v3.xp = v3.xp + arg1.xp_per_win;
            v4.losses = v4.losses + 1;
            v4.xp = v4.xp + arg1.xp_per_loss;
            if (v4.scars < 255) {
                v4.scars = v4.scars + 1;
            };
            if (v4.current_health > v11) {
                v4.current_health = v4.current_health - v11;
            } else {
                v4.current_health = 0;
            };
        } else {
            v4.wins = v4.wins + 1;
            v4.xp = v4.xp + arg1.xp_per_win;
            v3.losses = v3.losses + 1;
            v3.xp = v3.xp + arg1.xp_per_loss;
            if (v3.scars < 255) {
                v3.scars = v3.scars + 1;
            };
            if (v3.current_health > v11) {
                v3.current_health = v3.current_health - v11;
            } else {
                v3.current_health = 0;
            };
        };
        let v12 = v1 + v2;
        if (v12 > 0) {
            let v13 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_a);
            0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_b));
            let v14 = v12 * arg1.battle_fee_bps / 10000;
            if (v14 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v13, v14));
            };
            let v15 = if (v9) {
                arg0.player_a
            } else {
                arg0.player_b
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v13, arg3), v15);
        };
        let v16 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.mode == 1 && arg1.death_at_zero_hp) {
            if (v3.current_health == 0) {
                v3.is_dead = true;
                v3.death_count = v3.death_count + 1;
                if (arg1.rip_enabled) {
                    let v17 = MemorialMartian{
                        id                  : 0x2::object::new(arg3),
                        original_martian_id : 0x2::object::id<Martian>(&v3),
                        stage               : v3.stage,
                        wins                : v3.wins,
                        losses              : v3.losses,
                        xp                  : v3.xp,
                        scars               : v3.scars,
                        attack              : v3.attack,
                        defense             : v3.defense,
                        speed               : v3.speed,
                        death_reason        : 0,
                        died_at             : v16,
                    };
                    let v18 = MemorialMinted{
                        memorial_id         : 0x2::object::id<MemorialMartian>(&v17),
                        original_martian_id : 0x2::object::id<Martian>(&v3),
                        owner               : arg0.player_a,
                    };
                    0x2::event::emit<MemorialMinted>(v18);
                    0x2::transfer::public_transfer<MemorialMartian>(v17, arg0.player_a);
                };
            };
            if (v4.current_health == 0) {
                v4.is_dead = true;
                v4.death_count = v4.death_count + 1;
                if (arg1.rip_enabled) {
                    let v19 = MemorialMartian{
                        id                  : 0x2::object::new(arg3),
                        original_martian_id : 0x2::object::id<Martian>(&v4),
                        stage               : v4.stage,
                        wins                : v4.wins,
                        losses              : v4.losses,
                        xp                  : v4.xp,
                        scars               : v4.scars,
                        attack              : v4.attack,
                        defense             : v4.defense,
                        speed               : v4.speed,
                        death_reason        : 0,
                        died_at             : v16,
                    };
                    let v20 = MemorialMinted{
                        memorial_id         : 0x2::object::id<MemorialMartian>(&v19),
                        original_martian_id : 0x2::object::id<Martian>(&v4),
                        owner               : arg0.player_b,
                    };
                    0x2::event::emit<MemorialMinted>(v20);
                    0x2::transfer::public_transfer<MemorialMartian>(v19, arg0.player_b);
                };
            };
        };
        0x2::transfer::public_transfer<Martian>(v3, arg0.player_a);
        0x2::transfer::public_transfer<Martian>(v4, arg0.player_b);
        arg0.status = 2;
    }

    public entry fun sync_stage(arg0: &mut Martian, arg1: &GameConfig, arg2: &0x2::clock::Clock) {
        let v0 = current_form(arg0, arg1, arg2);
        if (v0 > arg0.stage) {
            arg0.stage = v0;
        };
    }

    public entry fun withdraw(arg0: &mut MartianMatch, arg1: &GameConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        assert!(arg0.status == 0 || 0x2::clock::timestamp_ms(arg2) - arg0.last_update >= arg1.match_timeout_ms, 8);
        if (v0 == arg0.player_a) {
            if (0x1::option::is_some<Martian>(&arg0.martian_a)) {
                0x2::transfer::public_transfer<Martian>(0x1::option::extract<Martian>(&mut arg0.martian_a), v0);
            };
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_a) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_a), arg3), v0);
            };
        } else {
            if (0x1::option::is_some<Martian>(&arg0.martian_b)) {
                0x2::transfer::public_transfer<Martian>(0x1::option::extract<Martian>(&mut arg0.martian_b), v0);
            };
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_b) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_b), arg3), v0);
            };
        };
    }

    public entry fun withdraw_fees(arg0: &mut GameConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.fees) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fees), arg3), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

