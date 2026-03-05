module 0xc16803b7fc3661faf22d0d46ac40b93cad4c05e5813689e9638ea67d18222eae::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        mint_price_mist: u64,
        mint_enabled: bool,
    }

    struct Monster has store, key {
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
        scars: u8,
        broken_horns: u8,
        torn_wings: u8,
        last_breed: u64,
        parent1: 0x1::option::Option<0x2::object::ID>,
        parent2: 0x1::option::Option<0x2::object::ID>,
    }

    struct ArenaMatch has key {
        id: 0x2::object::UID,
        player_a: address,
        player_b: address,
        mon_a: 0x1::option::Option<Monster>,
        mon_b: 0x1::option::Option<Monster>,
        stake_a: 0x2::balance::Balance<0x2::sui::SUI>,
        stake_b: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        created_at: u64,
        last_update: u64,
    }

    struct Minted has copy, drop {
        monster_id: 0x2::object::ID,
        owner: address,
        paid_mist: u64,
    }

    struct BattleOutcome has copy, drop {
        winner_id: 0x2::object::ID,
        loser_id: 0x2::object::ID,
        winner_wins: u16,
        loser_losses: u16,
        winner_xp: u32,
        loser_xp: u32,
        loser_scars: u8,
        loser_broken_horns: u8,
        loser_torn_wings: u8,
    }

    struct BreedEvent has copy, drop {
        child_id: 0x2::object::ID,
        parent1: 0x2::object::ID,
        parent2: 0x2::object::ID,
    }

    struct MatchCreated has copy, drop {
        match_id: 0x2::object::ID,
        player_a: address,
        player_b: address,
    }

    struct MatchDepositMonster has copy, drop {
        match_id: 0x2::object::ID,
        player: address,
        side: u8,
        monster_id: 0x2::object::ID,
    }

    struct MatchDepositStake has copy, drop {
        match_id: 0x2::object::ID,
        player: address,
        side: u8,
        amount_mist: u64,
    }

    struct MatchLocked has copy, drop {
        match_id: 0x2::object::ID,
    }

    struct MatchFinished has copy, drop {
        match_id: 0x2::object::ID,
        winner: address,
        winner_monster_id: 0x2::object::ID,
        loser_monster_id: 0x2::object::ID,
        total_payout_mist: u64,
        fee_mist: u64,
    }

    struct MatchCancelled has copy, drop {
        match_id: 0x2::object::ID,
    }

    struct MintConfigUpdated has copy, drop {
        mint_price_mist: u64,
        mint_enabled: bool,
    }

    struct FeesWithdrawn has copy, drop {
        to: address,
        amount_mist: u64,
    }

    public entry fun admin_cancel(arg0: &mut ArenaMatch, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0 || arg0.status == 1, 10);
        if (0x1::option::is_some<Monster>(&arg0.mon_a)) {
            0x2::transfer::public_transfer<Monster>(0x1::option::extract<Monster>(&mut arg0.mon_a), arg0.player_a);
        };
        if (0x1::option::is_some<Monster>(&arg0.mon_b)) {
            0x2::transfer::public_transfer<Monster>(0x1::option::extract<Monster>(&mut arg0.mon_b), arg0.player_b);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_a) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_a), arg2), arg0.player_a);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_b) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_b), arg2), arg0.player_b);
        };
        arg0.status = 3;
        let v0 = MatchCancelled{match_id: 0x2::object::id<ArenaMatch>(arg0)};
        0x2::event::emit<MatchCancelled>(v0);
    }

    fun apply_damage(arg0: &mut Monster, arg1: u64) {
        if (arg0.scars < 255) {
            arg0.scars = arg0.scars + 1;
        };
        if (arg1 >= 150 && arg0.broken_horns == 0) {
            arg0.broken_horns = 1;
        };
        if (arg1 >= 250 && arg0.torn_wings == 0) {
            arg0.torn_wings = 1;
        };
    }

    public fun body(arg0: &Monster) : u8 {
        (((arg0.seed >> 24) % 6) as u8)
    }

    public entry fun breed(arg0: &mut Monster, arg1: &mut Monster, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        sync_stage(arg0, arg2);
        sync_stage(arg1, arg2);
        assert!(arg0.stage >= 2 && arg1.stage >= 2, 3);
        assert!(v0 > arg0.last_breed + 86400000, 4);
        assert!(v0 > arg1.last_breed + 86400000, 4);
        let v1 = arg0.seed ^ arg1.seed << 13 ^ arg1.seed >> 51 ^ v0;
        let v2 = Monster{
            id           : 0x2::object::new(arg3),
            name         : generate_name(v1),
            seed         : v1,
            stage        : 0,
            attack       : (arg0.attack + arg1.attack) / 2,
            defense      : (arg0.defense + arg1.defense) / 2,
            speed        : (arg0.speed + arg1.speed) / 2,
            created_at   : v0,
            wins         : 0,
            losses       : 0,
            xp           : 0,
            scars        : 0,
            broken_horns : 0,
            torn_wings   : 0,
            last_breed   : 0,
            parent1      : 0x1::option::some<0x2::object::ID>(0x2::object::id<Monster>(arg0)),
            parent2      : 0x1::option::some<0x2::object::ID>(0x2::object::id<Monster>(arg1)),
        };
        arg0.last_breed = v0;
        arg1.last_breed = v0;
        let v3 = BreedEvent{
            child_id : 0x2::object::id<Monster>(&v2),
            parent1  : 0x2::object::id<Monster>(arg0),
            parent2  : 0x2::object::id<Monster>(arg1),
        };
        0x2::event::emit<BreedEvent>(v3);
        0x2::transfer::public_transfer<Monster>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun color(arg0: &Monster) : u8 {
        (((arg0.seed >> 56) % 6) as u8)
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_match(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = ArenaMatch{
            id          : 0x2::object::new(arg2),
            player_a    : v0,
            player_b    : arg0,
            mon_a       : 0x1::option::none<Monster>(),
            mon_b       : 0x1::option::none<Monster>(),
            stake_a     : 0x2::balance::zero<0x2::sui::SUI>(),
            stake_b     : 0x2::balance::zero<0x2::sui::SUI>(),
            status      : 0,
            created_at  : v1,
            last_update : v1,
        };
        let v3 = MatchCreated{
            match_id : 0x2::object::id<ArenaMatch>(&v2),
            player_a : v0,
            player_b : arg0,
        };
        0x2::event::emit<MatchCreated>(v3);
        0x2::transfer::share_object<ArenaMatch>(v2);
    }

    public fun current_stage(arg0: &Monster, arg1: &0x2::clock::Clock) : u8 {
        stage_now(arg0.created_at, 0x2::clock::timestamp_ms(arg1))
    }

    public entry fun deposit_monster(arg0: &mut ArenaMatch, arg1: Monster, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        arg0.last_update = 0x2::clock::timestamp_ms(arg2);
        let v1 = &mut arg1;
        sync_stage(v1, arg2);
        if (v0 == arg0.player_a) {
            assert!(!0x1::option::is_some<Monster>(&arg0.mon_a), 6);
            0x1::option::fill<Monster>(&mut arg0.mon_a, arg1);
            let v2 = MatchDepositMonster{
                match_id   : 0x2::object::id<ArenaMatch>(arg0),
                player     : v0,
                side       : 0,
                monster_id : 0x2::object::id<Monster>(&arg1),
            };
            0x2::event::emit<MatchDepositMonster>(v2);
        } else {
            assert!(!0x1::option::is_some<Monster>(&arg0.mon_b), 6);
            0x1::option::fill<Monster>(&mut arg0.mon_b, arg1);
            let v3 = MatchDepositMonster{
                match_id   : 0x2::object::id<ArenaMatch>(arg0),
                player     : v0,
                side       : 1,
                monster_id : 0x2::object::id<Monster>(&arg1),
            };
            0x2::event::emit<MatchDepositMonster>(v3);
        };
        if (0x1::option::is_some<Monster>(&arg0.mon_a) && 0x1::option::is_some<Monster>(&arg0.mon_b)) {
            arg0.status = 1;
            let v4 = MatchLocked{match_id: 0x2::object::id<ArenaMatch>(arg0)};
            0x2::event::emit<MatchLocked>(v4);
        };
    }

    public entry fun deposit_stake(arg0: &mut ArenaMatch, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        arg0.last_update = 0x2::clock::timestamp_ms(arg2);
        if (v0 == arg0.player_a) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.stake_a, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            let v1 = MatchDepositStake{
                match_id    : 0x2::object::id<ArenaMatch>(arg0),
                player      : v0,
                side        : 0,
                amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            };
            0x2::event::emit<MatchDepositStake>(v1);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.stake_b, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            let v2 = MatchDepositStake{
                match_id    : 0x2::object::id<ArenaMatch>(arg0),
                player      : v0,
                side        : 1,
                amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            };
            0x2::event::emit<MatchDepositStake>(v2);
        };
    }

    public entry fun evolve(arg0: &mut Monster, arg1: &0x2::clock::Clock) {
        sync_stage(arg0, arg1);
    }

    public fun eyes(arg0: &Monster) : u8 {
        (((arg0.seed >> 32) % 5) as u8)
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

    public entry fun hatch(arg0: &mut Monster, arg1: &0x2::clock::Clock) {
        sync_stage(arg0, arg1);
    }

    public entry fun heartbeat(arg0: &mut Monster, arg1: &0x2::clock::Clock) {
        sync_stage(arg0, arg1);
    }

    public fun horns(arg0: &Monster) : u8 {
        (((arg0.seed >> 40) % 4) as u8)
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MONSTER>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Anavrin Legends | Stage {stage} | W:{wins} L:{losses} | XP:{xp} | Scars:{scars}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://heart-beat-production.up.railway.app/nft/{id}.svg"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://anavrin.xyz"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://anavrin.xyz/monsters/{id}"));
        let v6 = 0x2::display::new_with_fields<Monster>(&v0, v2, v4, arg1);
        0x2::display::update_version<Monster>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_transfer<0x2::display::Display<Monster>>(v6, v1);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, v1);
        let v8 = Treasury{
            id              : 0x2::object::new(arg1),
            fees            : 0x2::balance::zero<0x2::sui::SUI>(),
            mint_price_mist : 0,
            mint_enabled    : true,
        };
        0x2::transfer::share_object<Treasury>(v8);
    }

    public entry fun list_for_sale(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: Monster, arg3: u64) {
        0x2::kiosk::place_and_list<Monster>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut Treasury, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 1);
        let v0 = arg0.mint_price_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x1::bcs::to_bytes<address>(&v2);
        let v4 = v1 ^ (*0x1::vector::borrow<u8>(&v3, 0) as u64) << 16 ^ (*0x1::vector::borrow<u8>(&v3, 1) as u64) << 8 ^ (*0x1::vector::borrow<u8>(&v3, 2) as u64);
        let v5 = Monster{
            id           : 0x2::object::new(arg3),
            name         : generate_name(v4),
            seed         : v4,
            stage        : 0,
            attack       : ((v4 % 50 + 10) as u16),
            defense      : (((v4 >> 8) % 50 + 10) as u16),
            speed        : (((v4 >> 16) % 50 + 10) as u16),
            created_at   : v1,
            wins         : 0,
            losses       : 0,
            xp           : 0,
            scars        : 0,
            broken_horns : 0,
            torn_wings   : 0,
            last_breed   : 0,
            parent1      : 0x1::option::none<0x2::object::ID>(),
            parent2      : 0x1::option::none<0x2::object::ID>(),
        };
        let v6 = Minted{
            monster_id : 0x2::object::id<Monster>(&v5),
            owner      : v2,
            paid_mist  : v0,
        };
        0x2::event::emit<Minted>(v6);
        0x2::transfer::public_transfer<Monster>(v5, v2);
    }

    public fun mutation(arg0: &Monster) : u8 {
        (((arg0.seed >> 8) % 8) as u8)
    }

    public fun power_view(arg0: &Monster, arg1: &0x2::clock::Clock) : u64 {
        (arg0.attack as u64) * 3 + (arg0.defense as u64) * 2 + (arg0.speed as u64) * 1 + (current_stage(arg0, arg1) as u64) * 25 + (arg0.xp as u64) / 10
    }

    fun push_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun resolve_battle(arg0: &Monster, arg1: &Monster, arg2: &0x2::clock::Clock) : bool {
        let v0 = power_view(arg0, arg2);
        let v1 = power_view(arg1, arg2);
        v0 > v1 || v1 > v0 && false || tie_breaker(arg0, arg1)
    }

    public entry fun set_mint_enabled(arg0: &mut Treasury, arg1: &AdminCap, arg2: bool) {
        arg0.mint_enabled = arg2;
        let v0 = MintConfigUpdated{
            mint_price_mist : arg0.mint_price_mist,
            mint_enabled    : arg0.mint_enabled,
        };
        0x2::event::emit<MintConfigUpdated>(v0);
    }

    public entry fun set_mint_price(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64) {
        arg0.mint_price_mist = arg2;
        let v0 = MintConfigUpdated{
            mint_price_mist : arg0.mint_price_mist,
            mint_enabled    : arg0.mint_enabled,
        };
        0x2::event::emit<MintConfigUpdated>(v0);
    }

    public fun species(arg0: &Monster) : u8 {
        ((arg0.seed % 10) as u8)
    }

    fun stage_now(arg0: u64, arg1: u64) : u8 {
        let v0 = arg1 - arg0;
        if (v0 < 86400000) {
            0
        } else if (v0 < 86400000 * 2) {
            1
        } else if (v0 < 86400000 * 3) {
            2
        } else {
            3
        }
    }

    public entry fun start_battle(arg0: &mut ArenaMatch, arg1: &mut Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 7);
        assert!(0x1::option::is_some<Monster>(&arg0.mon_a) && 0x1::option::is_some<Monster>(&arg0.mon_b), 7);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stake_a);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stake_b);
        assert!(v1 == v2, 9);
        let v3 = 0x1::option::extract<Monster>(&mut arg0.mon_a);
        let v4 = 0x1::option::extract<Monster>(&mut arg0.mon_b);
        let v5 = &mut v3;
        sync_stage(v5, arg2);
        let v6 = &mut v4;
        sync_stage(v6, arg2);
        let v7 = power_view(&v3, arg2);
        let v8 = power_view(&v4, arg2);
        let v9 = if (v7 > v8) {
            v7 - v8
        } else {
            v8 - v7
        };
        let v10 = v1 + v2;
        let (v11, v12, v13) = if (resolve_battle(&v3, &v4, arg2)) {
            v3.wins = v3.wins + 1;
            v3.xp = v3.xp + 10;
            v4.losses = v4.losses + 1;
            v4.xp = v4.xp + 2;
            let v14 = &mut v4;
            apply_damage(v14, v9);
            let v15 = BattleOutcome{
                winner_id          : 0x2::object::id<Monster>(&v3),
                loser_id           : 0x2::object::id<Monster>(&v4),
                winner_wins        : v3.wins,
                loser_losses       : v4.losses,
                winner_xp          : v3.xp,
                loser_xp           : v4.xp,
                loser_scars        : v4.scars,
                loser_broken_horns : v4.broken_horns,
                loser_torn_wings   : v4.torn_wings,
            };
            0x2::event::emit<BattleOutcome>(v15);
            (0x2::object::id<Monster>(&v4), arg0.player_a, 0x2::object::id<Monster>(&v3))
        } else {
            v4.wins = v4.wins + 1;
            v4.xp = v4.xp + 10;
            v3.losses = v3.losses + 1;
            v3.xp = v3.xp + 2;
            let v16 = &mut v3;
            apply_damage(v16, v9);
            let v17 = BattleOutcome{
                winner_id          : 0x2::object::id<Monster>(&v4),
                loser_id           : 0x2::object::id<Monster>(&v3),
                winner_wins        : v4.wins,
                loser_losses       : v3.losses,
                winner_xp          : v4.xp,
                loser_xp           : v3.xp,
                loser_scars        : v3.scars,
                loser_broken_horns : v3.broken_horns,
                loser_torn_wings   : v3.torn_wings,
            };
            0x2::event::emit<BattleOutcome>(v17);
            (0x2::object::id<Monster>(&v3), arg0.player_b, 0x2::object::id<Monster>(&v4))
        };
        0x2::transfer::public_transfer<Monster>(v3, arg0.player_a);
        0x2::transfer::public_transfer<Monster>(v4, arg0.player_b);
        let v18 = 0;
        if (v10 > 0) {
            let v19 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_a);
            0x2::balance::join<0x2::sui::SUI>(&mut v19, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_b));
            let v20 = v10 * 100 / 10000;
            v18 = v20;
            if (v20 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.fees, 0x2::balance::split<0x2::sui::SUI>(&mut v19, v20));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v19, arg3), v12);
        };
        arg0.status = 2;
        let v21 = MatchFinished{
            match_id          : 0x2::object::id<ArenaMatch>(arg0),
            winner            : v12,
            winner_monster_id : v13,
            loser_monster_id  : v11,
            total_payout_mist : v10,
            fee_mist          : v18,
        };
        0x2::event::emit<MatchFinished>(v21);
    }

    fun sync_stage(arg0: &mut Monster, arg1: &0x2::clock::Clock) {
        let v0 = current_stage(arg0, arg1);
        if (v0 > arg0.stage) {
            arg0.stage = v0;
        };
    }

    fun tie_breaker(arg0: &Monster, arg1: &Monster) : bool {
        arg0.speed > arg1.speed || arg0.speed < arg1.speed && false || arg0.seed <= arg1.seed
    }

    public entry fun update_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<Monster>, arg2: 0x1::string::String) {
        0x2::display::edit<Monster>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<Monster>(arg1);
    }

    public fun wings(arg0: &Monster) : u8 {
        (((arg0.seed >> 48) % 3) as u8)
    }

    public entry fun withdraw(arg0: &mut ArenaMatch, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 8);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.player_a || v0 == arg0.player_b, 5);
        if (v0 == arg0.player_a) {
            if (0x1::option::is_some<Monster>(&arg0.mon_a)) {
                0x2::transfer::public_transfer<Monster>(0x1::option::extract<Monster>(&mut arg0.mon_a), v0);
            };
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_a) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_a), arg1), v0);
            };
        } else {
            if (0x1::option::is_some<Monster>(&arg0.mon_b)) {
                0x2::transfer::public_transfer<Monster>(0x1::option::extract<Monster>(&mut arg0.mon_b), v0);
            };
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.stake_b) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.stake_b), arg1), v0);
            };
        };
    }

    public entry fun withdraw_fees(arg0: &mut Treasury, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fees), arg3), arg2);
            let v1 = FeesWithdrawn{
                to          : arg2,
                amount_mist : v0,
            };
            0x2::event::emit<FeesWithdrawn>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

