module 0x2a28fe9a4f5211a4f856085e50427ce9b4870486ffc9a99be04d6e91cdb3fccb::racepool05 {
    struct MONSTER05 has store, key {
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

    struct Ticket05NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        valid_for: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Meccanico05NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        bravura: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct Pilota05NFT has store, key {
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

    struct LevelUpDriver05NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct UpgradeBM05NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        inc_code: u8,
        dec_code: u8,
        level: u8,
        image: 0x1::string::String,
    }

    struct DriverUpgradeBM05NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        inc_code: u8,
        dec_code: u8,
        level: u8,
        image: 0x1::string::String,
    }

    struct GoldTrophy05 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct SilverTrophy05 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct BronzeTrophy05 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
    }

    struct RaceLifecycleEvent has copy, drop {
        action: 0x1::string::String,
        pool_id: address,
        laps: u64,
        base_per_mille: u64,
        w_power: u64,
        w_aero: u64,
        w_brakes: u64,
        w_sosp: u64,
    }

    struct RankEvent has copy, drop {
        pool_id: address,
        rank: u64,
        owner: address,
        monster_level: u64,
        power: u64,
        timelap: u64,
        aero: u64,
        brakes: u64,
        sosp: u64,
        total_time: u64,
    }

    struct RaceConfig05 has copy, drop, store {
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

    struct RacePool05 has store, key {
        id: 0x2::object::UID,
        config: RaceConfig05,
        participants: vector<Participant>,
        used_monsters: vector<address>,
        used_pilots: vector<address>,
        started: bool,
    }

    struct PrizeVault05 has store, key {
        id: 0x2::object::UID,
        gold: vector<GoldTrophy05>,
        silver: vector<SilverTrophy05>,
        bronze: vector<BronzeTrophy05>,
    }

    fun swap(arg0: &mut vector<Participant>, arg1: u64, arg2: u64) {
        if (arg1 == arg2) {
            return
        };
        *0x1::vector::borrow_mut<Participant>(arg0, arg1) = *0x1::vector::borrow<Participant>(arg0, arg2);
        *0x1::vector::borrow_mut<Participant>(arg0, arg2) = *0x1::vector::borrow<Participant>(arg0, arg1);
    }

    fun active_params(arg0: &Pilota05NFT) : u64 {
        count_nonzero5(arg0.boost_power, arg0.boost_timelap, arg0.boost_aero, arg0.boost_brakes, arg0.boost_sosp)
    }

    fun apply_delta(arg0: &mut MONSTER05, arg1: u8, arg2: bool, arg3: u64) {
        if (arg1 == 1) {
            if (arg2) {
                arg0.power = arg0.power + arg3;
            } else {
                let v0 = if (arg0.power > arg3) {
                    arg0.power - arg3
                } else {
                    0
                };
                arg0.power = v0;
            };
        } else if (arg1 == 2) {
            if (arg2) {
                arg0.timelap = arg0.timelap + arg3;
            } else {
                let v1 = if (arg0.timelap > arg3) {
                    arg0.timelap - arg3
                } else {
                    0
                };
                arg0.timelap = v1;
            };
        } else if (arg1 == 3) {
            if (arg2) {
                arg0.aero = arg0.aero + arg3;
            } else {
                let v2 = if (arg0.aero > arg3) {
                    arg0.aero - arg3
                } else {
                    0
                };
                arg0.aero = v2;
            };
        } else if (arg1 == 4) {
            if (arg2) {
                arg0.brakes = arg0.brakes + arg3;
            } else {
                let v3 = if (arg0.brakes > arg3) {
                    arg0.brakes - arg3
                } else {
                    0
                };
                arg0.brakes = v3;
            };
        } else {
            assert!(arg1 == 5, 599);
            if (arg2) {
                arg0.sosp = arg0.sosp + arg3;
            } else {
                let v4 = if (arg0.sosp > arg3) {
                    arg0.sosp - arg3
                } else {
                    0
                };
                arg0.sosp = v4;
            };
        };
    }

    fun apply_driver_delta(arg0: &mut Pilota05NFT, arg1: u8, arg2: bool, arg3: u64) {
        if (arg1 == 1) {
            if (arg2) {
                arg0.boost_power = arg0.boost_power + arg3;
            } else {
                let v0 = if (arg0.boost_power > arg3) {
                    arg0.boost_power - arg3
                } else {
                    0
                };
                arg0.boost_power = v0;
            };
        } else if (arg1 == 2) {
            if (arg2) {
                arg0.boost_timelap = arg0.boost_timelap + arg3;
            } else {
                let v1 = if (arg0.boost_timelap > arg3) {
                    arg0.boost_timelap - arg3
                } else {
                    0
                };
                arg0.boost_timelap = v1;
            };
        } else if (arg1 == 3) {
            if (arg2) {
                arg0.boost_aero = arg0.boost_aero + arg3;
            } else {
                let v2 = if (arg0.boost_aero > arg3) {
                    arg0.boost_aero - arg3
                } else {
                    0
                };
                arg0.boost_aero = v2;
            };
        } else if (arg1 == 4) {
            if (arg2) {
                arg0.boost_brakes = arg0.boost_brakes + arg3;
            } else {
                let v3 = if (arg0.boost_brakes > arg3) {
                    arg0.boost_brakes - arg3
                } else {
                    0
                };
                arg0.boost_brakes = v3;
            };
        } else {
            assert!(arg1 == 5, 655);
            if (arg2) {
                arg0.boost_sosp = arg0.boost_sosp + arg3;
            } else {
                let v4 = if (arg0.boost_sosp > arg3) {
                    arg0.boost_sosp - arg3
                } else {
                    0
                };
                arg0.boost_sosp = v4;
            };
        };
    }

    public entry fun apply_driver_upgrade05(arg0: &mut Pilota05NFT, arg1: DriverUpgradeBM05NFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1.level as u64);
        apply_driver_delta(arg0, arg1.inc_code, true, v0);
        apply_driver_delta(arg0, arg1.dec_code, false, v0);
        0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    fun apply_pilot_boosts_m(arg0: &MONSTER05, arg1: &Pilota05NFT) : (u64, u64, u64, u64, u64) {
        let v0 = arg0.timelap;
        let v1 = if (v0 > arg1.boost_timelap) {
            v0 - arg1.boost_timelap
        } else {
            0
        };
        (arg0.power + arg1.boost_power, v1, arg0.aero + arg1.boost_aero, arg0.brakes + arg1.boost_brakes, arg0.sosp + arg1.boost_sosp)
    }

    public entry fun apply_upgrade05(arg0: &mut MONSTER05, arg1: UpgradeBM05NFT, arg2: &Meccanico05NFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1.level as u64);
        apply_delta(arg0, arg1.inc_code, true, v0);
        apply_delta(arg0, arg1.dec_code, false, v0);
        arg0.level = arg0.level + 1;
        0x2::transfer::public_transfer<UpgradeBM05NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    fun award_loop(arg0: &RacePool05, arg1: &mut PrizeVault05, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 >= arg3) {
            return
        };
        let v0 = 0x1::vector::borrow<Participant>(&arg0.participants, arg2);
        let v1 = arg2 + 1;
        if (v1 == 1) {
            let v2 = take_or_mint_gold(arg1, arg4);
            0x2::transfer::public_transfer<GoldTrophy05>(v2, v0.owner);
        } else if (v1 == 2) {
            let v3 = take_or_mint_silver(arg1, arg4);
            0x2::transfer::public_transfer<SilverTrophy05>(v3, v0.owner);
        } else if (v1 == 3) {
            let v4 = take_or_mint_bronze(arg1, arg4);
            0x2::transfer::public_transfer<BronzeTrophy05>(v4, v0.owner);
        } else if (v1 == 4) {
            let v5 = Ticket05NFT{
                id        : 0x2::object::new(arg4),
                name      : 0x1::string::utf8(b"Race Ticket"),
                valid_for : 0x1::string::utf8(b"race05"),
                image     : 0x1::string::utf8(b"ticket.png"),
            };
            0x2::transfer::public_transfer<Ticket05NFT>(v5, v0.owner);
        } else if (v1 == 5) {
            let v6 = make_driver_upgrade_custom(1, 3, 1, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v6, v0.owner);
        } else if (v1 == 6) {
            let v7 = make_monster_upgrade_custom(1, 3, 1, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v7, v0.owner);
        } else if (v1 == 7) {
            let v8 = make_driver_upgrade_custom(3, 4, 1, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v8, v0.owner);
        } else if (v1 == 8) {
            let v9 = make_monster_upgrade_custom(3, 4, 1, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v9, v0.owner);
        } else if (v1 == 9) {
            let v10 = make_driver_upgrade_custom(4, 5, 1, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v10, v0.owner);
        } else if (v1 == 10) {
            let v11 = make_monster_upgrade_custom(4, 5, 1, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v11, v0.owner);
        } else if (v1 == 11) {
            let v12 = make_driver_upgrade_custom(5, 1, 1, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v12, v0.owner);
        } else if (v1 == 12) {
            let v13 = make_monster_upgrade_custom(5, 1, 1, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v13, v0.owner);
        } else if (v1 == 13) {
            let v14 = make_driver_upgrade_custom(1, 4, 1, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v14, v0.owner);
        } else if (v1 == 14) {
            let v15 = make_monster_upgrade_custom(1, 4, 1, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v15, v0.owner);
        } else if (v1 == 15) {
            let v16 = make_driver_upgrade_custom(3, 5, 1, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v16, v0.owner);
        } else if (v1 == 16) {
            let v17 = make_monster_upgrade_custom(3, 5, 1, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v17, v0.owner);
        } else if (v1 == 17) {
            let v18 = make_driver_upgrade_custom(4, 1, 2, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v18, v0.owner);
        } else if (v1 == 18) {
            let v19 = make_monster_upgrade_custom(4, 1, 2, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v19, v0.owner);
            let v20 = Ticket05NFT{
                id        : 0x2::object::new(arg4),
                name      : 0x1::string::utf8(b"Race Ticket"),
                valid_for : 0x1::string::utf8(b"race05"),
                image     : 0x1::string::utf8(b"ticket.png"),
            };
            0x2::transfer::public_transfer<Ticket05NFT>(v20, v0.owner);
        } else if (v1 == 19) {
            let v21 = make_driver_upgrade_custom(5, 3, 2, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v21, v0.owner);
        } else if (v1 == 20) {
            let v22 = make_monster_upgrade_custom(5, 3, 2, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v22, v0.owner);
        } else if (v1 == 21) {
            let v23 = make_driver_upgrade_custom(1, 5, 3, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v23, v0.owner);
        } else if (v1 == 22) {
            let v24 = make_monster_upgrade_custom(1, 5, 3, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v24, v0.owner);
        } else if (v1 == 23) {
            let v25 = make_driver_upgrade_custom(4, 3, 3, arg4);
            0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v25, v0.owner);
        } else if (v1 == 24) {
            let v26 = make_monster_upgrade_custom(4, 3, 3, arg4);
            0x2::transfer::public_transfer<UpgradeBM05NFT>(v26, v0.owner);
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

    fun compute_all_total_times(arg0: &RaceConfig05, arg1: &mut vector<Participant>) {
        let v0 = 0x1::vector::length<Participant>(arg1);
        compute_total_time_0(arg0, arg1, v0);
    }

    fun compute_total_time(arg0: &RaceConfig05, arg1: &mut vector<Participant>, arg2: u64) {
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

    fun compute_total_time_0(arg0: &RaceConfig05, arg1: &mut vector<Participant>, arg2: u64) {
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

    public entry fun create_pool05(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 100);
        assert!(arg0 >= 1, 101);
        assert!(arg1 >= 1, 102);
        let v0 = RaceConfig05{
            laps           : arg0,
            base_per_mille : arg1,
            w_power        : arg2,
            w_aero         : arg3,
            w_brakes       : arg4,
            w_sosp         : arg5,
        };
        let v1 = RacePool05{
            id            : 0x2::object::new(arg6),
            config        : v0,
            participants  : 0x1::vector::empty<Participant>(),
            used_monsters : 0x1::vector::empty<address>(),
            used_pilots   : 0x1::vector::empty<address>(),
            started       : false,
        };
        0x2::transfer::share_object<RacePool05>(v1);
    }

    public entry fun create_prize_vault05(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 300);
        let v0 = PrizeVault05{
            id     : 0x2::object::new(arg0),
            gold   : 0x1::vector::empty<GoldTrophy05>(),
            silver : 0x1::vector::empty<SilverTrophy05>(),
            bronze : 0x1::vector::empty<BronzeTrophy05>(),
        };
        0x2::transfer::share_object<PrizeVault05>(v0);
    }

    public entry fun deposit_bronze(arg0: &mut PrizeVault05, arg1: BronzeTrophy05, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<BronzeTrophy05>(&mut arg0.bronze, arg1);
    }

    public entry fun deposit_gold(arg0: &mut PrizeVault05, arg1: GoldTrophy05, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<GoldTrophy05>(&mut arg0.gold, arg1);
    }

    public entry fun deposit_silver(arg0: &mut PrizeVault05, arg1: SilverTrophy05, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<SilverTrophy05>(&mut arg0.silver, arg1);
    }

    fun emit_finish(arg0: &RacePool05, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaceLifecycleEvent{
            action         : 0x1::string::utf8(b"FINISH"),
            pool_id        : 0x2::object::uid_to_address(&arg0.id),
            laps           : arg0.config.laps,
            base_per_mille : arg0.config.base_per_mille,
            w_power        : arg0.config.w_power,
            w_aero         : arg0.config.w_aero,
            w_brakes       : arg0.config.w_brakes,
            w_sosp         : arg0.config.w_sosp,
        };
        0x2::event::emit<RaceLifecycleEvent>(v0);
        emit_ranks_loop(arg0, 0, 0x1::vector::length<Participant>(&arg0.participants), arg1);
    }

    fun emit_ranks_loop(arg0: &RacePool05, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 >= arg2) {
            return
        };
        let v0 = 0x1::vector::borrow<Participant>(&arg0.participants, arg1);
        let v1 = RankEvent{
            pool_id       : 0x2::object::uid_to_address(&arg0.id),
            rank          : arg1 + 1,
            owner         : v0.owner,
            monster_level : v0.monster_level,
            power         : v0.power,
            timelap       : v0.timelap,
            aero          : v0.aero,
            brakes        : v0.brakes,
            sosp          : v0.sosp,
            total_time    : v0.total_time,
        };
        0x2::event::emit<RankEvent>(v1);
        emit_ranks_loop(arg0, arg1 + 1, arg2, arg3);
    }

    fun emit_start(arg0: &RacePool05, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RaceLifecycleEvent{
            action         : 0x1::string::utf8(b"START"),
            pool_id        : 0x2::object::uid_to_address(&arg0.id),
            laps           : arg0.config.laps,
            base_per_mille : arg0.config.base_per_mille,
            w_power        : arg0.config.w_power,
            w_aero         : arg0.config.w_aero,
            w_brakes       : arg0.config.w_brakes,
            w_sosp         : arg0.config.w_sosp,
        };
        0x2::event::emit<RaceLifecycleEvent>(v0);
    }

    public entry fun enter_race05(arg0: &mut RacePool05, arg1: MONSTER05, arg2: Ticket05NFT, arg3: &Pilota05NFT, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.started, 110);
        assert!(0x1::vector::length<Participant>(&arg0.participants) < 24, 111);
        assert!(active_params(arg3) <= arg3.level, 112);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        assert!(!contains_address(&arg0.used_monsters, v0), 113);
        assert!(!contains_address(&arg0.used_pilots, v1), 114);
        0x2::transfer::public_transfer<Ticket05NFT>(arg2, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
        let (v2, v3, v4, v5, v6) = apply_pilot_boosts_m(&arg1, arg3);
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
        0x2::transfer::public_transfer<MONSTER05>(arg1, 0x2::tx_context::sender(arg4));
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

    public entry fun finish_race05(arg0: &mut RacePool05, arg1: &mut PrizeVault05, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2010);
        assert!(arg0.started, 2011);
        let v0 = &mut arg0.participants;
        compute_all_total_times(&arg0.config, v0);
        let v1 = &mut arg0.participants;
        sort_by_time(v1);
        award_loop(arg0, arg1, 0, 0x1::vector::length<Participant>(&arg0.participants), arg3);
        emit_finish(arg0, arg3);
        if (arg2) {
            arg0.participants = 0x1::vector::empty<Participant>();
            arg0.used_monsters = 0x1::vector::empty<address>();
            arg0.used_pilots = 0x1::vector::empty<address>();
            arg0.started = true;
        } else {
            arg0.started = false;
        };
    }

    fun inc_boost_by_code(arg0: &mut Pilota05NFT, arg1: u8, arg2: u64) {
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

    fun is_active_param(arg0: &Pilota05NFT, arg1: u8) : bool {
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

    fun is_valid_code(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun make_driver_upgrade_custom(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : DriverUpgradeBM05NFT {
        DriverUpgradeBM05NFT{
            id       : 0x2::object::new(arg3),
            name     : 0x1::string::utf8(b"Driver BM"),
            inc_code : arg0,
            dec_code : arg1,
            level    : arg2,
            image    : 0x1::string::utf8(b"upg_driver.png"),
        }
    }

    fun make_monster_upgrade_custom(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : UpgradeBM05NFT {
        UpgradeBM05NFT{
            id       : 0x2::object::new(arg3),
            name     : 0x1::string::utf8(b"Monster BM"),
            inc_code : arg0,
            dec_code : arg1,
            level    : arg2,
            image    : 0x1::string::utf8(b"upg_monster.png"),
        }
    }

    public entry fun mint_driver_upgrade_bm05(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 405);
        assert!(is_valid_code(arg1), 451);
        assert!(is_valid_code(arg2), 452);
        assert!(arg1 != arg2, 453);
        assert!(arg3 >= 1 && arg3 <= 10, 456);
        let v0 = DriverUpgradeBM05NFT{
            id       : 0x2::object::new(arg5),
            name     : arg0,
            inc_code : arg1,
            dec_code : arg2,
            level    : arg3,
            image    : arg4,
        };
        0x2::transfer::public_transfer<DriverUpgradeBM05NFT>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun mint_levelupdriver05(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 4);
        let v0 = LevelUpDriver05NFT{
            id    : 0x2::object::new(arg2),
            name  : arg0,
            image : arg1,
        };
        0x2::transfer::public_transfer<LevelUpDriver05NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_meccanico05(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2);
        let v0 = Meccanico05NFT{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            bravura : arg1,
            image   : arg2,
        };
        0x2::transfer::public_transfer<Meccanico05NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_monster05(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 0);
        let v0 = MONSTER05{
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
        0x2::transfer::public_transfer<MONSTER05>(v0, 0x2::tx_context::sender(arg7));
    }

    public entry fun mint_pilota05(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 3);
        let (v0, v1, v2, v3, v4) = base_boost_from_code(arg1);
        let v5 = Pilota05NFT{
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
        0x2::transfer::public_transfer<Pilota05NFT>(v5, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_ticket05(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 1);
        let v0 = Ticket05NFT{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            valid_for : arg1,
            image     : arg2,
        };
        0x2::transfer::public_transfer<Ticket05NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_upgrade_bm05(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 5);
        assert!(is_valid_code(arg1), 501);
        assert!(is_valid_code(arg2), 502);
        assert!(arg1 != arg2, 503);
        assert!(arg3 >= 1 && arg3 <= 10, 506);
        let v0 = UpgradeBM05NFT{
            id       : 0x2::object::new(arg5),
            name     : arg0,
            inc_code : arg1,
            dec_code : arg2,
            level    : arg3,
            image    : arg4,
        };
        0x2::transfer::public_transfer<UpgradeBM05NFT>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun pilot_add_point(arg0: &mut Pilota05NFT, arg1: LevelUpDriver05NFT, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = is_active_param(arg0, arg2);
        inc_boost_by_code(arg0, arg2, 1);
        if (!v0) {
            assert!(active_params(arg0) <= arg0.level, 42);
        };
        0x2::transfer::public_transfer<LevelUpDriver05NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    public entry fun pilot_level_up(arg0: &mut Pilota05NFT, arg1: LevelUpDriver05NFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.level < 5, 40);
        arg0.level = arg0.level + 1;
        assert!(active_params(arg0) <= arg0.level, 41);
        0x2::transfer::public_transfer<LevelUpDriver05NFT>(arg1, @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded);
    }

    public entry fun reset_pool05(arg0: &mut RacePool05, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2020);
        assert!(!arg0.started, 2021);
        arg0.participants = 0x1::vector::empty<Participant>();
        arg0.used_monsters = 0x1::vector::empty<address>();
        arg0.used_pilots = 0x1::vector::empty<address>();
        let v0 = RaceLifecycleEvent{
            action         : 0x1::string::utf8(b"RESET"),
            pool_id        : 0x2::object::uid_to_address(&arg0.id),
            laps           : arg0.config.laps,
            base_per_mille : arg0.config.base_per_mille,
            w_power        : arg0.config.w_power,
            w_aero         : arg0.config.w_aero,
            w_brakes       : arg0.config.w_brakes,
            w_sosp         : arg0.config.w_sosp,
        };
        0x2::event::emit<RaceLifecycleEvent>(v0);
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

    public entry fun start_race05(arg0: &mut RacePool05, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2000);
        assert!(!arg0.started, 2001);
        assert!(0x1::vector::length<Participant>(&arg0.participants) >= 2, 2002);
        arg0.started = true;
        emit_start(arg0, arg1);
    }

    fun take_or_mint_bronze(arg0: &mut PrizeVault05, arg1: &mut 0x2::tx_context::TxContext) : BronzeTrophy05 {
        if (0x1::vector::length<BronzeTrophy05>(&arg0.bronze) > 0) {
            0x1::vector::pop_back<BronzeTrophy05>(&mut arg0.bronze)
        } else {
            BronzeTrophy05{id: 0x2::object::new(arg1), name: 0x1::string::utf8(b"Bronze Trophy"), image: 0x1::string::utf8(b"bronze_trophy.png")}
        }
    }

    fun take_or_mint_gold(arg0: &mut PrizeVault05, arg1: &mut 0x2::tx_context::TxContext) : GoldTrophy05 {
        if (0x1::vector::length<GoldTrophy05>(&arg0.gold) > 0) {
            0x1::vector::pop_back<GoldTrophy05>(&mut arg0.gold)
        } else {
            GoldTrophy05{id: 0x2::object::new(arg1), name: 0x1::string::utf8(b"Gold Trophy"), image: 0x1::string::utf8(b"gold_trophy.png")}
        }
    }

    fun take_or_mint_silver(arg0: &mut PrizeVault05, arg1: &mut 0x2::tx_context::TxContext) : SilverTrophy05 {
        if (0x1::vector::length<SilverTrophy05>(&arg0.silver) > 0) {
            0x1::vector::pop_back<SilverTrophy05>(&mut arg0.silver)
        } else {
            SilverTrophy05{id: 0x2::object::new(arg1), name: 0x1::string::utf8(b"Silver Trophy"), image: 0x1::string::utf8(b"silver_trophy.png")}
        }
    }

    // decompiled from Move bytecode v6
}

