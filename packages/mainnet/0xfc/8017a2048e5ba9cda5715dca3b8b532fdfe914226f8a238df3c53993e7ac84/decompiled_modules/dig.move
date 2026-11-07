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

    entry fun dig(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        dig_(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public(friend) fun add_scrap(arg0: &mut Dig, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, Ledger>(&arg0.wallets, arg1)) {
            0x2::table::add<address, Ledger>(&mut arg0.wallets, arg1, blank());
        };
        let v0 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, arg1);
        v0.scrap = v0.scrap + arg2;
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
        assert!(arg0.version == 1, 460);
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

    fun dig_(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = running(arg0, arg7);
        assert!(0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1) == arg0.shed, 461);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::prove(arg2, arg3, arg4, false);
        assert!(arg6 >= 1, 474);
        let v1 = 0x2::tx_context::sender(arg8);
        let (v2, v3) = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dig_terms(arg1, &arg5);
        let v4 = v2 * 10000 / 10000;
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::durability(&arg5) >= arg6 * v3, 477);
        let v5 = arg0.season;
        let v6 = arg0.daily_max;
        let v7 = arg0.scrap_per_dig;
        let v8 = arg0.chance_first;
        let v9 = arg0.chance_step;
        let v10 = ledger_mut(arg0, v1, v0);
        assert!(v10.paid >= arg6, 475);
        assert!(v10.today + arg6 <= v6, 476);
        v10.paid = v10.paid - arg6;
        v10.today = v10.today + arg6;
        v10.digs = v10.digs + arg6;
        v10.work = v10.work + arg6 * v4;
        v10.scrap = v10.scrap + arg6 * v7;
        let v11 = chances_in(v10.work, v8, v9) - chances_in(v10.work, v8, v9);
        v10.chances = v10.chances + v11;
        let v12 = v10.work;
        let v13 = v10.scrap;
        if (v11 > 0) {
            let v14 = ChanceEarned{
                season  : v5,
                wallet  : v1,
                work    : v12,
                chances : v11,
            };
            0x2::event::emit<ChanceEarned>(v14);
        };
        let v15 = HoleKey{
            season : v5,
            grave  : arg4,
        };
        if (!0x2::table::contains<HoleKey, Hole>(&arg0.holes, v15)) {
            let v16 = Hole{
                depth  : 0,
                passed : 0,
            };
            0x2::table::add<HoleKey, Hole>(&mut arg0.holes, v15, v16);
        };
        let v17 = arg0.milestones;
        let v18 = 0x2::table::borrow_mut<HoleKey, Hole>(&mut arg0.holes, v15);
        v18.depth = v18.depth + arg6 * v4;
        let v19 = v18.depth;
        let v20 = 0x1::vector::empty<Chest>();
        let v21 = 0;
        while (v21 < 0x1::vector::length<u64>(&v17)) {
            let v22 = 1 << (v21 as u8);
            if (v19 >= *0x1::vector::borrow<u64>(&v17, v21) && v18.passed & v22 == 0) {
                v18.passed = v18.passed | v22;
                let v23 = Chest{
                    season    : v5,
                    grave     : arg4,
                    milestone : ((v21 + 1) as u8),
                };
                0x1::vector::push_back<Chest>(&mut v20, v23);
                let v24 = ChestEarned{
                    season    : v5,
                    grave     : arg4,
                    milestone : ((v21 + 1) as u8),
                    depth     : v19,
                    by        : v1,
                };
                0x2::event::emit<ChestEarned>(v24);
            };
            v21 = v21 + 1;
        };
        if (!0x1::vector::is_empty<Chest>(&v20)) {
            if (!0x2::table::contains<address, vector<Chest>>(&arg0.chests, v1)) {
                0x2::table::add<address, vector<Chest>>(&mut arg0.chests, v1, 0x1::vector::empty<Chest>());
            };
            0x1::vector::append<Chest>(0x2::table::borrow_mut<address, vector<Chest>>(&mut arg0.chests, v1), v20);
        };
        let v25 = 0;
        while (v25 < arg6) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::wear(&mut arg5, v3, v4);
            v25 = v25 + 1;
        };
        let v26 = 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(&arg5);
        let v27 = Dug{
            season     : v5,
            wallet     : v1,
            grave      : arg4,
            shovel     : v26,
            times      : arg6,
            each       : v4,
            bonus_bps  : 10000,
            depth      : v19,
            work       : v12,
            dug        : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg5),
            durability : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::durability(&arg5),
            scrap      : v13,
            paid       : v10.paid,
        };
        0x2::event::emit<Dug>(v27);
        if (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::durability(&arg5) >= v3) {
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(arg5, v1);
            return
        };
        let v28 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::life_of(arg1, &arg5);
        if (!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::repairs(&arg5) + 1 >= 0x1::vector::length<u64>(&v28))) {
            let v29 = ShovelBroken{
                shovel  : v26,
                repairs : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::repairs(&arg5),
            };
            0x2::event::emit<ShovelBroken>(v29);
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel>(arg5, v1);
            return
        };
        let v30 = arg0.scrap_spent;
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::destroy(arg1, arg5, arg8);
        if (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::reservations_open(arg1)) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::reserve(arg1, v1, 0x2::clock::timestamp_ms(arg7));
        };
        let v31 = 0x2::table::borrow_mut<address, Ledger>(&mut arg0.wallets, v1);
        v31.scrap = v31.scrap + v30;
        let v32 = ShovelSpent{
            shovel : v26,
            serial : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::serial(&arg5),
            dug    : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::dug(&arg5),
            scrap  : v30,
            by     : v1,
        };
        0x2::event::emit<ShovelSpent>(v32);
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

    entry fun dig_personal(arg0: &mut Dig, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::object::ID, arg5: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shovel, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        dig_(arg0, arg1, arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg4, arg5, arg6, arg7, arg8);
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
                arg2 >= v0
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
            version       : 1,
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

    // decompiled from Move bytecode v7
}

