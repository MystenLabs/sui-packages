module 0xcc2a73921f5c3f0fc11e910afaf836def3bab7cb1ecdbc4e2757034f0841e5d5::multi_plinko {
    struct TableCreated<phantom T0, phantom T1> has copy, drop {
        table_id: 0x2::object::ID,
        creator: address,
    }

    struct BetAdded<phantom T0, phantom T1> has copy, drop, store {
        bet_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
        creator: address,
        player: address,
        bet_amount: u64,
    }

    struct BetRemoved<phantom T0, phantom T1> has copy, drop, store {
        bet_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
        creator: address,
        player: address,
        bet_amount: u64,
    }

    struct Plinko has copy, drop {
        dummy_field: bool,
    }

    struct GameTag<phantom T0> has copy, drop, store {
        creator: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlinkoConfig has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct PlinkoTable<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        round_number: u64,
        status: u8,
        current_bets: 0x2::linked_table::LinkedTable<address, Bet<T0>>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        amount: u64,
    }

    public fun add_bet<T0>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut PlinkoConfig, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 12);
        let v0 = borrow_table_mut<T0>(arg1, arg2);
        assert!(v0.status == 0, 4);
        assert!(0x2::linked_table::length<address, Bet<T0>>(&v0.current_bets) < 1000, 5);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(arg3));
        let v3 = &mut v0.current_bets;
        let v4 = handle_add_bet<T0>(v3, v2, v1, arg4);
        emit_bet_added<T0, Plinko>(arg0, 0x2::object::uid_to_inner(&v0.id), v4, arg2, v2, v1);
        v4
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut PlinkoConfig, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_valid_version(arg0: &PlinkoConfig) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 6);
    }

    fun borrow_table_mut<T0>(arg0: &mut PlinkoConfig, arg1: address) : &mut PlinkoTable<T0> {
        let v0 = GameTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow_mut<GameTag<T0>, PlinkoTable<T0>>(&mut arg0.id, v0)
    }

    public fun create_plinko_table<T0>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut PlinkoConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!table_exists<T0>(arg1, v0), 2);
        let v1 = PlinkoTable<T0>{
            id           : 0x2::object::new(arg2),
            creator      : v0,
            round_number : 0,
            status       : 0,
            current_bets : 0x2::linked_table::new<address, Bet<T0>>(arg2),
            balance      : 0x2::balance::zero<T0>(),
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = GameTag<T0>{creator: v0};
        0x2::dynamic_object_field::add<GameTag<T0>, PlinkoTable<T0>>(&mut arg1.id, v3, v1);
        emit_table_created<T0, Plinko>(arg0, v2, v0);
        v2
    }

    fun destroy_bet<T0>(arg0: Bet<T0>) : (0x2::object::ID, u64) {
        let Bet {
            id     : v0,
            player : _,
            amount : v2,
        } = arg0;
        let v3 = v0;
        0x2::object::delete(v3);
        (0x2::object::uid_to_inner(&v3), v2)
    }

    public fun emit_bet_added<T0, T1: drop>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: u64) {
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::game_config_exists<T0, T1>(arg0), 15);
        let v0 = BetAdded<T0, T1>{
            bet_id     : arg2,
            table_id   : arg1,
            creator    : arg3,
            player     : arg4,
            bet_amount : arg5,
        };
        0x2::event::emit<BetAdded<T0, T1>>(v0);
    }

    public fun emit_bet_removed<T0, T1: drop>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: u64) {
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::game_config_exists<T0, T1>(arg0), 15);
        let v0 = BetRemoved<T0, T1>{
            bet_id     : arg2,
            table_id   : arg1,
            creator    : arg3,
            player     : arg4,
            bet_amount : arg5,
        };
        0x2::event::emit<BetRemoved<T0, T1>>(v0);
    }

    public fun emit_table_created<T0, T1: drop>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::object::ID, arg2: address) {
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::game_config_exists<T0, T1>(arg0), 15);
        let v0 = TableCreated<T0, T1>{
            table_id : arg1,
            creator  : arg2,
        };
        0x2::event::emit<TableCreated<T0, T1>>(v0);
    }

    fun generate_ball_path_and_roll(arg0: vector<u64>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : (vector<u8>, u64) {
        let v0 = 0x1::vector::length<u64>(&arg0) - 1;
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = u64_to_binary(0x2::random::generate_u64_in_range(&mut v1, 0, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::pow(2, (v0 as u8)) - 1), v0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + (*0x1::vector::borrow<u8>(&v2, v4) as u64);
            v4 = v4 + 1;
        };
        (v2, v3)
    }

    fun get_plinko_config(arg0: u8, arg1: bool) : vector<u64> {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 0);
        if (arg1) {
            if (arg0 == 0) {
                return vector[700, 140, 75, 50, 75, 140, 700]
            };
            if (arg0 == 1) {
                return vector[3000, 500, 180, 75, 40, 40, 75, 180, 500, 3000]
            };
            vector[10000, 1100, 350, 150, 100, 70, 40, 70, 100, 150, 350, 1100, 10000]
        } else {
            if (arg0 == 0) {
                return vector[600, 135, 80, 50, 80, 135, 600]
            };
            if (arg0 == 1) {
                return vector[3000, 600, 150, 70, 40, 40, 70, 150, 600, 3000]
            };
            vector[10000, 1000, 300, 150, 100, 65, 40, 65, 100, 150, 300, 1000, 10000]
        }
    }

    fun handle_add_bet<T0>(arg0: &mut 0x2::linked_table::LinkedTable<address, Bet<T0>>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (0x2::linked_table::contains<address, Bet<T0>>(arg0, arg1)) {
            let v1 = 0x2::linked_table::remove<address, Bet<T0>>(arg0, arg1);
            v1.amount = v1.amount + arg2;
            0x2::linked_table::push_back<address, Bet<T0>>(arg0, arg1, v1);
            0x2::object::uid_to_inner(&v1.id)
        } else {
            let v2 = Bet<T0>{
                id     : 0x2::object::new(arg3),
                player : arg1,
                amount : arg2,
            };
            0x2::linked_table::push_back<address, Bet<T0>>(arg0, arg1, v2);
            0x2::object::uid_to_inner(&v2.id)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PlinkoConfig{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<PlinkoConfig>(v1);
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 100) as u64)
    }

    public fun package_version() : u64 {
        1
    }

    entry fun play_plinko<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut PlinkoConfig, arg2: &0x2::random::Random, arg3: address, arg4: u64, arg5: u64, arg6: u8, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::house_exists<T0>(arg0), 13);
        assert!(table_exists<T0>(arg1, arg3), 12);
        assert!(arg4 <= 1000, 18);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg2, arg8);
        let v0 = borrow_table_mut<T0>(arg1, arg3);
        assert!(v0.status == 0, 4);
        assert!(table_has_bets<T0>(v0), 9);
        let v1 = Plinko{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Plinko>(arg0, v1, risk(arg5, arg6), arg8);
        assert!(0x2::balance::value<T0>(&v0.balance) == arg4 * arg5, 1);
        assert!(0x2::tx_context::sender(arg8) == arg3, 8);
        v0.status = 1;
        settle_and_payout<T0>(arg0, arg2, v0, arg3, arg4, arg5, arg6, false, arg7, arg8);
        assert!(v0.status == 0, 14);
    }

    entry fun play_singles_plinko<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg6);
        singles_settle_and_payout<T0>(arg0, arg1, arg3, arg2, arg4, false, arg5, arg6);
    }

    public fun remove_bet<T0>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut PlinkoConfig, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg1);
        assert!(table_exists<T0>(arg1, arg2), 12);
        let v0 = borrow_table_mut<T0>(arg1, arg2);
        assert!(v0.status == 0, 4);
        assert!(0x2::linked_table::contains<address, Bet<T0>>(&v0.current_bets, arg3), 7);
        let (v1, v2) = destroy_bet<T0>(0x2::linked_table::remove<address, Bet<T0>>(&mut v0.current_bets, arg3));
        emit_bet_removed<T0, Plinko>(arg0, 0x2::object::uid_to_inner(&v0.id), v1, arg2, arg3, v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v2), arg4)
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut PlinkoConfig, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    fun risk(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0 * 6
        } else if (arg1 == 1) {
            arg0 * 30
        } else if (arg1 == 2) {
            arg0 * 100
        } else {
            0
        }
    }

    fun settle_and_payout<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: &mut PlinkoTable<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u8, arg7: bool, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg5;
        let v1 = Plinko{dummy_field: false};
        let v2 = get_plinko_config(arg6, arg7);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>();
        while (v3 < arg4) {
            v3 = v3 + 1;
            let (v6, v7) = generate_ball_path_and_roll(v2, arg1, arg9);
            let v8 = v4;
            v4 = v8 + mul(arg5, *0x1::vector::borrow<u64>(&v2, v7));
            let v9 = Plinko{dummy_field: false};
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>(&mut v5, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_ball_outcome_event<T0, Plinko>(arg0, v9, v7, v6));
        };
        assert!(0x1::vector::length<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>(&v5) == arg4, 19);
        let v10 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0>>();
        let v11 = 0x2::balance::zero<T0>();
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::join_with_fee<T0, Plinko>(arg0, v1, 0x2::balance::split<T0>(&mut arg2.balance, v0));
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut v11, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::split_with_reimbursement<T0, Plinko>(arg0, v1, v4));
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&v4), arg9);
        };
        while (!0x2::linked_table::is_empty<address, Bet<T0>>(&arg2.current_bets)) {
            let (_, v13) = 0x2::linked_table::pop_front<address, Bet<T0>>(&mut arg2.current_bets);
            let v14 = v13;
            let v15 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(v4, v14.amount, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v11, v15, arg9), v14.player);
            let v16 = Plinko{dummy_field: false};
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0>>(&mut v10, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_bet_result_event<T0, Plinko>(arg0, v16, v14.player, 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v14.id)), v14.amount, v15));
            let (_, _) = destroy_bet<T0>(v14);
        };
        let v19 = 0x2::balance::value<T0>(&v11);
        if (v19 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v11, v19, arg9), arg3);
        };
        0x2::balance::destroy_zero<T0>(v11);
        assert!(0x2::linked_table::is_empty<address, Bet<T0>>(&arg2.current_bets), 20);
        assert!(0x2::balance::value<T0>(&arg2.balance) == 0, 11);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_plinko_game_result<T0, Plinko>(arg0, 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&arg2.id)), 0x1::option::some<address>(arg3), arg6, arg4, v0, v4, v5, v10, arg8);
        arg2.status = 0;
        arg2.round_number = arg2.round_number + 1;
    }

    fun singles_settle_and_payout<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: u8, arg3: u64, arg4: 0x1::string::String, arg5: bool, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::house_exists<T0>(arg0), 13);
        assert!(arg3 <= 1000, 18);
        let v0 = 0x2::coin::value<T0>(&arg6);
        let v1 = Plinko{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Plinko>(arg0, v1, risk(v0, arg2), arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = get_plinko_config(arg2, arg5);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>();
        while (v4 < arg3) {
            v4 = v4 + 1;
            let (v7, v8) = generate_ball_path_and_roll(v3, arg1, arg7);
            let v9 = v5;
            v5 = v9 + mul(v0 / arg3, *0x1::vector::borrow<u64>(&v3, v8));
            let v10 = Plinko{dummy_field: false};
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>(&mut v6, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_ball_outcome_event<T0, Plinko>(arg0, v10, v8, v7));
        };
        assert!(0x1::vector::length<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BallOutcome>(&v6) == arg3, 19);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Plinko>(arg0, v1, arg6);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, Plinko>(arg0, v1, v5, arg7), v2);
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&v5), arg7);
        };
        let v11 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0>>();
        let v12 = Plinko{dummy_field: false};
        0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0>>(&mut v11, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_bet_result_event<T0, Plinko>(arg0, v12, v2, 0x1::option::none<0x2::object::ID>(), v0, v5));
        assert!(0x1::vector::length<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BetResult<T0>>(&v11) == 1, 10);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_plinko_game_result<T0, Plinko>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::some<address>(v2), arg2, arg3, v0, v5, v6, v11, arg4);
    }

    public fun table_exists<T0>(arg0: &PlinkoConfig, arg1: address) : bool {
        let v0 = GameTag<T0>{creator: arg1};
        0x2::dynamic_object_field::exists_<GameTag<T0>>(&arg0.id, v0)
    }

    fun table_has_bets<T0>(arg0: &PlinkoTable<T0>) : bool {
        0x2::linked_table::length<address, Bet<T0>>(&arg0.current_bets) > 0
    }

    fun u64_to_binary(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 2) as u8));
            arg0 = arg0 / 2;
        };
        while (0x1::vector::length<u8>(&v0) < arg1) {
            0x1::vector::push_back<u8>(&mut v0, 0);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

