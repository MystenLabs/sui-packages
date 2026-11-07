module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig {
    struct Dig has key {
        id: 0x2::object::UID,
        version: u64,
        shed: 0x2::object::ID,
        open: bool,
        season: u64,
        start_day: u64,
        end_day: u64,
        per_day: u64,
        bank: u64,
        daily_max: u64,
        pack: u64,
        pack_price: u64,
        payee: address,
        milestones: vector<u64>,
        chance_first: u64,
        chance_step: u64,
        scrap_per_dig: u64,
        scrap_spent: u64,
        wallets: 0x2::table::Table<address, Ledger>,
        holes: 0x2::table::Table<HoleKey, Hole>,
        chests: 0x2::table::Table<address, vector<Chest>>,
    }

    struct HoleKey has copy, drop, store {
        season: u64,
        grave: 0x2::object::ID,
    }

    struct Hole has drop, store {
        depth: u64,
        passed: u64,
    }

    struct Chest has copy, drop, store {
        season: u64,
        grave: 0x2::object::ID,
        milestone: u8,
    }

    struct Ledger has store {
        season: u64,
        day: u64,
        pending: u64,
        paid: u64,
        today_day: u64,
        today: u64,
        work: u64,
        scrap: u64,
        chances: u64,
        finished: u64,
        digs: u64,
    }

    struct DigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BindKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SeasonBindKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Bind has drop, store {
        wallet: address,
        day: u64,
    }

    struct BandsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Proof {
        wallet: address,
        graves: vector<0x2::object::ID>,
    }

    struct DigOpened has copy, drop {
        dig: 0x2::object::ID,
        shed: 0x2::object::ID,
    }

    struct DigConfigured has copy, drop {
        dig: 0x2::object::ID,
        open: bool,
        per_day: u64,
        bank: u64,
        daily_max: u64,
        pack: u64,
        pack_price: u64,
        payee: address,
    }

    struct SeasonSet has copy, drop {
        dig: 0x2::object::ID,
        season: u64,
        start_day: u64,
        end_day: u64,
    }

    struct Enrolled has copy, drop {
        season: u64,
        wallet: address,
        grave: 0x2::object::ID,
        pending: u64,
        paid: u64,
    }

    struct PacksBought has copy, drop {
        season: u64,
        wallet: address,
        packs: u64,
        credits: u64,
        paid_mist: u64,
        pending: u64,
        paid: u64,
    }

    struct Dug has copy, drop {
        season: u64,
        wallet: address,
        grave: 0x2::object::ID,
        shovel: 0x2::object::ID,
        times: u64,
        each: u64,
        bonus_bps: u64,
        depth: u64,
        work: u64,
        dug: u64,
        durability: u64,
        scrap: u64,
        paid: u64,
    }

    struct ChestEarned has copy, drop {
        season: u64,
        grave: 0x2::object::ID,
        milestone: u8,
        depth: u64,
        by: address,
    }

    struct ChanceEarned has copy, drop {
        season: u64,
        wallet: address,
        work: u64,
        chances: u64,
    }

    struct ShovelBroken has copy, drop {
        shovel: 0x2::object::ID,
        repairs: u64,
    }

    struct ShovelSpent has copy, drop {
        shovel: 0x2::object::ID,
        serial: u64,
        dug: u64,
        scrap: u64,
        by: address,
    }

    struct ScrapMoved has copy, drop {
        wallet: address,
        units: u64,
        out: bool,
        held: u64,
    }

    struct MilestonesSet has copy, drop {
        dig: 0x2::object::ID,
        milestones: vector<u64>,
        chance_first: u64,
        chance_step: u64,
        scrap_per_dig: u64,
        scrap_spent: u64,
    }

    entry fun dig(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        dig_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public(friend) fun add_scrap(arg0: &mut Dig, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, Ledger>(&arg0.wallets, arg1)) {
            0x2::table::add<address, Ledger>(&mut arg0.wallets, arg1, blank());
        };
        let v0 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, arg1);
        v0.scrap = v0.scrap + arg2;
    }

    public(friend) fun admin_ok(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &Dig) {
        check_admin(arg0, arg1);
    }

    public(friend) fun assert_current(arg0: &Dig) {
        check_version(arg0);
    }

    fun bind(arg0: &mut Dig, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BindKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<BindKey>(&arg0.id, v0)) {
            let v1 = BindKey{dummy_field: false};
            0x2::dynamic_field::add<BindKey, 0x2::table::Table<0x2::object::ID, Bind>>(&mut arg0.id, v1, 0x2::table::new<0x2::object::ID, Bind>(arg4));
        };
        let v2 = BindKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<BindKey, 0x2::table::Table<0x2::object::ID, Bind>>(&mut arg0.id, v2);
        if (0x2::table::contains<0x2::object::ID, Bind>(v3, arg1)) {
            let v4 = 0x2::table::borrow_mut<0x2::object::ID, Bind>(v3, arg1);
            assert!(v4.day != arg3 || v4.wallet == arg2, 480);
            v4.wallet = arg2;
            v4.day = arg3;
        } else {
            let v5 = Bind{
                wallet : arg2,
                day    : arg3,
            };
            0x2::table::add<0x2::object::ID, Bind>(v3, arg1, v5);
        };
        let v6 = SeasonBindKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SeasonBindKey>(&arg0.id, v6)) {
            let v7 = SeasonBindKey{dummy_field: false};
            0x2::dynamic_field::add<SeasonBindKey, 0x2::table::Table<HoleKey, vector<address>>>(&mut arg0.id, v7, 0x2::table::new<HoleKey, vector<address>>(arg4));
        };
        let v8 = SeasonBindKey{dummy_field: false};
        let v9 = 0x2::dynamic_field::borrow_mut<SeasonBindKey, 0x2::table::Table<HoleKey, vector<address>>>(&mut arg0.id, v8);
        let v10 = HoleKey{
            season : arg0.season,
            grave  : arg1,
        };
        if (!0x2::table::contains<HoleKey, vector<address>>(v9, v10)) {
            let v11 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v11, arg2);
            0x2::table::add<HoleKey, vector<address>>(v9, v10, v11);
        } else {
            let v12 = 0x2::table::borrow_mut<HoleKey, vector<address>>(v9, v10);
            if (!0x1::vector::contains<address>(v12, &arg2)) {
                assert!(0x1::vector::length<address>(v12) < 2, 483);
                0x1::vector::push_back<address>(v12, arg2);
            };
        };
    }

    fun blank() : Ledger {
        Ledger{
            season    : 0,
            day       : 0,
            pending   : 0,
            paid      : 0,
            today_day : 0,
            today     : 0,
            work      : 0,
            scrap     : 0,
            chances   : 0,
            finished  : 0,
            digs      : 0,
        }
    }

    public fun bonus_for(arg0: &Dig, arg1: u64) : u64 {
        let v0 = BandsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<BandsKey>(&arg0.id, v0)) {
            return 10000
        };
        let v1 = BandsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<BandsKey, vector<vector<u64>>>(&arg0.id, v1);
        let v3 = 10000;
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u64>>(v2)) {
            let v5 = 0x1::vector::borrow<vector<u64>>(v2, v4);
            if (arg1 >= *0x1::vector::borrow<u64>(v5, 0) && *0x1::vector::borrow<u64>(v5, 1) > v3) {
                v3 = *0x1::vector::borrow<u64>(v5, 1);
            };
            v4 = v4 + 1;
        };
        v3
    }

    fun buy_(arg0: &mut Dig, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = running(arg0, arg6);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::prove(arg1, arg2, arg3, false);
        assert!(arg4 >= 1, 467);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = arg4 * arg0.pack;
        let v3 = arg4 * arg0.pack_price;
        let v4 = arg0.payee;
        let v5 = arg0.season;
        let v6 = ledger_mut(arg0, v1, v0);
        assert!(v6.pending >= v2, 468);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v3, 469);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v3, arg7), v4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v3, arg7));
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        v6.pending = v6.pending - v2;
        v6.paid = v6.paid + v2;
        let v7 = PacksBought{
            season    : v5,
            wallet    : v1,
            packs     : arg4,
            credits   : v2,
            paid_mist : v3,
            pending   : v6.pending,
            paid      : v6.paid,
        };
        0x2::event::emit<PacksBought>(v7);
    }

    entry fun buy_packs(arg0: &mut Dig, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        buy_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun buy_packs_personal(arg0: &mut Dig, arg1: &0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        buy_(arg0, arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3, arg4, arg5, arg6, arg7);
    }

    fun chances_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 < arg1) {
            0
        } else {
            (arg0 - arg1) / arg2 + 1
        }
    }

    fun check_admin(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &Dig) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == arg1.shed, 461);
        check_version(arg1);
    }

    fun check_version(arg0: &Dig) {
        assert!(arg0.version == 2, 460);
    }

    public fun chest_grave(arg0: &Chest) : 0x2::object::ID {
        arg0.grave
    }

    public fun chest_milestone(arg0: &Chest) : u8 {
        arg0.milestone
    }

    public fun chest_season(arg0: &Chest) : u64 {
        arg0.season
    }

    public fun chests(arg0: &Dig, arg1: address) : vector<Chest> {
        if (0x2::table::contains<address, vector<Chest>>(&arg0.chests, arg1)) {
            *0x2::table::borrow<address, vector<Chest>>(&arg0.chests, arg1)
        } else {
            0x1::vector::empty<Chest>()
        }
    }

    fun configured(arg0: &Dig) {
        let v0 = DigConfigured{
            dig        : 0x2::object::id<Dig>(arg0),
            open       : arg0.open,
            per_day    : arg0.per_day,
            bank       : arg0.bank,
            daily_max  : arg0.daily_max,
            pack       : arg0.pack,
            pack_price : arg0.pack_price,
            payee      : arg0.payee,
        };
        0x2::event::emit<DigConfigured>(v0);
    }

    public fun credits(arg0: &Dig, arg1: address, arg2: &0x2::clock::Clock) : (bool, u64, u64, u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, Ledger>(&arg0.wallets, arg1)) {
            return (false, 0, 0, 0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Ledger>(&arg0.wallets, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 86400000;
        let v2 = arg0.season > 0 && v0.season == arg0.season;
        let v3 = if (v2) {
            let (v4, _) = issued(v0, arg0.per_day, arg0.bank, arg0.end_day, v1);
            v4
        } else {
            0
        };
        let v6 = if (v2 && v0.today_day == v1) {
            v0.today
        } else {
            0
        };
        let v7 = if (arg0.daily_max > v6) {
            arg0.daily_max - v6
        } else {
            0
        };
        let v8 = if (v2) {
            v0.work
        } else {
            0
        };
        (v2, v3, v0.paid, v7, v8, v0.scrap, v0.chances, v0.digs)
    }

    fun dig_(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = running(arg0, arg7);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::prove(arg2, arg3, arg4, false);
        let v1 = 0x2::tx_context::sender(arg8);
        bind(arg0, arg4, v1, v0, arg8);
        dig_core(arg0, arg1, arg4, arg5, arg6, 10000, v0, arg7, arg8);
    }

    fun dig_core(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: 0x2::object::ID, arg3: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1) == arg0.shed, 461);
        assert!(arg4 >= 1, 474);
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dig_terms(arg1, &arg3);
        let v3 = v1 * arg5 / 10000;
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::durability(&arg3) >= arg4 * v2, 477);
        let v4 = arg0.season;
        let v5 = arg0.daily_max;
        let v6 = arg0.scrap_per_dig;
        let v7 = arg0.chance_first;
        let v8 = arg0.chance_step;
        let v9 = ledger_mut(arg0, v0, arg6);
        assert!(v9.paid >= arg4, 475);
        assert!(v9.today + arg4 <= v5, 476);
        let v10 = v9.work;
        v9.paid = v9.paid - arg4;
        v9.today = v9.today + arg4;
        v9.digs = v9.digs + arg4;
        v9.work = v9.work + arg4 * v3;
        v9.scrap = v9.scrap + arg4 * v6;
        let v11 = chances_in(v9.work, v7, v8) - chances_in(v10, v7, v8);
        v9.chances = v9.chances + v11;
        let v12 = v9.work;
        let v13 = v9.scrap;
        if (v11 > 0) {
            let v14 = ChanceEarned{
                season  : v4,
                wallet  : v0,
                work    : v12,
                chances : v11,
            };
            0x2::event::emit<ChanceEarned>(v14);
        };
        if (v9.finished != v4 && 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::has_book_here(&arg0.id)) {
            let v15 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(&mut arg0.id);
            let v16 = if (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::is_open(v15)) {
                if (v10 < 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::finish_line(v15)) {
                    v12 >= 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::finish_line(v15)
                } else {
                    false
                }
            } else {
                false
            };
            if (v16) {
                0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::Discovery>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::mint_common(v15, v4, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::by_finishing(), v0, arg8), v0);
                0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, v0).finished = v4;
            };
        };
        let v17 = HoleKey{
            season : v4,
            grave  : arg2,
        };
        if (!0x2::table::contains<HoleKey, Hole>(&arg0.holes, v17)) {
            let v18 = Hole{
                depth  : 0,
                passed : 0,
            };
            0x2::table::add<HoleKey, Hole>(&mut arg0.holes, v17, v18);
        };
        let v19 = arg0.milestones;
        let v20 = 0x2::table::borrow_mut<HoleKey, Hole>(&mut arg0.holes, v17);
        v20.depth = v20.depth + arg4 * v3;
        let v21 = v20.depth;
        let v22 = 0x1::vector::empty<Chest>();
        let v23 = 0;
        while (v23 < 0x1::vector::length<u64>(&v19)) {
            let v24 = 1 << (v23 as u8);
            if (v21 >= *0x1::vector::borrow<u64>(&v19, v23) && v20.passed & v24 == 0) {
                v20.passed = v20.passed | v24;
                let v25 = Chest{
                    season    : v4,
                    grave     : arg2,
                    milestone : ((v23 + 1) as u8),
                };
                0x1::vector::push_back<Chest>(&mut v22, v25);
                let v26 = ChestEarned{
                    season    : v4,
                    grave     : arg2,
                    milestone : ((v23 + 1) as u8),
                    depth     : v21,
                    by        : v0,
                };
                0x2::event::emit<ChestEarned>(v26);
            };
            v23 = v23 + 1;
        };
        if (!0x1::vector::is_empty<Chest>(&v22)) {
            if (!0x2::table::contains<address, vector<Chest>>(&arg0.chests, v0)) {
                0x2::table::add<address, vector<Chest>>(&mut arg0.chests, v0, 0x1::vector::empty<Chest>());
            };
            0x1::vector::append<Chest>(0x2::table::borrow_mut<address, vector<Chest>>(&mut arg0.chests, v0), v22);
        };
        let v27 = 0;
        while (v27 < arg4) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::wear(&mut arg3, v2, v3);
            v27 = v27 + 1;
        };
        let v28 = 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(&arg3);
        let v29 = Dug{
            season     : v4,
            wallet     : v0,
            grave      : arg2,
            shovel     : v28,
            times      : arg4,
            each       : v3,
            bonus_bps  : arg5,
            depth      : v21,
            work       : v12,
            dug        : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg3),
            durability : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::durability(&arg3),
            scrap      : v13,
            paid       : v9.paid,
        };
        0x2::event::emit<Dug>(v29);
        if (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::durability(&arg3) >= v2) {
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(arg3, v0);
            return
        };
        let v30 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::life_of(arg1, &arg3);
        if (!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::repairs(&arg3) + 1 >= 0x1::vector::length<u64>(&v30))) {
            let v31 = ShovelBroken{
                shovel  : v28,
                repairs : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::repairs(&arg3),
            };
            0x2::event::emit<ShovelBroken>(v31);
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(arg3, v0);
            return
        };
        let v32 = arg0.scrap_spent;
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::destroy(arg1, arg3, arg8);
        if (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::reservations_open(arg1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::reserve(arg1, v0, 0x2::clock::timestamp_ms(arg7));
        };
        let v33 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, v0);
        v33.scrap = v33.scrap + v32;
        let v34 = ShovelSpent{
            shovel : v28,
            serial : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::serial(&arg3),
            dug    : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg3),
            scrap  : v32,
            by     : v0,
        };
        0x2::event::emit<ShovelSpent>(v34);
    }

    public fun dig_id(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg0);
        let v1 = DigKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DigKey>(v0, v1)) {
            let v3 = DigKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<DigKey, 0x2::object::ID>(v0, v3))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    entry fun dig_personal(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::object::ID, arg5: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        dig_(arg0, arg1, arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg4, arg5, arg6, arg7, arg8);
    }

    public fun dig_proven(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: Proof, arg3: 0x2::object::ID, arg4: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let Proof {
            wallet : v0,
            graves : v1,
        } = arg2;
        let v2 = v1;
        let v3 = running(arg0, arg6);
        assert!(v0 == 0x2::tx_context::sender(arg7) && 0x1::vector::contains<0x2::object::ID>(&v2, &arg3), 481);
        let v4 = &v2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
            bind(arg0, *0x1::vector::borrow<0x2::object::ID>(v4, v5), v0, v3, arg7);
            v5 = v5 + 1;
        };
        let v6 = bonus_for(arg0, 0x1::vector::length<0x2::object::ID>(&v2));
        dig_core(arg0, arg1, arg3, arg4, arg5, v6, v3, arg6, arg7);
    }

    public fun dig_rules(arg0: &Dig) : (vector<u64>, u64, u64, u64, u64) {
        (arg0.milestones, arg0.chance_first, arg0.chance_step, arg0.scrap_per_dig, arg0.scrap_spent)
    }

    entry fun enroll(arg0: &mut Dig, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        enroll_(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun enroll_(arg0: &mut Dig, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = running(arg0, arg4);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::prove(arg1, arg2, arg3, false);
        let v1 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<address, Ledger>(&arg0.wallets, v1)) {
            0x2::table::add<address, Ledger>(&mut arg0.wallets, v1, blank());
        };
        let v2 = arg0.season;
        let v3 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, v1);
        assert!(v3.season != v2, 465);
        v3.season = v2;
        v3.day = v0;
        v3.pending = min(arg0.per_day, room(arg0.bank, 0, v3.paid));
        v3.today_day = v0;
        v3.today = 0;
        v3.work = 0;
        v3.chances = 0;
        let v4 = Enrolled{
            season  : v2,
            wallet  : v1,
            grave   : arg3,
            pending : v3.pending,
            paid    : v3.paid,
        };
        0x2::event::emit<Enrolled>(v4);
    }

    entry fun enroll_personal(arg0: &mut Dig, arg1: &0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        enroll_(arg0, arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3, arg4, arg5);
    }

    public(friend) fun finish_state(arg0: &Dig, arg1: address) : (u64, u64, u64) {
        if (!0x2::table::contains<address, Ledger>(&arg0.wallets, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Ledger>(&arg0.wallets, arg1);
        (v0.season, v0.work, v0.finished)
    }

    public fun grave_wallets(arg0: &Dig, arg1: 0x2::object::ID) : vector<address> {
        let v0 = SeasonBindKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SeasonBindKey>(&arg0.id, v0)) {
            return vector[]
        };
        let v1 = SeasonBindKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<SeasonBindKey, 0x2::table::Table<HoleKey, vector<address>>>(&arg0.id, v1);
        let v3 = HoleKey{
            season : arg0.season,
            grave  : arg1,
        };
        if (0x2::table::contains<HoleKey, vector<address>>(v2, v3)) {
            *0x2::table::borrow<HoleKey, vector<address>>(v2, v3)
        } else {
            vector[]
        }
    }

    public fun hole(arg0: &Dig, arg1: u64, arg2: 0x2::object::ID) : (u64, u64) {
        let v0 = HoleKey{
            season : arg1,
            grave  : arg2,
        };
        if (!0x2::table::contains<HoleKey, Hole>(&arg0.holes, v0)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<HoleKey, Hole>(&arg0.holes, v0);
        (v1.depth, v1.passed)
    }

    fun issued(arg0: &Ledger, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let v0 = if (arg4 < arg3) {
            arg4
        } else {
            arg3 - 1
        };
        if (v0 <= arg0.day) {
            return (arg0.pending, arg0.day)
        };
        (arg0.pending + min((v0 - arg0.day) * arg1, room(arg2, arg0.pending, arg0.paid)), v0)
    }

    public(friend) fun ledger_mut(arg0: &mut Dig, arg1: address, arg2: u64) : &mut Ledger {
        assert!(0x2::table::contains<address, Ledger>(&arg0.wallets, arg1), 466);
        let v0 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, arg1);
        assert!(v0.season == arg0.season, 466);
        let (v1, v2) = issued(v0, arg0.per_day, arg0.bank, arg0.end_day, arg2);
        v0.pending = v1;
        v0.day = v2;
        if (v0.today_day != arg2) {
            v0.today_day = arg2;
            v0.today = 0;
        };
        v0
    }

    public(friend) fun mark_finished(arg0: &mut Dig, arg1: address, arg2: u64) {
        0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, arg1).finished = arg2;
    }

    entry fun migrate(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == arg1.shed, 461);
        assert!(arg1.version < 2, 460);
        arg1.version = 2;
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::move_book(&mut arg1.id);
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    entry fun new_season(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        check_admin(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 86400000;
        let v1 = if (arg3 >= 1) {
            if (arg3 <= 45) {
                if (arg2 >= v0) {
                    arg2 <= v0 + 90
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 470);
        assert!(arg1.season == 0 || v0 >= arg1.end_day, 471);
        arg1.season = arg1.season + 1;
        arg1.start_day = arg2;
        arg1.end_day = arg2 + arg3;
        let v2 = SeasonSet{
            dig       : 0x2::object::id<Dig>(arg1),
            season    : arg1.season,
            start_day : arg2,
            end_day   : arg1.end_day,
        };
        0x2::event::emit<SeasonSet>(v2);
    }

    entry fun open_dig(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1), 461);
        let v0 = DigKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<DigKey>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid(arg1), v0), 462);
        let v1 = Dig{
            id            : 0x2::object::new(arg3),
            version       : 2,
            shed          : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1),
            open          : false,
            season        : 0,
            start_day     : 0,
            end_day       : 0,
            per_day       : 4,
            bank          : 12,
            daily_max     : 8,
            pack          : 4,
            pack_price    : 100000000,
            payee         : arg2,
            milestones    : vector[6600, 16600, 26600, 36600, 46600, 56600, 66600],
            chance_first  : 16600,
            chance_step   : 10000,
            scrap_per_dig : 1,
            scrap_spent   : 2,
            wallets       : 0x2::table::new<address, Ledger>(arg3),
            holes         : 0x2::table::new<HoleKey, Hole>(arg3),
            chests        : 0x2::table::new<address, vector<Chest>>(arg3),
        };
        let v2 = DigKey{dummy_field: false};
        0x2::dynamic_field::add<DigKey, 0x2::object::ID>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid_mut(arg1), v2, 0x2::object::id<Dig>(&v1));
        let v3 = DigOpened{
            dig  : 0x2::object::id<Dig>(&v1),
            shed : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1),
        };
        0x2::event::emit<DigOpened>(v3);
        configured(&v1);
        0x2::transfer::share_object<Dig>(v1);
    }

    public fun prove_graves(arg0: &mut Proof, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.wallet == 0x2::tx_context::sender(arg4), 481);
        0x1::vector::reverse<0x2::object::ID>(&mut arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg3);
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::prove(arg1, arg2, v1, false);
            if (!0x1::vector::contains<0x2::object::ID>(&arg0.graves, &v1)) {
                0x1::vector::push_back<0x2::object::ID>(&mut arg0.graves, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg3);
    }

    public fun prove_start(arg0: &0x2::tx_context::TxContext) : Proof {
        Proof{
            wallet : 0x2::tx_context::sender(arg0),
            graves : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    entry fun put_scrap(arg0: &mut Dig, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, Ledger>(&arg0.wallets, v0)) {
            0x2::table::add<address, Ledger>(&mut arg0.wallets, v0, blank());
        };
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::burn(arg1);
        let v2 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, v0);
        v2.scrap = v2.scrap + v1;
        let v3 = ScrapMoved{
            wallet : v0,
            units  : v1,
            out    : false,
            held   : v2.scrap,
        };
        0x2::event::emit<ScrapMoved>(v3);
    }

    fun room(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 + arg2 >= arg0) {
            0
        } else {
            arg0 - arg1 - arg2
        }
    }

    fun running(arg0: &Dig, arg1: &0x2::clock::Clock) : u64 {
        check_version(arg0);
        assert!(arg0.open, 463);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        let v1 = if (arg0.season > 0) {
            if (v0 >= arg0.start_day) {
                v0 < arg0.end_day
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 464);
        v0
    }

    public(friend) fun season_now(arg0: &Dig) : u64 {
        arg0.season
    }

    entry fun set_bands(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig, arg2: vector<u64>, arg3: vector<u64>) {
        check_admin(arg0, arg1);
        let v0 = 0x1::vector::length<u64>(&arg2);
        let v1 = if (v0 >= 1) {
            if (v0 == 0x1::vector::length<u64>(&arg3)) {
                v0 <= 10
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 482);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg3, v3) >= 10000 && *0x1::vector::borrow<u64>(&arg3, v3) <= 12000, 482);
            if (v3 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg2, v3) > *0x1::vector::borrow<u64>(&arg2, v3 - 1) && *0x1::vector::borrow<u64>(&arg3, v3) >= *0x1::vector::borrow<u64>(&arg3, v3 - 1), 482);
            };
            let v4 = 0x1::vector::empty<u64>();
            let v5 = &mut v4;
            0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&arg2, v3));
            0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&arg3, v3));
            0x1::vector::push_back<vector<u64>>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v6 = BandsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<BandsKey>(&arg1.id, v6)) {
            let v7 = BandsKey{dummy_field: false};
            0x2::dynamic_field::remove<BandsKey, vector<vector<u64>>>(&mut arg1.id, v7);
        };
        let v8 = BandsKey{dummy_field: false};
        0x2::dynamic_field::add<BandsKey, vector<vector<u64>>>(&mut arg1.id, v8, v2);
    }

    entry fun set_credits(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig, arg2: u64, arg3: u64, arg4: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 >= 1 && arg2 <= 12, 472);
        assert!(arg3 >= arg1.pack && arg3 <= 48, 472);
        assert!(arg4 >= 1 && arg4 <= 24, 472);
        arg1.per_day = arg2;
        arg1.bank = arg3;
        arg1.daily_max = arg4;
        configured(arg1);
    }

    entry fun set_milestones(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        check_admin(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg7) / 86400000;
        let v1 = if (arg1.season == 0) {
            true
        } else if (v0 >= arg1.end_day) {
            true
        } else {
            v0 < arg1.start_day
        };
        assert!(v1, 471);
        let v2 = 0x1::vector::length<u64>(&arg2);
        let v3 = if (v2 >= 1) {
            if (v2 <= 64) {
                *0x1::vector::borrow<u64>(&arg2, 0) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 479);
        let v4 = 1;
        while (v4 < v2) {
            assert!(*0x1::vector::borrow<u64>(&arg2, v4) > *0x1::vector::borrow<u64>(&arg2, v4 - 1), 479);
            v4 = v4 + 1;
        };
        assert!(arg3 > 0 && arg4 > 0, 479);
        assert!(arg5 <= 10 && arg6 <= 10, 479);
        arg1.milestones = arg2;
        arg1.chance_first = arg3;
        arg1.chance_step = arg4;
        arg1.scrap_per_dig = arg5;
        arg1.scrap_spent = arg6;
        let v5 = MilestonesSet{
            dig           : 0x2::object::id<Dig>(arg1),
            milestones    : arg2,
            chance_first  : arg3,
            chance_step   : arg4,
            scrap_per_dig : arg5,
            scrap_spent   : arg6,
        };
        0x2::event::emit<MilestonesSet>(v5);
    }

    entry fun set_open(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig, arg2: bool) {
        check_admin(arg0, arg1);
        arg1.open = arg2;
        configured(arg1);
    }

    entry fun set_pack_price(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(arg2 <= 1000000000, 473);
        arg1.pack_price = arg2;
        configured(arg1);
    }

    entry fun set_payee(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut Dig, arg2: address) {
        check_admin(arg0, arg1);
        arg1.payee = arg2;
        configured(arg1);
    }

    public(friend) fun shed_of(arg0: &Dig) : 0x2::object::ID {
        arg0.shed
    }

    public(friend) fun spend_scrap(arg0: &mut Dig, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, Ledger>(&arg0.wallets, arg1), 478);
        let v0 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, arg1);
        assert!(v0.scrap >= arg2, 478);
        v0.scrap = v0.scrap - arg2;
    }

    public(friend) fun take_chances(arg0: &mut Dig, arg1: address, arg2: u64) : u64 {
        check_version(arg0);
        if (!0x2::table::contains<address, Ledger>(&arg0.wallets, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, arg1);
        if (v0.season != arg0.season) {
            return 0
        };
        let v1 = if (v0.chances < arg2) {
            v0.chances
        } else {
            arg2
        };
        v0.chances = v0.chances - v1;
        v1
    }

    public(friend) fun take_chests(arg0: &mut Dig, arg1: address) : vector<Chest> {
        if (!0x2::table::contains<address, vector<Chest>>(&arg0.chests, arg1)) {
            return 0x1::vector::empty<Chest>()
        };
        0x2::table::remove<address, vector<Chest>>(&mut arg0.chests, arg1)
    }

    entry fun take_scrap(arg0: &mut Dig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 >= 1 && 0x2::table::contains<address, Ledger>(&arg0.wallets, v0), 478);
        let v1 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, v0);
        assert!(v1.scrap >= arg1, 478);
        v1.scrap = v1.scrap - arg1;
        let v2 = ScrapMoved{
            wallet : v0,
            units  : arg1,
            out    : true,
            held   : v1.scrap,
        };
        0x2::event::emit<ScrapMoved>(v2);
        0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::mint(arg1, arg2), v0);
    }

    public fun terms(arg0: &Dig) : (bool, u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.open, arg0.season, arg0.start_day, arg0.end_day, arg0.per_day, arg0.bank, arg0.daily_max, arg0.pack, arg0.pack_price)
    }

    public(friend) fun uid(arg0: &Dig) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Dig) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

