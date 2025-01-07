module 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::roulette {
    struct Roulette has copy, drop {
        dummy_field: bool,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet: 0x2::balance::Balance<T0>,
        player: address,
        is_settled: bool,
        name: 0x1::option::Option<0x1::string::String>,
        avatar: 0x1::option::Option<0x2::object::ID>,
        image_url: 0x1::option::Option<0x1::string::String>,
    }

    struct BetDisplay<phantom T0> has drop, store {
        id: 0x2::object::ID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
        name: 0x1::option::Option<0x1::string::String>,
        avatar: 0x1::option::Option<0x2::object::ID>,
        image_url: 0x1::option::Option<0x1::string::String>,
    }

    struct RouletteConfig<phantom T0> has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        place_bet_interval: u64,
        buffer_time: u64,
        min_bet_size: u64,
        current_round: u64,
        current_game_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        status: u8,
        round: u64,
        house_pub_key: vector<u8>,
        bets: 0x2::table_vec::TableVec<Bet<T0>>,
        max_risk: u64,
        risk_manager: 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::risk_manager::RiskManager,
        min_bet_size: u64,
        result_roll: u64,
        settled_bets_count: u64,
        player_bets_table: 0x2::table::Table<address, vector<BetDisplay<T0>>>,
        fund: 0x2::balance::Balance<T0>,
        close_time: u64,
        total_volume: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun max_risk<T0>(arg0: &0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse) : u64 {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::max_risk<T0, Roulette>(0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::borrow_house<T0>(arg0))
    }

    fun borrow_current_game<T0>(arg0: &RouletteConfig<T0>) : &Game<T0> {
        let v0 = arg0.current_round;
        assert!(0x2::dynamic_object_field::exists_<u64>(&arg0.id, v0), 6);
        0x2::dynamic_object_field::borrow<u64, Game<T0>>(&arg0.id, v0)
    }

    fun borrow_current_game_mut<T0>(arg0: &mut RouletteConfig<T0>) : &mut Game<T0> {
        let v0 = arg0.current_round;
        assert!(0x2::dynamic_object_field::exists_<u64>(&arg0.id, v0), 6);
        0x2::dynamic_object_field::borrow_mut<u64, Game<T0>>(&mut arg0.id, v0)
    }

    fun borrow_game<T0>(arg0: &RouletteConfig<T0>, arg1: u64) : &Game<T0> {
        assert!(0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1), 7);
        0x2::dynamic_object_field::borrow<u64, Game<T0>>(&arg0.id, arg1)
    }

    fun borrow_game_mut<T0>(arg0: &mut RouletteConfig<T0>, arg1: u64) : &mut Game<T0> {
        assert!(0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1), 7);
        0x2::dynamic_object_field::borrow_mut<u64, Game<T0>>(&mut arg0.id, arg1)
    }

    public fun close_game<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut RouletteConfig<T0>, arg2: &0x2::clock::Clock, arg3: vector<u8>) {
        let v0 = arg1.buffer_time;
        if (!current_game_exists<T0>(arg1)) {
            return
        };
        let v1 = borrow_current_game_mut<T0>(arg1);
        if (v1.status != 0) {
            return
        };
        if (0x2::clock::timestamp_ms(arg2) < v1.close_time + v0) {
            return
        };
        let v2 = 0x2::object::id<Game<T0>>(v1);
        let v3 = 0x2::object::id_to_bytes(&v2);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v1.house_pub_key, &v3), 5);
        v1.status = 1;
        let v4 = roll(0x2::hash::blake2b256(&arg3));
        let v5 = v1.round;
        v1.result_roll = v4;
        v1.status = 1;
        0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::emit_game_closed<T0>(v5, v2, v4);
        let v6 = 0x2::table_vec::is_empty<Bet<T0>>(&v1.bets);
        if (v6) {
            v1.status = 3;
            0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::emit_game_completed<T0>(v5, v2);
        };
        if (v6) {
            let v7 = Roulette{dummy_field: false};
            0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::join<T0, Roulette>(v7, arg0, delete_bets_internal<T0>(arg1, v5, 0));
        };
    }

    public fun create_config<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = RouletteConfig<T0>{
            id                 : 0x2::object::new(arg5),
            pub_key            : arg1,
            place_bet_interval : arg2,
            buffer_time        : arg3,
            min_bet_size       : arg4,
            current_round      : 0,
            current_game_id    : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<RouletteConfig<T0>>(v0);
    }

    public fun create_game<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut RouletteConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 <= current_close_time<T0>(arg1)) {
            return 0
        };
        let v1 = max_risk<T0>(arg0);
        let v2 = Roulette{dummy_field: false};
        let v3 = arg1.current_round + 1;
        let v4 = Game<T0>{
            id                 : 0x2::object::new(arg3),
            status             : 0,
            round              : v3,
            house_pub_key      : arg1.pub_key,
            bets               : 0x2::table_vec::empty<Bet<T0>>(arg3),
            max_risk           : v1,
            risk_manager       : 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::risk_manager::new_manager(),
            min_bet_size       : arg1.min_bet_size,
            result_roll        : 38,
            settled_bets_count : 0,
            player_bets_table  : 0x2::table::new<address, vector<BetDisplay<T0>>>(arg3),
            fund               : 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::split<T0, Roulette>(v2, arg0, v1),
            close_time         : v0 + arg1.place_bet_interval,
            total_volume       : 0,
        };
        let v5 = 0x2::object::id<Game<T0>>(&v4);
        arg1.current_round = v3;
        arg1.current_game_id = 0x1::option::some<0x2::object::ID>(v5);
        0x2::dynamic_object_field::add<u64, Game<T0>>(&mut arg1.id, v3, v4);
        0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::emit_game_created<T0>(v3, v5);
        v3
    }

    public fun current_close_time<T0>(arg0: &RouletteConfig<T0>) : u64 {
        if (current_game_exists<T0>(arg0)) {
            borrow_current_game<T0>(arg0).close_time
        } else {
            0
        }
    }

    fun current_game_exists<T0>(arg0: &RouletteConfig<T0>) : bool {
        0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg0.current_round)
    }

    public fun current_game_id<T0>(arg0: &RouletteConfig<T0>) : 0x2::object::ID {
        0x2::object::id<Game<T0>>(borrow_current_game<T0>(arg0))
    }

    public fun current_round<T0>(arg0: &RouletteConfig<T0>) : u64 {
        arg0.current_round
    }

    fun delete_bet<T0>(arg0: Bet<T0>) {
        let Bet {
            id         : v0,
            bet_type   : _,
            bet_number : _,
            bet        : v3,
            player     : _,
            is_settled : _,
            name       : _,
            avatar     : _,
            image_url  : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
    }

    public fun delete_bets<T0>(arg0: &AdminCap, arg1: &mut RouletteConfig<T0>, arg2: u64, arg3: u64) {
        if (!game_exists<T0>(arg1, arg2)) {
            return
        };
        let v0 = borrow_game_mut<T0>(arg1, arg2);
        assert!(v0.status == 3, 9);
        0x2::balance::destroy_zero<T0>(delete_bets_internal<T0>(arg1, arg2, arg3));
    }

    fun delete_bets_internal<T0>(arg0: &mut RouletteConfig<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = borrow_game_mut<T0>(arg0, arg1);
        if (arg2 > 0x2::table_vec::length<Bet<T0>>(&v0.bets)) {
            arg2 = 0x2::table_vec::length<Bet<T0>>(&v0.bets);
        };
        let v1 = 0;
        while (v1 < arg2) {
            delete_bet<T0>(0x2::table_vec::pop_back<Bet<T0>>(&mut v0.bets));
            v1 = v1 + 1;
        };
        if (0x2::table_vec::is_empty<Bet<T0>>(&v0.bets)) {
            delete_game<T0>(0x2::dynamic_object_field::remove<u64, Game<T0>>(&mut arg0.id, arg1))
        } else {
            0x2::balance::zero<T0>()
        }
    }

    fun delete_game<T0>(arg0: Game<T0>) : 0x2::balance::Balance<T0> {
        let Game {
            id                 : v0,
            status             : _,
            round              : _,
            house_pub_key      : _,
            bets               : v4,
            max_risk           : _,
            risk_manager       : _,
            min_bet_size       : _,
            result_roll        : _,
            settled_bets_count : _,
            player_bets_table  : v10,
            fund               : v11,
            close_time         : _,
            total_volume       : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table_vec::destroy_empty<Bet<T0>>(v4);
        0x2::table::drop<address, vector<BetDisplay<T0>>>(v10);
        v11
    }

    fun game_exists<T0>(arg0: &RouletteConfig<T0>, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)
    }

    public fun game_total_volume<T0>(arg0: &RouletteConfig<T0>, arg1: u64) : u64 {
        borrow_game<T0>(arg0, arg1).total_volume
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun place_bet<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut RouletteConfig<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: 0x1::option::Option<0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < 13, 3);
        if (arg4 == 2) {
            assert!(0x1::option::is_some<u64>(&arg5), 4);
            assert!(*0x1::option::borrow<u64>(&arg5) < 38, 4);
        };
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = borrow_current_game_mut<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < v1.close_time, 1);
        let (_, _) = 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::risk_manager::add_risk(&mut v1.risk_manager, arg4, arg5, 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::bet_manager::get_bet_payout(v0, arg4));
        let v4 = borrow_current_game_mut<T0>(arg1);
        assert!(0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::risk_manager::total_risk(&v4.risk_manager) <= v4.max_risk, 0);
        assert!(v4.status == 0, 1);
        v4.total_volume = v4.total_volume + v0;
        assert!(v0 >= v4.min_bet_size, 2);
        let v5 = 0x2::tx_context::sender(arg9);
        let v6 = Bet<T0>{
            id         : 0x2::object::new(arg9),
            bet_type   : arg4,
            bet_number : arg5,
            bet        : 0x2::coin::into_balance<T0>(arg3),
            player     : v5,
            is_settled : false,
            name       : arg6,
            avatar     : arg7,
            image_url  : arg8,
        };
        let v7 = 0x2::balance::value<T0>(&v6.bet);
        let v8 = *0x2::object::uid_as_inner(&v6.id);
        0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::emit_place_bet<T0>(v4.round, 0x2::object::id<Game<T0>>(v4), v8, v6.bet_type, v6.bet_number, v7, v6.player);
        0x2::table_vec::push_back<Bet<T0>>(&mut v4.bets, v6);
        let v9 = BetDisplay<T0>{
            id         : v8,
            bet_type   : arg4,
            bet_number : arg5,
            bet_size   : v7,
            player     : v5,
            name       : arg6,
            avatar     : arg7,
            image_url  : arg8,
        };
        let v10 = &mut v4.player_bets_table;
        if (0x2::table::contains<address, vector<BetDisplay<T0>>>(v10, v5)) {
            0x1::vector::push_back<BetDisplay<T0>>(0x2::table::borrow_mut<address, vector<BetDisplay<T0>>>(v10, v5), v9);
        } else {
            0x2::table::add<address, vector<BetDisplay<T0>>>(v10, v5, 0x1::vector::singleton<BetDisplay<T0>>(v9));
        };
        let v11 = Roulette{dummy_field: false};
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::add_volume<T0, Roulette>(v11, arg0, v0, arg9);
    }

    public fun place_bet_with_voucher<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut RouletteConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::voucher::Voucher<T0>, arg4: u64, arg5: u8, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x1::option::Option<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun place_bet_with_voucher_v2<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut RouletteConfig<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x4dddcb945d5aa88a03f0f3f88c78dbed2ab34086a22a5e7c44a06ed6bddf5e22::voucher::Voucher<T0>, arg4: u64, arg5: u8, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x1::option::Option<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < 13, 3);
        if (arg5 == 2) {
            assert!(0x1::option::is_some<u64>(&arg6), 4);
            assert!(*0x1::option::borrow<u64>(&arg6) < 38, 4);
        };
        assert!(0x4dddcb945d5aa88a03f0f3f88c78dbed2ab34086a22a5e7c44a06ed6bddf5e22::voucher::balance<T0>(arg3) >= arg4, 10);
        let v0 = Roulette{dummy_field: false};
        0x4dddcb945d5aa88a03f0f3f88c78dbed2ab34086a22a5e7c44a06ed6bddf5e22::voucher::deduct_balance<T0, Roulette>(v0, arg0, arg3, arg4);
        let v1 = Roulette{dummy_field: false};
        let v2 = borrow_current_game_mut<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < v2.close_time, 1);
        let (_, _) = 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::risk_manager::add_risk(&mut v2.risk_manager, arg5, arg6, 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::bet_manager::get_bet_payout(arg4, arg5));
        let v5 = borrow_current_game_mut<T0>(arg1);
        assert!(0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::risk_manager::total_risk(&v5.risk_manager) <= v5.max_risk, 0);
        assert!(v5.status == 0, 1);
        v5.total_volume = v5.total_volume + arg4;
        assert!(arg4 >= v5.min_bet_size, 2);
        let v6 = 0x2::tx_context::sender(arg10);
        let v7 = Bet<T0>{
            id         : 0x2::object::new(arg10),
            bet_type   : arg5,
            bet_number : arg6,
            bet        : 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::split<T0, Roulette>(v1, arg0, arg4),
            player     : v6,
            is_settled : false,
            name       : arg7,
            avatar     : arg8,
            image_url  : arg9,
        };
        let v8 = 0x2::balance::value<T0>(&v7.bet);
        let v9 = *0x2::object::uid_as_inner(&v7.id);
        0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::emit_place_bet_with_voucher<T0>(0x2::object::id<0x4dddcb945d5aa88a03f0f3f88c78dbed2ab34086a22a5e7c44a06ed6bddf5e22::voucher::Voucher<T0>>(arg3), v5.round, 0x2::object::id<Game<T0>>(v5), v9, v7.bet_type, v7.bet_number, v8, v7.player);
        0x2::table_vec::push_back<Bet<T0>>(&mut v5.bets, v7);
        let v10 = BetDisplay<T0>{
            id         : v9,
            bet_type   : arg5,
            bet_number : arg6,
            bet_size   : v8,
            player     : v6,
            name       : arg7,
            avatar     : arg8,
            image_url  : arg9,
        };
        let v11 = &mut v5.player_bets_table;
        if (0x2::table::contains<address, vector<BetDisplay<T0>>>(v11, v6)) {
            0x1::vector::push_back<BetDisplay<T0>>(0x2::table::borrow_mut<address, vector<BetDisplay<T0>>>(v11, v6), v10);
        } else {
            0x2::table::add<address, vector<BetDisplay<T0>>>(v11, v6, 0x1::vector::singleton<BetDisplay<T0>>(v10));
        };
        let v12 = Roulette{dummy_field: false};
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::add_volume<T0, Roulette>(v12, arg0, arg4, arg10);
    }

    fun roll(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
            v1 = v1 + 1;
        };
        ((v0 % 38) as u64)
    }

    public fun settle_bets<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut RouletteConfig<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (!game_exists<T0>(arg1, arg2)) {
            return
        };
        let v0 = borrow_game_mut<T0>(arg1, arg2);
        if (v0.status == 3) {
            return
        };
        assert!(v0.status != 0, 8);
        let v1 = arg3;
        let v2 = arg3 + arg4;
        let v3 = v2;
        let v4 = 0x2::table_vec::length<Bet<T0>>(&v0.bets);
        if (v2 > v4) {
            v3 = v4;
        };
        let v5 = 0x1::vector::empty<0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::BetResult<T0>>();
        v0.status = 2;
        let v6 = v0.result_roll;
        while (v1 < v3) {
            let v7 = 0x2::table_vec::borrow_mut<Bet<T0>>(&mut v0.bets, v1);
            let v8 = 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::bet_manager::won_bet(v7.bet_type, v6, v7.bet_number);
            if (arg5 != v8) {
                v1 = v1 + 1;
                continue
            };
            if (v7.is_settled) {
                v1 = v1 + 1;
                continue
            };
            let v9 = v7.player;
            let v10 = 0x2::balance::value<T0>(&v7.bet);
            let v11 = 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::bet_manager::get_bet_payout(v10, v7.bet_type);
            0x1::vector::push_back<0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::BetResult<T0>>(&mut v5, 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::new_bet_result<T0>(*0x2::object::uid_as_inner(&v7.id), v8, v7.bet_type, v7.bet_number, v10, v7.player));
            let v12 = 0x2::coin::take<T0>(&mut v7.bet, v10, arg6);
            v7.is_settled = true;
            let v13 = &mut v0.player_bets_table;
            if (0x2::table::contains<address, vector<BetDisplay<T0>>>(v13, v9)) {
                0x2::table::remove<address, vector<BetDisplay<T0>>>(v13, v9);
            };
            v0.settled_bets_count = v0.settled_bets_count + 1;
            if (v8) {
                0x2::coin::join<T0>(&mut v12, 0x2::coin::take<T0>(&mut v0.fund, v11, arg6));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v9);
            } else {
                0x2::coin::put<T0>(&mut v0.fund, v12);
            };
            v1 = v1 + 1;
        };
        let v14 = 0x2::object::id<Game<T0>>(v0);
        0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::emit_game_settlement<T0>(arg2, v14, v6, v5);
        if (v0.settled_bets_count == v4) {
            v0.status = 3;
            let v15 = Roulette{dummy_field: false};
            0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::join<T0, Roulette>(v15, arg0, 0x2::balance::withdraw_all<T0>(&mut v0.fund));
            0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::events::emit_game_completed<T0>(v0.round, v14);
        };
    }

    public fun update_config<T0>(arg0: &AdminCap, arg1: &mut RouletteConfig<T0>, arg2: u64, arg3: u64, arg4: u64) {
        arg1.place_bet_interval = arg2;
        arg1.buffer_time = arg3;
        arg1.min_bet_size = arg4;
    }

    // decompiled from Move bytecode v6
}

