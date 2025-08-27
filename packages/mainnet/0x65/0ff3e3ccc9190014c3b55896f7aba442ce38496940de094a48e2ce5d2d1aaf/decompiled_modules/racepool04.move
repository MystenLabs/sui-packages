module 0x650ff3e3ccc9190014c3b55896f7aba442ce38496940de094a48e2ce5d2d1aaf::racepool04 {
    struct MONSTER04 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        power: u64,
        timelap: u64,
        aero: u64,
        brakes: u64,
        sosp: u64,
        image: 0x1::string::String,
    }

    struct Ticket04NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        valid_for: 0x1::string::String,
    }

    struct Meccanico04NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        bravura: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Pilota04NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        boost_power: u64,
        boost_timelap: u64,
        boost_aero: u64,
        boost_brakes: u64,
        boost_sosp: u64,
        image: 0x1::string::String,
    }

    struct LevelUpDriver04NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Upgrade04NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power_delta: u64,
        power_is_add: bool,
        timelap_delta: u64,
        timelap_is_add: bool,
        aero_delta: u64,
        aero_is_add: bool,
        brakes_delta: u64,
        brakes_is_add: bool,
        sosp_delta: u64,
        sosp_is_add: bool,
        image: 0x1::string::String,
    }

    struct GoldTrophy04 has store, key {
        id: 0x2::object::UID,
    }

    struct SilverTrophy04 has store, key {
        id: 0x2::object::UID,
    }

    struct BronzeTrophy04 has store, key {
        id: 0x2::object::UID,
    }

    struct RaceConfig04 has copy, drop, store {
        laps: u64,
        base_per_mille: u64,
        w_power: u64,
        w_aero: u64,
        w_brakes: u64,
        w_sosp: u64,
    }

    struct Participant has copy, drop, store {
        owner: address,
        monster_level: u64,
        power: u64,
        timelap: u64,
        aero: u64,
        brakes: u64,
        sosp: u64,
        total_time: u64,
    }

    struct RacePool04 has store, key {
        id: 0x2::object::UID,
        config: RaceConfig04,
        participants: vector<Participant>,
        used_monsters: vector<address>,
        used_pilots: vector<address>,
        started: bool,
    }

    struct PrizeVault04 has store, key {
        id: 0x2::object::UID,
        gold: vector<GoldTrophy04>,
        silver: vector<SilverTrophy04>,
        bronze: vector<BronzeTrophy04>,
        levelups: vector<LevelUpDriver04NFT>,
        good_upgrades: vector<Upgrade04NFT>,
        mixed_upgrades: vector<Upgrade04NFT>,
    }

    fun swap(arg0: &mut vector<Participant>, arg1: u64, arg2: u64) {
        if (arg1 == arg2) {
            return
        };
        *0x1::vector::borrow_mut<Participant>(arg0, arg1) = *0x1::vector::borrow<Participant>(arg0, arg2);
        *0x1::vector::borrow_mut<Participant>(arg0, arg2) = *0x1::vector::borrow<Participant>(arg0, arg1);
    }

    fun active_params(arg0: &Pilota04NFT) : u64 {
        count_nonzero5(arg0.boost_power, arg0.boost_timelap, arg0.boost_aero, arg0.boost_brakes, arg0.boost_sosp)
    }

    fun apply_pilot_boosts(arg0: &MONSTER04, arg1: &Pilota04NFT) : (u64, u64, u64, u64, u64) {
        let v0 = arg0.timelap;
        let v1 = if (v0 > arg1.boost_timelap) {
            v0 - arg1.boost_timelap
        } else {
            0
        };
        (arg0.power + arg1.boost_power, v1, arg0.aero + arg1.boost_aero, arg0.brakes + arg1.boost_brakes, arg0.sosp + arg1.boost_sosp)
    }

    public entry fun apply_upgrade04(arg0: &mut MONSTER04, arg1: Upgrade04NFT, arg2: &Meccanico04NFT, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1.power_is_add) {
            arg0.power = arg0.power + arg1.power_delta;
        } else if (arg0.power > arg1.power_delta) {
            arg0.power = arg0.power - arg1.power_delta;
        } else {
            arg0.power = 0;
        };
        if (arg1.timelap_is_add) {
            arg0.timelap = arg0.timelap + arg1.timelap_delta;
        } else if (arg0.timelap > arg1.timelap_delta) {
            arg0.timelap = arg0.timelap - arg1.timelap_delta;
        } else {
            arg0.timelap = 0;
        };
        if (arg1.aero_is_add) {
            arg0.aero = arg0.aero + arg1.aero_delta;
        } else if (arg0.aero > arg1.aero_delta) {
            arg0.aero = arg0.aero - arg1.aero_delta;
        } else {
            arg0.aero = 0;
        };
        if (arg1.brakes_is_add) {
            arg0.brakes = arg0.brakes + arg1.brakes_delta;
        } else if (arg0.brakes > arg1.brakes_delta) {
            arg0.brakes = arg0.brakes - arg1.brakes_delta;
        } else {
            arg0.brakes = 0;
        };
        if (arg1.sosp_is_add) {
            arg0.sosp = arg0.sosp + arg1.sosp_delta;
        } else if (arg0.sosp > arg1.sosp_delta) {
            arg0.sosp = arg0.sosp - arg1.sosp_delta;
        } else {
            arg0.sosp = 0;
        };
        arg0.level = arg0.level + 1;
        0x2::transfer::public_transfer<Upgrade04NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    fun award_loop(arg0: &RacePool04, arg1: &mut PrizeVault04, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 >= arg3) {
            return
        };
        let v0 = 0x1::vector::borrow<Participant>(&arg0.participants, arg2);
        let v1 = arg2 + 1;
        if (v1 == 1) {
            let v2 = take_or_mint_gold(arg1, arg4);
            0x2::transfer::public_transfer<GoldTrophy04>(v2, v0.owner);
            let v3 = take_or_mint_good_upgrade(arg1, arg4);
            0x2::transfer::public_transfer<Upgrade04NFT>(v3, v0.owner);
        } else if (v1 == 2) {
            let v4 = take_or_mint_silver(arg1, arg4);
            0x2::transfer::public_transfer<SilverTrophy04>(v4, v0.owner);
            let v5 = take_or_mint_levelup(arg1, arg4);
            0x2::transfer::public_transfer<LevelUpDriver04NFT>(v5, v0.owner);
        } else if (v1 == 3) {
            let v6 = take_or_mint_bronze(arg1, arg4);
            0x2::transfer::public_transfer<BronzeTrophy04>(v6, v0.owner);
        } else {
            let v7 = Ticket04NFT{
                id        : 0x2::object::new(arg4),
                name      : 0x1::string::utf8(b"Participation Ticket"),
                valid_for : 0x1::string::utf8(b"race04"),
            };
            0x2::transfer::public_transfer<Ticket04NFT>(v7, v0.owner);
            if (v1 == 18) {
                let v8 = take_or_mint_mixed_upgrade(arg1, arg4);
                0x2::transfer::public_transfer<Upgrade04NFT>(v8, v0.owner);
            };
        };
        award_loop(arg0, arg1, arg2 + 1, arg3, arg4);
    }

    fun base_boost_from_code(arg0: u8) : (u64, u64, u64, u64, u64) {
        if (arg0 == 1) {
            return (1, 0, 0, 0, 0)
        };
        if (arg0 == 2) {
            return (0, 1, 0, 0, 0)
        };
        if (arg0 == 3) {
            return (0, 0, 1, 0, 0)
        };
        if (arg0 == 4) {
            return (0, 0, 0, 1, 0)
        };
        if (arg0 == 5) {
            return (0, 0, 0, 0, 1)
        };
        (1, 0, 0, 0, 0)
    }

    fun compute_all_total_times(arg0: &RaceConfig04, arg1: &mut vector<Participant>) {
        let v0 = 0x1::vector::length<Participant>(arg1);
        compute_total_time_0(arg0, arg1, v0);
    }

    fun compute_total_time(arg0: &RaceConfig04, arg1: &mut vector<Participant>, arg2: u64) {
        let v0 = 0x1::vector::borrow<Participant>(arg1, arg2);
        let v1 = v0.power * arg0.w_power + v0.aero * arg0.w_aero + v0.brakes * arg0.w_brakes + v0.sosp * arg0.w_sosp;
        let v2 = if (v1 >= arg0.base_per_mille) {
            1
        } else {
            let v3 = arg0.base_per_mille - v1;
            if (v3 < 1) {
                1
            } else {
                v3
            }
        };
        0x1::vector::borrow_mut<Participant>(arg1, arg2).total_time = v0.timelap * v2 / 1000 * arg0.laps;
    }

    fun compute_total_time_0(arg0: &RaceConfig04, arg1: &mut vector<Participant>, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = arg2 - 1;
        compute_total_time(arg0, arg1, v0);
        compute_total_time_0(arg0, arg1, v0);
    }

    fun contains_address(arg0: &vector<address>, arg1: address) : bool {
        contains_loop(arg0, arg1, 0, 0x1::vector::length<address>(arg0))
    }

    fun contains_loop(arg0: &vector<address>, arg1: address, arg2: u64, arg3: u64) : bool {
        if (arg2 >= arg3) {
            return false
        };
        if (*0x1::vector::borrow<address>(arg0, arg2) == arg1) {
            return true
        };
        contains_loop(arg0, arg1, arg2 + 1, arg3)
    }

    fun count_nonzero5(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg0 > 0) {
            0 + 1
        } else {
            0
        };
        let v1 = if (arg1 > 0) {
            v0 + 1
        } else {
            v0
        };
        let v2 = if (arg2 > 0) {
            v1 + 1
        } else {
            v1
        };
        let v3 = if (arg3 > 0) {
            v2 + 1
        } else {
            v2
        };
        if (arg4 > 0) {
            v3 + 1
        } else {
            v3
        }
    }

    public entry fun create_pool04(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 100);
        assert!(arg0 >= 1, 101);
        assert!(arg1 >= 1, 102);
        let v0 = RaceConfig04{
            laps           : arg0,
            base_per_mille : arg1,
            w_power        : arg2,
            w_aero         : arg3,
            w_brakes       : arg4,
            w_sosp         : arg5,
        };
        let v1 = RacePool04{
            id            : 0x2::object::new(arg6),
            config        : v0,
            participants  : 0x1::vector::empty<Participant>(),
            used_monsters : 0x1::vector::empty<address>(),
            used_pilots   : 0x1::vector::empty<address>(),
            started       : false,
        };
        0x2::transfer::share_object<RacePool04>(v1);
    }

    public entry fun create_prize_vault04(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 300);
        let v0 = PrizeVault04{
            id             : 0x2::object::new(arg0),
            gold           : 0x1::vector::empty<GoldTrophy04>(),
            silver         : 0x1::vector::empty<SilverTrophy04>(),
            bronze         : 0x1::vector::empty<BronzeTrophy04>(),
            levelups       : 0x1::vector::empty<LevelUpDriver04NFT>(),
            good_upgrades  : 0x1::vector::empty<Upgrade04NFT>(),
            mixed_upgrades : 0x1::vector::empty<Upgrade04NFT>(),
        };
        0x2::transfer::share_object<PrizeVault04>(v0);
    }

    public entry fun deposit_bronze(arg0: &mut PrizeVault04, arg1: BronzeTrophy04, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<BronzeTrophy04>(&mut arg0.bronze, arg1);
    }

    public entry fun deposit_gold(arg0: &mut PrizeVault04, arg1: GoldTrophy04, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<GoldTrophy04>(&mut arg0.gold, arg1);
    }

    public entry fun deposit_good_upgrade(arg0: &mut PrizeVault04, arg1: Upgrade04NFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<Upgrade04NFT>(&mut arg0.good_upgrades, arg1);
    }

    public entry fun deposit_levelup(arg0: &mut PrizeVault04, arg1: LevelUpDriver04NFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<LevelUpDriver04NFT>(&mut arg0.levelups, arg1);
    }

    public entry fun deposit_mixed_upgrade(arg0: &mut PrizeVault04, arg1: Upgrade04NFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<Upgrade04NFT>(&mut arg0.mixed_upgrades, arg1);
    }

    public entry fun deposit_silver(arg0: &mut PrizeVault04, arg1: SilverTrophy04, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<SilverTrophy04>(&mut arg0.silver, arg1);
    }

    public entry fun enter_race04(arg0: &mut RacePool04, arg1: MONSTER04, arg2: Ticket04NFT, arg3: &Pilota04NFT, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.started, 110);
        assert!(0x1::vector::length<Participant>(&arg0.participants) < 24, 111);
        assert!(active_params(arg3) <= arg3.level, 112);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        assert!(!contains_address(&arg0.used_monsters, v0), 113);
        assert!(!contains_address(&arg0.used_pilots, v1), 114);
        0x2::transfer::public_transfer<Ticket04NFT>(arg2, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
        let (v2, v3, v4, v5, v6) = apply_pilot_boosts(&arg1, arg3);
        let v7 = Participant{
            owner         : 0x2::tx_context::sender(arg4),
            monster_level : arg1.level,
            power         : v2,
            timelap       : v3,
            aero          : v4,
            brakes        : v5,
            sosp          : v6,
            total_time    : 0,
        };
        0x1::vector::push_back<Participant>(&mut arg0.participants, v7);
        0x1::vector::push_back<address>(&mut arg0.used_monsters, v0);
        0x1::vector::push_back<address>(&mut arg0.used_pilots, v1);
        0x2::transfer::public_transfer<MONSTER04>(arg1, 0x2::tx_context::sender(arg4));
    }

    fun find_min_index(arg0: &mut vector<Participant>, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg2
        };
        let v0 = arg1 - 1;
        let v1 = if (0x1::vector::borrow<Participant>(arg0, v0).total_time < 0x1::vector::borrow<Participant>(arg0, arg2).total_time) {
            v0
        } else {
            arg2
        };
        find_min_index(arg0, v0, v1)
    }

    fun inc_boost_by_code(arg0: &mut Pilota04NFT, arg1: u8, arg2: u64) {
        if (arg1 == 1) {
            arg0.boost_power = arg0.boost_power + arg2;
        } else if (arg1 == 2) {
            arg0.boost_timelap = arg0.boost_timelap + arg2;
        } else if (arg1 == 3) {
            arg0.boost_aero = arg0.boost_aero + arg2;
        } else if (arg1 == 4) {
            arg0.boost_brakes = arg0.boost_brakes + arg2;
        } else if (arg1 == 5) {
            arg0.boost_sosp = arg0.boost_sosp + arg2;
        };
    }

    fun is_active_param(arg0: &Pilota04NFT, arg1: u8) : bool {
        if (arg1 == 1) {
            return arg0.boost_power > 0
        };
        if (arg1 == 2) {
            return arg0.boost_timelap > 0
        };
        if (arg1 == 3) {
            return arg0.boost_aero > 0
        };
        if (arg1 == 4) {
            return arg0.boost_brakes > 0
        };
        if (arg1 == 5) {
            return arg0.boost_sosp > 0
        };
        false
    }

    public entry fun mint_levelupdriver04(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 4);
        let v0 = LevelUpDriver04NFT{
            id    : 0x2::object::new(arg2),
            name  : arg0,
            image : arg1,
        };
        0x2::transfer::public_transfer<LevelUpDriver04NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_meccanico04(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2);
        let v0 = Meccanico04NFT{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            bravura : arg1,
            image   : arg2,
        };
        0x2::transfer::public_transfer<Meccanico04NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_monster04(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 0);
        let v0 = MONSTER04{
            id      : 0x2::object::new(arg7),
            name    : arg0,
            level   : 1,
            power   : arg1,
            timelap : arg2,
            aero    : arg3,
            brakes  : arg4,
            sosp    : arg5,
            image   : arg6,
        };
        0x2::transfer::public_transfer<MONSTER04>(v0, 0x2::tx_context::sender(arg7));
    }

    public entry fun mint_pilota04(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 3);
        let (v0, v1, v2, v3, v4) = base_boost_from_code(arg1);
        let v5 = Pilota04NFT{
            id            : 0x2::object::new(arg3),
            name          : arg0,
            level         : 1,
            boost_power   : v0,
            boost_timelap : v1,
            boost_aero    : v2,
            boost_brakes  : v3,
            boost_sosp    : v4,
            image         : arg2,
        };
        assert!(active_params(&v5) <= v5.level, 31);
        0x2::transfer::public_transfer<Pilota04NFT>(v5, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_ticket04(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 1);
        let v0 = Ticket04NFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            valid_for : arg1,
        };
        0x2::transfer::public_transfer<Ticket04NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_upgrade04(arg0: 0x1::string::String, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: bool, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 5);
        let v0 = Upgrade04NFT{
            id             : 0x2::object::new(arg12),
            name           : arg0,
            power_delta    : arg1,
            power_is_add   : arg2,
            timelap_delta  : arg3,
            timelap_is_add : arg4,
            aero_delta     : arg5,
            aero_is_add    : arg6,
            brakes_delta   : arg7,
            brakes_is_add  : arg8,
            sosp_delta     : arg9,
            sosp_is_add    : arg10,
            image          : arg11,
        };
        0x2::transfer::public_transfer<Upgrade04NFT>(v0, 0x2::tx_context::sender(arg12));
    }

    public entry fun pilot_add_point(arg0: &mut Pilota04NFT, arg1: LevelUpDriver04NFT, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = is_active_param(arg0, arg2);
        inc_boost_by_code(arg0, arg2, 1);
        if (!v0) {
            assert!(active_params(arg0) <= arg0.level, 42);
        };
        0x2::transfer::public_transfer<LevelUpDriver04NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    public entry fun pilot_level_up(arg0: &mut Pilota04NFT, arg1: LevelUpDriver04NFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.level < 5, 40);
        arg0.level = arg0.level + 1;
        assert!(active_params(arg0) <= arg0.level, 41);
        0x2::transfer::public_transfer<LevelUpDriver04NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    public entry fun race_start_finish04(arg0: &mut RacePool04, arg1: &mut PrizeVault04, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 200);
        assert!(!arg0.started, 201);
        assert!(0x1::vector::length<Participant>(&arg0.participants) >= 2, 202);
        arg0.started = true;
        let v0 = &mut arg0.participants;
        compute_all_total_times(&arg0.config, v0);
        let v1 = &mut arg0.participants;
        sort_by_time(v1);
        award_loop(arg0, arg1, 0, 0x1::vector::length<Participant>(&arg0.participants), arg2);
        arg0.participants = 0x1::vector::empty<Participant>();
        arg0.used_monsters = 0x1::vector::empty<address>();
        arg0.used_pilots = 0x1::vector::empty<address>();
        arg0.started = false;
    }

    fun sort_by_time(arg0: &mut vector<Participant>) {
        let v0 = 0x1::vector::length<Participant>(arg0);
        sort_recursive(arg0, v0);
    }

    fun sort_recursive(arg0: &mut vector<Participant>, arg1: u64) {
        if (arg1 <= 1) {
            return
        };
        let v0 = arg1 - 1;
        let v1 = find_min_index(arg0, v0, v0);
        swap(arg0, v0, v1);
        sort_recursive(arg0, v0);
    }

    fun take_or_mint_bronze(arg0: &mut PrizeVault04, arg1: &mut 0x2::tx_context::TxContext) : BronzeTrophy04 {
        if (0x1::vector::length<BronzeTrophy04>(&arg0.bronze) > 0) {
            0x1::vector::pop_back<BronzeTrophy04>(&mut arg0.bronze)
        } else {
            BronzeTrophy04{id: 0x2::object::new(arg1)}
        }
    }

    fun take_or_mint_gold(arg0: &mut PrizeVault04, arg1: &mut 0x2::tx_context::TxContext) : GoldTrophy04 {
        if (0x1::vector::length<GoldTrophy04>(&arg0.gold) > 0) {
            0x1::vector::pop_back<GoldTrophy04>(&mut arg0.gold)
        } else {
            GoldTrophy04{id: 0x2::object::new(arg1)}
        }
    }

    fun take_or_mint_good_upgrade(arg0: &mut PrizeVault04, arg1: &mut 0x2::tx_context::TxContext) : Upgrade04NFT {
        if (0x1::vector::length<Upgrade04NFT>(&arg0.good_upgrades) > 0) {
            0x1::vector::pop_back<Upgrade04NFT>(&mut arg0.good_upgrades)
        } else {
            Upgrade04NFT{id: 0x2::object::new(arg1), name: 0x1::string::utf8(b"Good Upgrade"), power_delta: 2, power_is_add: true, timelap_delta: 1, timelap_is_add: false, aero_delta: 1, aero_is_add: true, brakes_delta: 1, brakes_is_add: true, sosp_delta: 1, sosp_is_add: true, image: 0x1::string::utf8(b"upgrade_good.png")}
        }
    }

    fun take_or_mint_levelup(arg0: &mut PrizeVault04, arg1: &mut 0x2::tx_context::TxContext) : LevelUpDriver04NFT {
        if (0x1::vector::length<LevelUpDriver04NFT>(&arg0.levelups) > 0) {
            0x1::vector::pop_back<LevelUpDriver04NFT>(&mut arg0.levelups)
        } else {
            LevelUpDriver04NFT{id: 0x2::object::new(arg1), name: 0x1::string::utf8(b"LevelUpDriver04"), image: 0x1::string::utf8(b"levelup_default.png")}
        }
    }

    fun take_or_mint_mixed_upgrade(arg0: &mut PrizeVault04, arg1: &mut 0x2::tx_context::TxContext) : Upgrade04NFT {
        if (0x1::vector::length<Upgrade04NFT>(&arg0.mixed_upgrades) > 0) {
            0x1::vector::pop_back<Upgrade04NFT>(&mut arg0.mixed_upgrades)
        } else {
            Upgrade04NFT{id: 0x2::object::new(arg1), name: 0x1::string::utf8(b"Mixed Upgrade"), power_delta: 2, power_is_add: true, timelap_delta: 1, timelap_is_add: true, aero_delta: 0, aero_is_add: true, brakes_delta: 0, brakes_is_add: true, sosp_delta: 0, sosp_is_add: true, image: 0x1::string::utf8(b"upgrade_mixed.png")}
        }
    }

    fun take_or_mint_silver(arg0: &mut PrizeVault04, arg1: &mut 0x2::tx_context::TxContext) : SilverTrophy04 {
        if (0x1::vector::length<SilverTrophy04>(&arg0.silver) > 0) {
            0x1::vector::pop_back<SilverTrophy04>(&mut arg0.silver)
        } else {
            SilverTrophy04{id: 0x2::object::new(arg1)}
        }
    }

    // decompiled from Move bytecode v6
}

