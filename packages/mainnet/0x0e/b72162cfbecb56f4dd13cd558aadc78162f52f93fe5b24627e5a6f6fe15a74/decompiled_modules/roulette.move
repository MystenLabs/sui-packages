module 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::roulette {
    struct Roulette has copy, drop, store {
        dummy_field: bool,
    }

    struct BetAddedEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bet_size: u64,
        bet_type: u8,
        player: address,
        creator: address,
        origin: 0x1::string::String,
    }

    struct BetRemovedEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bet_size: u64,
        player: address,
        creator: address,
        origin: 0x1::string::String,
    }

    struct TableRollEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        round_number: u64,
        outcome: u64,
        creator: address,
    }

    struct ReferralPayoutEvent<phantom T0> has copy, drop, store {
        payout: u64,
        creator: address,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
    }

    struct RouletteTable<phantom T0> has store, key {
        id: 0x2::object::UID,
        host: address,
        risk_manager: 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::risk_manager::RiskManager,
        balance: 0x2::balance::Balance<T0>,
        current_bets: 0x2::linked_table::LinkedTable<address, vector<Bet>>,
        status: u8,
        rounds_settled: 0x2::table::Table<u64, u64>,
        round_number: u64,
    }

    struct GameTag<phantom T0> has copy, drop, store {
        creator: address,
    }

    struct RouletteConfig has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        bet_referral_rate: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlayerWin<phantom T0> {
        player: address,
        bet_balance: 0x2::balance::Balance<T0>,
        bet_payout: u64,
    }

    public fun add_bet<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut RouletteConfig, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: 0x1::option::Option<u64>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 3);
        assert!(arg4 <= 121, 1);
        if (arg4 == 2) {
            assert!(0x1::option::is_some<u64>(&arg5), 2);
            assert!(*0x1::option::borrow<u64>(&arg5) < 38, 2);
        };
        let v0 = borrow_table_mut<T0>(arg1, arg2);
        assert!(v0.status == 0, 0);
        assert!(0x2::linked_table::length<address, vector<Bet>>(&v0.current_bets) < 1000, 9);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let (_, _) = 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::risk_manager::add_risk(&mut v0.risk_manager, arg4, arg5, 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::bet_manager::get_bet_payout(v1, arg4));
        let v4 = Roulette{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Roulette>(arg0, v4, 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::risk_manager::total_risk(&v0.risk_manager), arg7);
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(arg3));
        let v5 = 0x2::tx_context::sender(arg7);
        let v6 = Bet{
            id         : 0x2::object::new(arg7),
            bet_type   : arg4,
            bet_number : arg5,
            bet_size   : v1,
            player     : v5,
        };
        let v7 = 0x2::object::id<Bet>(&v6);
        let v8 = &mut v0.current_bets;
        handle_add_bet(v8, v5, v6);
        let v9 = BetAddedEvent<T0>{
            table_id : 0x2::object::id<RouletteTable<T0>>(v0),
            bet_id   : v7,
            bet_size : v1,
            bet_type : arg4,
            player   : v5,
            creator  : arg2,
            origin   : arg6,
        };
        0x2::event::emit<BetAddedEvent<T0>>(v9);
        v7
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut RouletteConfig, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_table_has_bets<T0>(arg0: &RouletteTable<T0>) : bool {
        0x2::linked_table::length<address, vector<Bet>>(&arg0.current_bets) > 0
    }

    fun assert_valid_version(arg0: &RouletteConfig) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 7);
    }

    public fun assert_within_risk<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = Roulette{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Roulette>(arg0, v0, arg1, arg2);
    }

    public fun borrow_table<T0>(arg0: &RouletteConfig, arg1: address) : &RouletteTable<T0> {
        let v0 = GameTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow<GameTag<T0>, RouletteTable<T0>>(&arg0.id, v0)
    }

    fun borrow_table_mut<T0>(arg0: &mut RouletteConfig, arg1: address) : &mut RouletteTable<T0> {
        let v0 = GameTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow_mut<GameTag<T0>, RouletteTable<T0>>(&mut arg0.id, v0)
    }

    public fun create_roulette_table<T0>(arg0: &mut RouletteConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!table_exists<T0>(arg0, v0), 12);
        let v1 = RouletteTable<T0>{
            id             : 0x2::object::new(arg1),
            host           : 0x2::tx_context::sender(arg1),
            risk_manager   : 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::risk_manager::new_manager(),
            balance        : 0x2::balance::zero<T0>(),
            current_bets   : 0x2::linked_table::new<address, vector<Bet>>(arg1),
            status         : 0,
            rounds_settled : 0x2::table::new<u64, u64>(arg1),
            round_number   : 0,
        };
        let v2 = GameTag<T0>{creator: v0};
        0x2::dynamic_object_field::add<GameTag<T0>, RouletteTable<T0>>(&mut arg0.id, v2, v1);
        0x2::object::id<RouletteTable<T0>>(&v1)
    }

    fun destroy_bet(arg0: Bet) : u64 {
        let Bet {
            id         : v0,
            bet_type   : _,
            bet_number : _,
            bet_size   : v3,
            player     : _,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    public fun get_roll_for_round<T0>(arg0: &RouletteConfig, arg1: address) : u64 {
        let v0 = GameTag<T0>{creator: arg1};
        let v1 = 0x2::dynamic_object_field::borrow<GameTag<T0>, RouletteTable<T0>>(&arg0.id, v0);
        *0x2::table::borrow<u64, u64>(&v1.rounds_settled, v1.round_number)
    }

    fun handle_add_bet(arg0: &mut 0x2::linked_table::LinkedTable<address, vector<Bet>>, arg1: address, arg2: Bet) {
        if (0x2::linked_table::contains<address, vector<Bet>>(arg0, arg1)) {
            let v0 = 0x2::linked_table::remove<address, vector<Bet>>(arg0, arg1);
            assert!(0x1::vector::length<Bet>(&v0) < 500, 11);
            0x1::vector::push_back<Bet>(&mut v0, arg2);
            0x2::linked_table::push_back<address, vector<Bet>>(arg0, arg1, v0);
        } else {
            let v1 = 0x1::vector::empty<Bet>();
            0x1::vector::push_back<Bet>(&mut v1, arg2);
            0x2::linked_table::push_back<address, vector<Bet>>(arg0, arg1, v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RouletteConfig{
            id                : 0x2::object::new(arg0),
            version_set       : 0x2::vec_set::singleton<u64>(1),
            bet_referral_rate : 10000,
        };
        0x2::transfer::share_object<RouletteConfig>(v1);
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_bet<T0>(arg0: &mut RouletteConfig, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        assert!(table_exists<T0>(arg0, arg1), 3);
        let v0 = borrow_table_mut<T0>(arg0, arg1);
        assert!(v0.status == 0, 0);
        assert!(0x2::linked_table::contains<address, vector<Bet>>(&v0.current_bets, arg2), 5);
        let v1 = 0x2::linked_table::remove<address, vector<Bet>>(&mut v0.current_bets, arg2);
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v2 < 0x1::vector::length<Bet>(&v1)) {
            if (0x2::object::id<Bet>(0x1::vector::borrow<Bet>(&v1, v2)) == arg3) {
                v3 = true;
                v4 = destroy_bet(0x1::vector::remove<Bet>(&mut v1, v2));
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 6);
        if (0x1::vector::length<Bet>(&v1) > 0) {
            0x2::linked_table::push_back<address, vector<Bet>>(&mut v0.current_bets, arg2, v1);
        } else {
            0x1::vector::destroy_empty<Bet>(v1);
        };
        let v5 = BetRemovedEvent<T0>{
            table_id : 0x2::object::id<RouletteTable<T0>>(v0),
            bet_id   : arg3,
            bet_size : v4,
            player   : arg2,
            creator  : arg1,
            origin   : arg4,
        };
        0x2::event::emit<BetRemovedEvent<T0>>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v4), arg5)
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut RouletteConfig, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun set_referral_rate(arg0: &AdminCap, arg1: &mut RouletteConfig, arg2: u64) {
        assert!(arg2 < 10000 * 2, 13);
        arg1.bet_referral_rate = arg2;
    }

    public fun settle_or_continue<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut RouletteConfig, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 3);
        let v0 = arg1.bet_referral_rate;
        let v1 = borrow_table_mut<T0>(arg1, arg2);
        assert!(0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) != 0, 4);
        let v2 = 0x2::table::borrow<u64, u64>(&v1.rounds_settled, v1.round_number);
        let v3 = 0x1::vector::empty<PlayerWin<T0>>();
        let v4 = 0;
        let v5 = 0x2::balance::zero<T0>();
        let v6 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Roulette>>();
        let v7 = 0;
        let v8 = 10000;
        if (0x1::option::is_some<u64>(&arg3)) {
            v8 = *0x1::option::borrow<u64>(&arg3);
        };
        let v9 = 0;
        let v10 = false;
        while (v9 < v8 && 0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) > 0) {
            let (v11, v12) = 0x2::linked_table::pop_back<address, vector<Bet>>(&mut v1.current_bets);
            let v13 = v12;
            if (v11 != arg2) {
                v10 = true;
            };
            while (v9 < v8 && 0x1::vector::length<Bet>(&v13) != 0) {
                let v14 = 0x1::vector::pop_back<Bet>(&mut v13);
                let Bet {
                    id         : v15,
                    bet_type   : v16,
                    bet_number : v17,
                    bet_size   : v18,
                    player     : v19,
                } = v14;
                let v20 = 0x2::balance::split<T0>(&mut v1.balance, v18);
                if (v19 != arg2) {
                    v7 = v7 + 0x2::balance::value<T0>(&v20);
                };
                let v21 = 0;
                let v22 = v21;
                if (0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::bet_manager::won_bet(v16, *v2, v17)) {
                    let v23 = 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::bet_manager::get_bet_payout(v18, v16);
                    v4 = v4 + v23;
                    let v24 = PlayerWin<T0>{
                        player      : v19,
                        bet_balance : v20,
                        bet_payout  : v23,
                    };
                    0x1::vector::push_back<PlayerWin<T0>>(&mut v3, v24);
                    v22 = v21 + v23 + v18;
                } else {
                    0x2::balance::join<T0>(&mut v5, v20);
                };
                0x2::object::delete(v15);
                0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Roulette>>(&mut v6, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, Roulette>(0x1::option::some<0x2::object::ID>(0x2::object::id<Bet>(&v14)), v19, (v16 as u64), v17, v18, v22, *v2));
                v9 = v9 + 1;
            };
            if (v9 >= v8 && !0x1::vector::is_empty<Bet>(&v13)) {
                0x2::linked_table::push_back<address, vector<Bet>>(&mut v1.current_bets, v11, v13);
                break
            };
            0x1::vector::destroy_empty<Bet>(v13);
        };
        if (!0x1::vector::is_empty<PlayerWin<T0>>(&v3)) {
            let v25 = Roulette{dummy_field: false};
            let v26 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::split_with_reimbursement<T0, Roulette>(arg0, v25, v4);
            while (!0x1::vector::is_empty<PlayerWin<T0>>(&v3)) {
                let PlayerWin {
                    player      : v27,
                    bet_balance : v28,
                    bet_payout  : v29,
                } = 0x1::vector::pop_back<PlayerWin<T0>>(&mut v3);
                let v30 = 0x2::balance::split<T0>(&mut v26, v29);
                0x2::balance::join<T0>(&mut v30, v28);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v30, arg5), v27);
            };
            0x2::balance::destroy_zero<T0>(v26);
        };
        0x1::vector::destroy_empty<PlayerWin<T0>>(v3);
        if (0x2::balance::value<T0>(&v5) != 0) {
            let v31 = Roulette{dummy_field: false};
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Roulette>(arg0, v31, 0x2::coin::from_balance<T0>(v5, arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Roulette>(arg0, 0x1::option::some<0x2::object::ID>(0x2::object::id<RouletteTable<T0>>(v1)), 0x1::option::some<u64>(v1.round_number), 0x1::option::some<0x1::string::String>(arg4), v6);
        if (v10) {
            let v32 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(v7, v0);
            let v33 = Roulette{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take<T0, Roulette>(arg0, v33, v32, arg5), arg2);
            let v34 = ReferralPayoutEvent<T0>{
                payout  : v32,
                creator : arg2,
            };
            0x2::event::emit<ReferralPayoutEvent<T0>>(v34);
        };
        if (0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) == 0) {
            v1.risk_manager = 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::risk_manager::new_manager();
            v1.status = 0;
            v1.round_number = v1.round_number + 1;
        };
    }

    public fun settle_or_continue_0<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut RouletteConfig, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::string::String, arg5: &0x48add966e0ecbcb701beba1f649ae8b30f09e9ec86af7a24b28b0446db673e90::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        if (!0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::pipe_exists<T0, 0x48add966e0ecbcb701beba1f649ae8b30f09e9ec86af7a24b28b0446db673e90::pond::SUILEND_POND>(arg0)) {
            settle_or_continue<T0>(arg0, arg1, arg2, arg3, arg4, arg10);
            return
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg6, arg9, arg7, arg8);
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 3);
        let v0 = arg1.bet_referral_rate;
        let v1 = borrow_table_mut<T0>(arg1, arg2);
        assert!(0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) != 0, 4);
        let v2 = 0x2::table::borrow<u64, u64>(&v1.rounds_settled, v1.round_number);
        let v3 = Roulette{dummy_field: false};
        let v4 = 0x1::vector::empty<PlayerWin<T0>>();
        let v5 = 0;
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Roulette>>();
        let v8 = 0;
        let v9 = 10000;
        if (0x1::option::is_some<u64>(&arg3)) {
            v9 = *0x1::option::borrow<u64>(&arg3);
        };
        let v10 = 0;
        let v11 = false;
        while (v10 < v9 && 0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) > 0) {
            let (v12, v13) = 0x2::linked_table::pop_back<address, vector<Bet>>(&mut v1.current_bets);
            let v14 = v13;
            if (v12 != arg2) {
                v11 = true;
            };
            while (v10 < v9 && 0x1::vector::length<Bet>(&v14) != 0) {
                let v15 = 0x1::vector::pop_back<Bet>(&mut v14);
                let Bet {
                    id         : v16,
                    bet_type   : v17,
                    bet_number : v18,
                    bet_size   : v19,
                    player     : v20,
                } = v15;
                let v21 = 0x2::balance::split<T0>(&mut v1.balance, v19);
                if (v20 != arg2) {
                    v8 = v8 + 0x2::balance::value<T0>(&v21);
                };
                let v22 = 0;
                let v23 = v22;
                if (0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::bet_manager::won_bet(v17, *v2, v18)) {
                    let v24 = 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::bet_manager::get_bet_payout(v19, v17);
                    v5 = v5 + v24;
                    let v25 = PlayerWin<T0>{
                        player      : v20,
                        bet_balance : v21,
                        bet_payout  : v24,
                    };
                    0x1::vector::push_back<PlayerWin<T0>>(&mut v4, v25);
                    v23 = v22 + v24 + v19;
                } else {
                    0x2::balance::join<T0>(&mut v6, v21);
                };
                0x2::object::delete(v16);
                0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Roulette>>(&mut v7, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, Roulette>(0x1::option::some<0x2::object::ID>(0x2::object::id<Bet>(&v15)), v20, (v17 as u64), v18, v19, v23, *v2));
                v10 = v10 + 1;
            };
            if (v10 >= v9 && !0x1::vector::is_empty<Bet>(&v14)) {
                0x2::linked_table::push_back<address, vector<Bet>>(&mut v1.current_bets, v12, v14);
                break
            };
            0x1::vector::destroy_empty<Bet>(v14);
        };
        if (!0x1::vector::is_empty<PlayerWin<T0>>(&v4)) {
            let (v26, v27) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::pool_changes(v5);
            let v28 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::pool_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T0>(arg0));
            if (v26 > v28) {
                0x48add966e0ecbcb701beba1f649ae8b30f09e9ec86af7a24b28b0446db673e90::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Roulette>(arg5, arg0, v26 - v28, false, v3, arg6, arg7, arg9, arg10);
            };
            let v29 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::house_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T0>(arg0));
            if (v27 > v29) {
                0x48add966e0ecbcb701beba1f649ae8b30f09e9ec86af7a24b28b0446db673e90::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Roulette>(arg5, arg0, v27 - v29, true, v3, arg6, arg7, arg9, arg10);
            };
            let v30 = Roulette{dummy_field: false};
            let v31 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::split_with_reimbursement<T0, Roulette>(arg0, v30, v5);
            while (!0x1::vector::is_empty<PlayerWin<T0>>(&v4)) {
                let PlayerWin {
                    player      : v32,
                    bet_balance : v33,
                    bet_payout  : v34,
                } = 0x1::vector::pop_back<PlayerWin<T0>>(&mut v4);
                let v35 = 0x2::balance::split<T0>(&mut v31, v34);
                0x2::balance::join<T0>(&mut v35, v33);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v35, arg10), v32);
            };
            0x2::balance::destroy_zero<T0>(v31);
        };
        0x1::vector::destroy_empty<PlayerWin<T0>>(v4);
        if (0x2::balance::value<T0>(&v6) != 0) {
            let v36 = 0x2::coin::from_balance<T0>(v6, arg10);
            let (v37, v38) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::pool_changes(0x2::coin::value<T0>(&v36));
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Roulette>(arg0, v3, v36);
            0x48add966e0ecbcb701beba1f649ae8b30f09e9ec86af7a24b28b0446db673e90::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Roulette>(arg5, arg0, v37, false, v3, arg6, arg7, arg9, arg10);
            0x48add966e0ecbcb701beba1f649ae8b30f09e9ec86af7a24b28b0446db673e90::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Roulette>(arg5, arg0, v38, true, v3, arg6, arg7, arg9, arg10);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Roulette>(arg0, 0x1::option::some<0x2::object::ID>(0x2::object::id<RouletteTable<T0>>(v1)), 0x1::option::some<u64>(v1.round_number), 0x1::option::some<0x1::string::String>(arg4), v7);
        if (v11) {
            let v39 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_rate(v8, v0);
            let v40 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::pool_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T0>(arg0));
            if (v39 > v40) {
                0x48add966e0ecbcb701beba1f649ae8b30f09e9ec86af7a24b28b0446db673e90::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Roulette>(arg5, arg0, v39 - v40, false, v3, arg6, arg7, arg9, arg10);
            };
            let v41 = Roulette{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take<T0, Roulette>(arg0, v41, v39, arg10), arg2);
            let v42 = ReferralPayoutEvent<T0>{
                payout  : v39,
                creator : arg2,
            };
            0x2::event::emit<ReferralPayoutEvent<T0>>(v42);
        };
        if (0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) == 0) {
            v1.risk_manager = 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::risk_manager::new_manager();
            v1.status = 0;
            v1.round_number = v1.round_number + 1;
        };
    }

    entry fun start_roll<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: &mut RouletteConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        assert!(table_exists<T0>(arg2, v0), 3);
        let v2 = borrow_table_mut<T0>(arg2, v0);
        assert!(assert_table_has_bets<T0>(v2), 8);
        assert!(v2.status == 0, 0);
        let v3 = Roulette{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Roulette>(arg0, v3, 0xeb72162cfbecb56f4dd13cd558aadc78162f52f93fe5b24627e5a6f6fe15a74::risk_manager::total_risk(&v2.risk_manager), arg3);
        v2.status = 1;
        let v4 = 0x2::random::generate_u64_in_range(&mut v1, 0, 37);
        assert!(!0x2::table::contains<u64, u64>(&v2.rounds_settled, v2.round_number), 10);
        0x2::table::add<u64, u64>(&mut v2.rounds_settled, v2.round_number, v4);
        let v5 = TableRollEvent<T0>{
            table_id     : 0x2::object::id<RouletteTable<T0>>(v2),
            round_number : v2.round_number,
            outcome      : v4,
            creator      : v0,
        };
        0x2::event::emit<TableRollEvent<T0>>(v5);
    }

    public fun table_exists<T0>(arg0: &RouletteConfig, arg1: address) : bool {
        let v0 = GameTag<T0>{creator: arg1};
        0x2::dynamic_object_field::exists_<GameTag<T0>>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

