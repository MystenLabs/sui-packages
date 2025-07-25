module 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::plinko {
    struct PlinkoConfig<phantom T0> has store {
        num_rows: u8,
        multipliers: vector<0x1::uq32_32::UQ32_32>,
        min_bet: u64,
        max_bet: u64,
        is_playable: bool,
    }

    struct PlinkoGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_bet: u64,
        max_bet: u64,
        max_number_of_balls: u8,
        bets: 0x2::vec_map::VecMap<0x2::object::ID, Bet<T0>>,
        configs: 0x2::vec_map::VecMap<u8, PlinkoConfig<T0>>,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        gambler: address,
        number_of_balls: u8,
        total_stake_value: u64,
        fund: 0x2::balance::Balance<T0>,
        plinko_config_number: u8,
    }

    public fun bet<T0>(arg0: &mut PlinkoGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        place_bet<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun create_plinko_config_and_add_to_game<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut PlinkoGame<T0>, arg2: u8, arg3: vector<0x1::uq32_32::UQ32_32>, arg4: u64, arg5: u64, arg6: bool, arg7: u8) {
        private_create_plinko_config_and_add_to_game<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun create_plinko_game<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PlinkoGame<T0>{
            id                  : 0x2::object::new(arg4),
            min_bet             : arg1,
            max_bet             : arg2,
            max_number_of_balls : arg3,
            bets                : 0x2::vec_map::empty<0x2::object::ID, Bet<T0>>(),
            configs             : 0x2::vec_map::empty<u8, PlinkoConfig<T0>>(),
        };
        0x2::transfer::share_object<PlinkoGame<T0>>(v0);
    }

    public fun edit_plinko_config<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut PlinkoGame<T0>, arg2: u8, arg3: u8, arg4: vector<0x1::uq32_32::UQ32_32>, arg5: u64, arg6: u64, arg7: bool) {
        assert!(0x1::vector::length<0x1::uq32_32::UQ32_32>(&arg4) == (arg3 as u64) + 1, 11);
        let v0 = 0x2::vec_map::get_mut<u8, PlinkoConfig<T0>>(&mut arg1.configs, &arg2);
        v0.num_rows = arg3;
        v0.multipliers = arg4;
        v0.min_bet = arg5;
        v0.max_bet = arg6;
        v0.is_playable = arg7;
    }

    public fun edit_plinko_game<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut PlinkoGame<T0>, arg2: u64, arg3: u64, arg4: u8) {
        arg1.min_bet = arg2;
        arg1.max_bet = arg3;
        arg1.max_number_of_balls = arg4;
    }

    fun generate_ball_roll(arg0: vector<0x1::uq32_32::UQ32_32>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x1::vector::length<0x1::uq32_32::UQ32_32>(&arg0) - 1;
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = u64_to_binary(0x2::random::generate_u64_in_range(&mut v1, 0, 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::math::pow(2, (v0 as u8)) - 1), v0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            v3 = v3 + *0x1::vector::borrow<u8>(&v2, v4);
            v4 = v4 + 1;
        };
        v3
    }

    fun get_max_value(arg0: vector<0x1::uq32_32::UQ32_32>) : 0x1::uq32_32::UQ32_32 {
        assert!(0x1::vector::length<0x1::uq32_32::UQ32_32>(&arg0) > 0, 10);
        let v0 = *0x1::vector::borrow<0x1::uq32_32::UQ32_32>(&arg0, 0);
        let v1 = 1;
        while (v1 < 0x1::vector::length<0x1::uq32_32::UQ32_32>(&arg0)) {
            let v2 = *0x1::vector::borrow<0x1::uq32_32::UQ32_32>(&arg0, v1);
            if (0x1::uq32_32::gt(v2, v0)) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlinkoGame<0x2::sui::SUI>{
            id                  : 0x2::object::new(arg0),
            min_bet             : 100000000,
            max_bet             : 50000000000,
            max_number_of_balls : 10,
            bets                : 0x2::vec_map::empty<0x2::object::ID, Bet<0x2::sui::SUI>>(),
            configs             : 0x2::vec_map::empty<u8, PlinkoConfig<0x2::sui::SUI>>(),
        };
        let v1 = &mut v0;
        private_initialize_plinko_configs<0x2::sui::SUI>(v1);
        0x2::transfer::share_object<PlinkoGame<0x2::sui::SUI>>(v0);
    }

    public fun initialize_plinko_configs<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut PlinkoGame<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        private_initialize_plinko_configs<T0>(arg1);
    }

    fun place_bet<T0>(arg0: &mut PlinkoGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::vec_map::contains<u8, PlinkoConfig<T0>>(&arg0.configs, &arg2), 9);
        let v0 = 0x2::vec_map::get<u8, PlinkoConfig<T0>>(&arg0.configs, &arg2);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = v1 / (arg4 as u64);
        assert!(v3 <= arg0.max_bet, 1);
        assert!(v3 >= arg0.min_bet, 0);
        assert!(v3 >= v0.min_bet, 0);
        assert!(v3 <= v0.max_bet, 1);
        assert!(v0.is_playable, 12);
        assert!(arg4 <= arg0.max_number_of_balls, 8);
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::deposit<T0>(arg1, arg3);
        let v4 = Bet<T0>{
            id                   : 0x2::object::new(arg5),
            gambler              : v2,
            number_of_balls      : arg4,
            total_stake_value    : v1,
            fund                 : 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::take_fund_balance<T0>(arg1, 0x1::uq32_32::int_mul(v1, get_max_value(v0.multipliers))),
            plinko_config_number : arg2,
        };
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::distribute_referral_rewards<T0>(arg1, v1, v2);
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events::emit_plinko_bet_event(0x2::object::uid_to_inner(&v4.id), v1, arg4, v1, arg2, v0.num_rows, v2, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        0x2::vec_map::insert<0x2::object::ID, Bet<T0>>(&mut arg0.bets, v5, v4);
        v5
    }

    entry fun place_bet_and_reveal_onchain_randomness<T0>(arg0: &mut PlinkoGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: u8, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = place_bet<T0>(arg0, arg1, arg2, arg3, arg4, arg6);
        reveal_bet<T0>(arg0, arg1, v0, arg5, arg6);
    }

    fun private_create_plinko_config_and_add_to_game<T0>(arg0: &mut PlinkoGame<T0>, arg1: u8, arg2: vector<0x1::uq32_32::UQ32_32>, arg3: u64, arg4: u64, arg5: bool, arg6: u8) {
        assert!(0x1::vector::length<0x1::uq32_32::UQ32_32>(&arg2) == (arg1 as u64) + 1, 11);
        let v0 = PlinkoConfig<T0>{
            num_rows    : arg1,
            multipliers : arg2,
            min_bet     : arg3,
            max_bet     : arg4,
            is_playable : arg5,
        };
        0x2::vec_map::insert<u8, PlinkoConfig<T0>>(&mut arg0.configs, arg6, v0);
    }

    fun private_initialize_plinko_configs<T0>(arg0: &mut PlinkoGame<T0>) {
        let v0 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v1, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v1, 0x1::uq32_32::from_quotient(3, 2));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v1, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v1, 0x1::uq32_32::from_quotient(1, 2));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v1, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v1, 0x1::uq32_32::from_quotient(3, 2));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v1, 0x1::uq32_32::from_quotient(4, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 6, v0, 100000000, 50000000000, true, 0);
        let v2 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v3, 0x1::uq32_32::from_quotient(6, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v3, 0x1::uq32_32::from_quotient(9, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v3, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v3, 0x1::uq32_32::from_quotient(2, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v3, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v3, 0x1::uq32_32::from_quotient(9, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v3, 0x1::uq32_32::from_quotient(6, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 6, v2, 100000000, 50000000000, true, 1);
        let v4 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v5, 0x1::uq32_32::from_quotient(8, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v5, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v5, 0x1::uq32_32::from_quotient(3, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v5, 0x1::uq32_32::from_quotient(1, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v5, 0x1::uq32_32::from_quotient(3, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v5, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v5, 0x1::uq32_32::from_quotient(8, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 6, v4, 100000000, 50000000000, false, 2);
        let v6 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(7, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(7, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v7, 0x1::uq32_32::from_quotient(5, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 7, v6, 100000000, 50000000000, true, 3);
        let v8 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(1, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(1, 2));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(1, 2));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(1, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v9, 0x1::uq32_32::from_quotient(10, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 7, v8, 100000000, 50000000000, true, 4);
        let v10 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(20, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(29, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(1, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(1, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(29, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v11, 0x1::uq32_32::from_quotient(20, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 7, v10, 100000000, 50000000000, false, 5);
        let v12 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(1, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(1, 2));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(1, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v13, 0x1::uq32_32::from_quotient(5, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 8, v12, 100000000, 50000000000, true, 6);
        let v14 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(11, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(2, 5));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v15, 0x1::uq32_32::from_quotient(11, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 8, v14, 100000000, 50000000000, true, 7);
        let v16 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v17 = &mut v16;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(26, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(15, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(15, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v17, 0x1::uq32_32::from_quotient(26, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 8, v16, 100000000, 50000000000, false, 8);
        let v18 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v19 = &mut v18;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(51, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(15, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(1, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(1, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(15, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v19, 0x1::uq32_32::from_quotient(51, 10));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 9, v18, 100000000, 50000000000, true, 9);
        let v20 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v21 = &mut v20;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(16, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(16, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(16, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v21, 0x1::uq32_32::from_quotient(16, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 9, v20, 100000000, 50000000000, true, 10);
        let v22 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v23 = &mut v22;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(45, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(6, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(6, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(6, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(6, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v23, 0x1::uq32_32::from_quotient(45, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 9, v22, 100000000, 50000000000, false, 11);
        let v24 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v25 = &mut v24;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(8, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v25, 0x1::uq32_32::from_quotient(8, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 10, v24, 100000000, 50000000000, true, 12);
        let v26 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v27 = &mut v26;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(20, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(6, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(4, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(6, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v27, 0x1::uq32_32::from_quotient(20, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 10, v26, 100000000, 50000000000, true, 13);
        let v28 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v29 = &mut v28;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(65, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v29, 0x1::uq32_32::from_quotient(65, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 10, v28, 100000000, 50000000000, false, 14);
        let v30 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v31 = &mut v30;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(84, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v31, 0x1::uq32_32::from_quotient(84, 10));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 11, v30, 100000000, 50000000000, true, 15);
        let v32 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v33 = &mut v32;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(24, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(17, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(17, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v33, 0x1::uq32_32::from_quotient(24, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 11, v32, 100000000, 50000000000, true, 16);
        let v34 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v35 = &mut v34;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(100, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(14, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(4, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(4, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(14, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v35, 0x1::uq32_32::from_quotient(100, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 11, v34, 100000000, 50000000000, false, 17);
        let v36 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v37 = &mut v36;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(9, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v37, 0x1::uq32_32::from_quotient(9, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 12, v36, 100000000, 50000000000, true, 18);
        let v38 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v39 = &mut v38;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(30, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(35, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(6, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(6, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(35, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v39, 0x1::uq32_32::from_quotient(30, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 12, v38, 100000000, 50000000000, true, 19);
        let v40 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v41 = &mut v40;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(150, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(20, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(8, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(8, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(20, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v41, 0x1::uq32_32::from_quotient(150, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 12, v40, 100000000, 50000000000, false, 20);
        let v42 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v43 = &mut v42;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(8, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(16, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(12, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(12, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(16, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v43, 0x1::uq32_32::from_quotient(8, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 13, v42, 100000000, 50000000000, false, 21);
        let v44 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v45 = &mut v44;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(40, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(4, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(4, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v45, 0x1::uq32_32::from_quotient(40, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 13, v44, 100000000, 50000000000, false, 22);
        let v46 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v47 = &mut v46;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(220, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(33, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(11, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(11, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(33, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v47, 0x1::uq32_32::from_quotient(220, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 13, v46, 100000000, 50000000000, false, 23);
        let v48 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v49 = &mut v48;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(7, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(16, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(14, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(16, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(4, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v49, 0x1::uq32_32::from_quotient(7, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 14, v48, 100000000, 50000000000, false, 24);
        let v50 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v51 = &mut v50;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(50, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v51, 0x1::uq32_32::from_quotient(50, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 14, v50, 100000000, 50000000000, false, 25);
        let v52 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v53 = &mut v52;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(400, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(50, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(17, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(50, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(19, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(19, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(50, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(17, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(50, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v53, 0x1::uq32_32::from_quotient(400, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 14, v52, 100000000, 50000000000, false, 26);
        let v54 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v55 = &mut v54;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(11, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(7, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(3, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v55, 0x1::uq32_32::from_quotient(11, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 15, v54, 100000000, 50000000000, false, 27);
        let v56 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v57 = &mut v56;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(80, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(15, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(12, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(12, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(15, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v57, 0x1::uq32_32::from_quotient(80, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 15, v56, 100000000, 50000000000, false, 28);
        let v58 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v59 = &mut v58;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(600, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(80, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(23, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(80, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(80, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(23, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(80, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v59, 0x1::uq32_32::from_quotient(600, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 15, v58, 100000000, 50000000000, false, 29);
        let v60 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v61 = &mut v60;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(12, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(12, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(9, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(11, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(12, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(2, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(5, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v61, 0x1::uq32_32::from_quotient(12, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 16, v60, 100000000, 50000000000, false, 30);
        let v62 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v63 = &mut v62;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(100, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(40, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(50, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(3, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(5, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(10, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(13, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(30, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(50, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(10, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(40, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v63, 0x1::uq32_32::from_quotient(100, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 16, v62, 100000000, 50000000000, false, 31);
        let v64 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v65 = &mut v64;
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(1000, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(110, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(20, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(90, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(2, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(20, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(40, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(90, 10));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(20, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(110, 1));
        0x1::vector::push_back<0x1::uq32_32::UQ32_32>(v65, 0x1::uq32_32::from_quotient(1000, 1));
        private_create_plinko_config_and_add_to_game<T0>(arg0, 16, v64, 100000000, 50000000000, false, 32);
    }

    fun reveal_bet<T0>(arg0: &mut PlinkoGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Bet<T0>>(&arg0.bets, &arg2), 7);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, Bet<T0>>(&mut arg0.bets, &arg2);
        let Bet {
            id                   : v2,
            gambler              : v3,
            number_of_balls      : v4,
            total_stake_value    : v5,
            fund                 : v6,
            plinko_config_number : v7,
        } = v1;
        let v8 = v7;
        let v9 = 0x2::vec_map::get<u8, PlinkoConfig<T0>>(&arg0.configs, &v8);
        let v10 = v9.multipliers;
        let v11 = v5 / (v4 as u64);
        let v12 = 0;
        let v13 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v14 = 0x1::vector::empty<u8>();
        let v15 = 0x1::vector::empty<u64>();
        let v16 = 0;
        while (v16 < v4) {
            let v17 = generate_ball_roll(v10, arg3, arg4);
            let v18 = *0x1::vector::borrow<0x1::uq32_32::UQ32_32>(&v10, (v17 as u64));
            let v19 = 0x1::uq32_32::int_mul(v11, v18);
            0x1::vector::push_back<0x1::uq32_32::UQ32_32>(&mut v13, v18);
            0x1::vector::push_back<u8>(&mut v14, v17);
            0x1::vector::push_back<u64>(&mut v15, v19);
            v12 = v12 + v19;
            v16 = v16 + 1;
        };
        let v20 = 0x2::coin::from_balance<T0>(v6, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v20, v12, arg4), v3);
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::deposit<T0>(arg1, v20);
        while (0x1::vector::length<0x1::uq32_32::UQ32_32>(&v13) > 0) {
            0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events::emit_plinko_revealed_event(arg2, v11, 0x1::vector::pop_back<0x1::uq32_32::UQ32_32>(&mut v13), 0x1::vector::pop_back<u8>(&mut v14), 0x1::vector::pop_back<u64>(&mut v15), v8, v9.num_rows, v3, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        };
        0x2::object::delete(v2);
    }

    entry fun reveal_bet_onchain_randomness<T0>(arg0: &mut PlinkoGame<T0>, arg1: &mut 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::Vault<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        reveal_bet<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_plinko_config_min_max_bet<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut PlinkoGame<T0>, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = 0x2::vec_map::get_mut<u8, PlinkoConfig<T0>>(&mut arg1.configs, &arg2);
        v0.min_bet = arg3;
        v0.max_bet = arg4;
    }

    public fun set_plinko_config_playable<T0>(arg0: &0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault::AdminCap, arg1: &mut PlinkoGame<T0>, arg2: u8, arg3: bool) {
        0x2::vec_map::get_mut<u8, PlinkoConfig<T0>>(&mut arg1.configs, &arg2).is_playable = arg3;
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

