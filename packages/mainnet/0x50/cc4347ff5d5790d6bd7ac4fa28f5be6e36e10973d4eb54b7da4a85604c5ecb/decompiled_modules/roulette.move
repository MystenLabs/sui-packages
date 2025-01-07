module 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::roulette {
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
        risk_manager: 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::risk_manager::RiskManager,
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

    public fun assert_within_risk<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = Roulette{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Roulette>(arg0, v0, arg1, arg2);
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
        let (_, _) = 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::risk_manager::add_risk(&mut v0.risk_manager, arg4, arg5, 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::bet_manager::get_bet_payout(v1, arg4));
        let v4 = Roulette{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Roulette>(arg0, v4, 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::risk_manager::total_risk(&v0.risk_manager), arg7);
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
            risk_manager   : 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::risk_manager::new_manager(),
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
        let v0 = borrow_table_mut<T0>(arg1, arg2);
        assert!(0x2::linked_table::length<address, vector<Bet>>(&v0.current_bets) != 0, 4);
        let v1 = 0x2::table::borrow<u64, u64>(&v0.rounds_settled, v0.round_number);
        let v2 = 0x1::vector::empty<PlayerWin<T0>>();
        let v3 = 0;
        let v4 = 0x2::balance::zero<T0>();
        let v5 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Roulette>>();
        let v6 = 0;
        let v7 = 10000;
        if (0x1::option::is_some<u64>(&arg3)) {
            v7 = *0x1::option::borrow<u64>(&arg3);
        };
        let v8 = 0;
        while (v8 < v7 && 0x2::linked_table::length<address, vector<Bet>>(&v0.current_bets) > 0) {
            let (v9, v10) = 0x2::linked_table::pop_back<address, vector<Bet>>(&mut v0.current_bets);
            let v11 = v10;
            while (v8 < v7 && 0x1::vector::length<Bet>(&v11) != 0) {
                let v12 = 0x1::vector::pop_back<Bet>(&mut v11);
                let Bet {
                    id         : v13,
                    bet_type   : v14,
                    bet_number : v15,
                    bet_size   : v16,
                    player     : v17,
                } = v12;
                let v18 = 0x2::balance::split<T0>(&mut v0.balance, v16);
                if (v17 != arg2) {
                    v6 = v6 + 0x2::balance::value<T0>(&v18);
                };
                let v19 = 0;
                let v20 = v19;
                if (0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::bet_manager::won_bet(v14, *v1, v15)) {
                    let v21 = 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::bet_manager::get_bet_payout(v16, v14);
                    v3 = v3 + v21;
                    let v22 = PlayerWin<T0>{
                        player      : v17,
                        bet_balance : v18,
                        bet_payout  : v21,
                    };
                    0x1::vector::push_back<PlayerWin<T0>>(&mut v2, v22);
                    v20 = v19 + v21 + v16;
                } else {
                    0x2::balance::join<T0>(&mut v4, v18);
                };
                0x2::object::delete(v13);
                0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Roulette>>(&mut v5, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, Roulette>(0x1::option::some<0x2::object::ID>(0x2::object::id<Bet>(&v12)), v17, (v14 as u64), v15, v16, v20, *v1));
                v8 = v8 + 1;
            };
            if (v8 >= v7 && !0x1::vector::is_empty<Bet>(&v11)) {
                0x2::linked_table::push_back<address, vector<Bet>>(&mut v0.current_bets, v9, v11);
                break
            };
            0x1::vector::destroy_empty<Bet>(v11);
        };
        if (!0x1::vector::is_empty<PlayerWin<T0>>(&v2)) {
            let v23 = Roulette{dummy_field: false};
            let v24 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::split_with_reimbursement<T0, Roulette>(arg0, v23, v3);
            while (!0x1::vector::is_empty<PlayerWin<T0>>(&v2)) {
                let PlayerWin {
                    player      : v25,
                    bet_balance : v26,
                    bet_payout  : v27,
                } = 0x1::vector::pop_back<PlayerWin<T0>>(&mut v2);
                let v28 = 0x2::balance::split<T0>(&mut v24, v27);
                0x2::balance::join<T0>(&mut v28, v26);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v28, arg5), v25);
            };
            0x2::balance::destroy_zero<T0>(v24);
        };
        0x1::vector::destroy_empty<PlayerWin<T0>>(v2);
        if (0x2::balance::value<T0>(&v4) != 0) {
            let v29 = Roulette{dummy_field: false};
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Roulette>(arg0, v29, 0x2::coin::from_balance<T0>(v4, arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Roulette>(arg0, 0x1::option::some<0x2::object::ID>(0x2::object::id<RouletteTable<T0>>(v0)), 0x1::option::some<u64>(v0.round_number), 0x1::option::some<0x1::string::String>(arg4), v5);
        if (0x2::linked_table::length<address, vector<Bet>>(&v0.current_bets) == 0) {
            v0.risk_manager = 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::risk_manager::new_manager();
            v0.status = 0;
            v0.round_number = v0.round_number + 1;
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
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Roulette>(arg0, v3, 0x9fa42aa6f73652e3123701705731873bee2fc407b05777b96583bfa389277053::risk_manager::total_risk(&v2.risk_manager), arg3);
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

