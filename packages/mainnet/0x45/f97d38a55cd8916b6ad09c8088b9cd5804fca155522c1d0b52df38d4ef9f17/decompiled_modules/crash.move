module 0x45f97d38a55cd8916b6ad09c8088b9cd5804fca155522c1d0b52df38d4ef9f17::crash {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Deposit has store, key {
        id: 0x2::object::UID,
        depositor: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        multiplier_e9: u64,
        bet_amount: u64,
    }

    struct Round has store, key {
        id: 0x2::object::UID,
        key: u64,
        status: u8,
        deposits: vector<Deposit>,
        total_bet_amount: u64,
        max_total_bet_amount: u64,
        draw_number: 0x1::option::Option<u64>,
        drawer: 0x1::option::Option<address>,
        drawable_time: u64,
        draw_time: u64,
        participant_amount: 0x2::table::Table<address, u64>,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        rounds: 0x2::object_table::ObjectTable<u64, Round>,
        round_duration: u64,
        current_round_key: u64,
        max_deposits_per_round: u64,
        min_multiplier_e9: u64,
        max_multiplier_e9: u64,
        multiplier_decimals: u8,
        max_round_balance_lp_bp: u16,
    }

    struct Deposited has copy, drop {
        round_key: u64,
        bet_amount: u64,
        multiplier_e9: u64,
        depositor: address,
    }

    struct Drawn has copy, drop {
        round_key: u64,
        round_address: address,
        draw_number: u64,
        winner_count: u64,
        total_bet_amount: u64,
        win_amount: u64,
        payout_amount: u64,
    }

    struct RoundCreated has copy, drop {
        round_key: u64,
        round_address: address,
    }

    struct RoundOpened has copy, drop {
        round_key: u64,
        round_address: address,
    }

    fun check_round_status(arg0: &Game, arg1: u64, arg2: u8) {
        assert!(0x2::object_table::borrow<u64, Round>(&arg0.rounds, arg1).status == arg2, 13906835651812524039);
    }

    fun create_new_round_if_not_exists(arg0: &mut Game, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::object_table::contains<u64, Round>(&arg0.rounds, arg1)) {
            return
        };
        let v0 = Round{
            id                   : 0x2::object::new(arg3),
            key                  : arg1,
            status               : 0,
            deposits             : 0x1::vector::empty<Deposit>(),
            total_bet_amount     : 0,
            max_total_bet_amount : arg2,
            draw_number          : 0x1::option::none<u64>(),
            drawer               : 0x1::option::none<address>(),
            drawable_time        : 0,
            draw_time            : 0,
            participant_amount   : 0x2::table::new<address, u64>(arg3),
        };
        0x2::object_table::add<u64, Round>(&mut arg0.rounds, arg1, v0);
        let v1 = 0x2::object_table::value_id<u64, Round>(&arg0.rounds, arg1);
        let v2 = RoundCreated{
            round_key     : arg1,
            round_address : 0x2::object::id_to_address(0x1::option::borrow<0x2::object::ID>(&v1)),
        };
        0x2::event::emit<RoundCreated>(v2);
    }

    entry fun deposit<T0>(arg0: &mut Game, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg5: &0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, 0x2::sui::SUI>, arg6: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg7: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg7, 1);
        assert!(arg2 >= arg0.min_multiplier_e9 && arg2 <= arg0.max_multiplier_e9, 13906834732690571287);
        assert!(arg2 % 1000000000 / 0x1::u64::pow(10, arg0.multiplier_decimals) == 0, 13906834736985538583);
        assert!(arg1 == arg0.current_round_key, 13906834749870309397);
        check_round_status(arg0, arg1, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 13906834771344490507);
        0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::check_bet_amount<T0, 0x2::sui::SUI, Witness>(arg4, arg5, get_kelly_fraction_e9(arg2, 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::liquidity_fee_bp(0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::borrow_game_config<Witness>(arg4))), v0, arg9);
        update_drawable_time_if_needed(arg0, arg1, arg8);
        let v1 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1);
        assert!(0x1::vector::length<Deposit>(&v1.deposits) < arg0.max_deposits_per_round, 13906834818589261837);
        assert!(!0x2::table::contains<address, u64>(&v1.participant_amount, 0x2::tx_context::sender(arg9)), 13906834822885015577);
        assert!(v1.max_total_bet_amount >= v1.total_bet_amount + v0, 13906834835769393169);
        let v2 = Deposit{
            id            : 0x2::object::new(arg9),
            depositor     : 0x2::tx_context::sender(arg9),
            balance       : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            multiplier_e9 : arg2,
            bet_amount    : v0,
        };
        0x1::vector::push_back<Deposit>(&mut v1.deposits, v2);
        v1.total_bet_amount = v1.total_bet_amount + v0;
        0x2::table::add<address, u64>(&mut v1.participant_amount, 0x2::tx_context::sender(arg9), v0);
        let v3 = Deposited{
            round_key     : arg1,
            bet_amount    : v0,
            multiplier_e9 : arg2,
            depositor     : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<Deposited>(v3);
        let v4 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play<Witness>(arg6, v0, 0x2::tx_context::sender(arg9), &v4, arg8, arg9);
    }

    entry fun draw<T0>(arg0: &mut Game, arg1: u64, arg2: &0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::GameManager, arg3: &mut 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, 0x2::sui::SUI>, arg4: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg5: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg6: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg6, 1);
        assert!(arg1 == arg0.current_round_key, 13906835020453249045);
        check_round_status(arg0, arg1, 1);
        let v0 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1);
        assert!(0x1::vector::length<Deposit>(&v0.deposits) > 0 && 0x2::table::length<address, u64>(&v0.participant_amount) > 0, 13906835037632725007);
        assert!(v0.drawable_time > 0 && v0.drawable_time < 0x2::clock::timestamp_ms(arg8), 13906835041927299081);
        assert!(0x2::table::contains<address, u64>(&v0.participant_amount, 0x2::tx_context::sender(arg9)), 13906835046222921747);
        let v1 = 0x2::random::new_generator(arg7, arg9);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 1, 1000000000);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v3 < 0x1::vector::length<Deposit>(&v0.deposits)) {
            let v7 = 0x1::vector::borrow_mut<Deposit>(&mut v0.deposits, v3);
            let v8 = v7.multiplier_e9;
            let v9 = 0x2::balance::value<0x2::sui::SUI>(&v7.balance);
            let v10 = if (get_win_probability_e9(v8) >= v2) {
                (((v9 as u256) * (v8 as u256) / (1000000000 as u256)) as u64)
            } else {
                0
            };
            let v11 = Witness{dummy_field: false};
            let v12 = 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager::handle_payout_with_referral<T0, Witness>(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v7.balance, v9), arg9), v10, v7.depositor, v11, arg5, arg6, arg9);
            if (v12 > 0) {
                v5 = v5 + v10;
                v6 = v6 + v12;
                v4 = v4 + 1;
                let v13 = Witness{dummy_field: false};
                0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::record_play_activity<Witness>(arg4, false, 0, v10, v12, v7.depositor, &v13);
            };
            let v14 = Witness{dummy_field: false};
            0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::emit_play_history<Witness>(arg4, 0x1::u64::to_string(arg1), 0x2::address::to_string(v7.depositor), v9, v10, v12, &v14);
            v3 = v3 + 1;
        };
        let v15 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::increment_point<Witness>(arg4, *0x2::table::borrow<address, u64>(&v0.participant_amount, 0x2::tx_context::sender(arg9)), 0x2::tx_context::sender(arg9), 0x1::type_name::get<0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::point::Witness>(), b"MysteryPoint", &v15, arg8, arg9);
        v0.draw_number = 0x1::option::some<u64>(v2);
        v0.drawer = 0x1::option::some<address>(0x2::tx_context::sender(arg9));
        v0.draw_time = 0x2::clock::timestamp_ms(arg8);
        v0.status = 2;
        let v16 = Drawn{
            round_key        : arg1,
            round_address    : get_round_address(arg0, arg1),
            draw_number      : v2,
            winner_count     : v4,
            total_bet_amount : v0.total_bet_amount,
            win_amount       : v5,
            payout_amount    : v6,
        };
        0x2::event::emit<Drawn>(v16);
        let v17 = get_max_balance_amount<T0>(arg0, arg3);
        start_new_round(arg0, v17, arg9);
    }

    fun get_kelly_fraction_e9(arg0: u64, arg1: u64) : u64 {
        let v0 = get_win_probability_e9(arg0);
        (1000000000 - v0) * 1000000000 / (arg0 * (10000 - arg1) / 10000 - 1000000000) - v0
    }

    fun get_max_balance_amount<T0>(arg0: &Game, arg1: &0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, 0x2::sui::SUI>) : u64 {
        (arg0.max_round_balance_lp_bp as u64) * 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::get_total_assets<T0, 0x2::sui::SUI>(arg1) / 10000
    }

    fun get_round_address(arg0: &Game, arg1: u64) : address {
        let v0 = 0x2::object_table::value_id<u64, Round>(&arg0.rounds, arg1);
        0x2::object::id_to_address(0x1::option::borrow<0x2::object::ID>(&v0))
    }

    fun get_win_probability_e9(arg0: u64) : u64 {
        1000000000 * 1000000000 / arg0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Game{
            id                      : 0x2::object::new(arg0),
            rounds                  : 0x2::object_table::new<u64, Round>(arg0),
            round_duration          : 60000,
            current_round_key       : 0,
            max_deposits_per_round  : 100,
            min_multiplier_e9       : 105 * 1000000000 / 100,
            max_multiplier_e9       : 100 * 1000000000,
            multiplier_decimals     : 2,
            max_round_balance_lp_bp : 100,
        };
        let v2 = &mut v1;
        start_new_round(v2, 10000000000, arg0);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Game>(v1);
    }

    fun start_new_round(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.current_round_key = arg0.current_round_key + 1;
        let v0 = arg0.current_round_key;
        create_new_round_if_not_exists(arg0, v0, arg1, arg2);
        0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, v0).status = 1;
        let v1 = RoundOpened{
            round_key     : v0,
            round_address : get_round_address(arg0, v0),
        };
        0x2::event::emit<RoundOpened>(v1);
    }

    fun update_drawable_time_if_needed(arg0: &mut Game, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object_table::borrow_mut<u64, Round>(&mut arg0.rounds, arg1);
        if (v0.drawable_time == 0) {
            v0.drawable_time = 0x2::clock::timestamp_ms(arg2) + arg0.round_duration;
        };
    }

    entry fun update_game(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) {
        arg1.round_duration = arg2;
        arg1.max_deposits_per_round = arg3;
        arg1.min_multiplier_e9 = arg4;
        arg1.max_multiplier_e9 = arg5;
        arg1.multiplier_decimals = arg6;
        arg1.max_round_balance_lp_bp = arg7;
    }

    // decompiled from Move bytecode v6
}

