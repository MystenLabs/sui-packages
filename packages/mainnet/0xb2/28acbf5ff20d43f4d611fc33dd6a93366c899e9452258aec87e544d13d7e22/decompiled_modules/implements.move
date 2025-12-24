module 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::implements {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store {
        global: 0x2::object::ID,
        coin_x: 0x2::balance::Balance<T0>,
        fee_coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        fee_coin_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
        sell_paused: bool,
        buy_paused: bool,
        market_address: address,
        burn_address: address,
        rebot: address,
        last_burn_time: u64,
        sell_tax: u8,
        buy_tax: u8,
        tax_coin: 0x1::ascii::String,
    }

    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        controller: address,
        beneficiary: address,
        admin: address,
        pool_fee: u64,
        burn_amount: u64,
        register_flag: bool,
        register_white_list: vector<address>,
        pools: 0x2::bag::Bag,
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        assert!(arg5, 12);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        let (v4, v5, v6) = get_reserves_size<T0, T1>(arg0);
        let (v7, v8) = calc_optimal_coin_values(v0, v1, arg2, arg4, v4, v5);
        let v9 = if (0 == v6) {
            let v10 = 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::sqrt(0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_to_u128(v7, v8));
            assert!(v10 > 1000, 8);
            0x2::balance::join<LP<T0, T1>>(&mut arg0.min_liquidity, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 1000));
            v10 - 1000
        } else {
            let v11 = (v6 as u128) * (v7 as u128) / (v4 as u128);
            let v12 = (v6 as u128) * (v8 as u128) / (v5 as u128);
            if (v11 < v12) {
                assert!(v11 < (18446744073709551615 as u128), 13);
                (v11 as u64)
            } else {
                assert!(v12 < (18446744073709551615 as u128), 13);
                (v12 as u64)
            }
        };
        assert!(v9 > 0, 15);
        if (v7 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0 - v7), arg6), 0x2::tx_context::sender(arg6));
        };
        if (v8 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v1 - v8), arg6), 0x2::tx_context::sender(arg6));
        };
        assert!(0x2::balance::join<T0>(&mut arg0.coin_x, v2) < 1844674407370955, 2);
        assert!(0x2::balance::join<T1>(&mut arg0.coin_y, v3) < 1844674407370955, 2);
        let v13 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v13, v0);
        0x1::vector::push_back<u64>(&mut v13, v1);
        0x1::vector::push_back<u64>(&mut v13, v7);
        0x1::vector::push_back<u64>(&mut v13, v8);
        0x1::vector::push_back<u64>(&mut v13, v9);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v9), arg6), v13)
    }

    public(friend) fun admin(arg0: &Global) : address {
        arg0.admin
    }

    public fun assert_lp_value_is_increased(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) < (arg2 as u128) * (arg3 as u128), 14);
    }

    public(friend) fun beneficiary(arg0: &Global) : address {
        arg0.beneficiary
    }

    public(friend) fun burn_amount(arg0: &Global) : u64 {
        arg0.burn_amount
    }

    public fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 4);
            return (arg0, v0)
        };
        let v1 = 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div(arg1, arg4, arg5);
        assert!(v1 <= arg0, 6);
        assert!(v1 >= arg2, 3);
        (v1, arg1)
    }

    public(friend) fun controller(arg0: &Global) : address {
        arg0.controller
    }

    public fun generate_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"LP-");
        if (is_order<T0, T1>()) {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        } else {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        };
        v0
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * ((10000 - 30) as u128);
        0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (10000 as u128) + v0)
    }

    public fun get_fee_amount<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.fee_coin_x), 0x2::balance::value<T1>(&arg0.fee_coin_y))
    }

    public fun get_fee_to_fundation(arg0: u64, arg1: u64) : u64 {
        0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div(arg0, arg1, 10000)
    }

    public(friend) fun get_mut_pool<T0, T1>(arg0: &mut Global, arg1: bool) : &mut Pool<T0, T1> {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 11);
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0)
    }

    public fun get_reserves_size<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x), 0x2::balance::value<T1>(&arg0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun get_swap_out<T0, T1>(arg0: &mut Global, arg1: u64, arg2: bool) : u64 {
        let v0 = arg1;
        if (arg2) {
            let v2 = get_mut_pool<T0, T1>(arg0, arg2);
            let v3 = is_tax_coin<T0>(0x1::ascii::into_bytes(v2.tax_coin));
            let (v4, v5, _) = get_reserves_size<T0, T1>(v2);
            assert!(v4 > 0 && v5 > 0, 1);
            if (v3) {
                v0 = arg1 - arg1 * (v2.buy_tax as u64) / 100;
            };
            let v7 = get_amount_out(v0, v4, v5);
            let v8 = v7;
            if (!v3) {
                v8 = v7 - v7 * (v2.sell_tax as u64) / 100;
            };
            v8
        } else {
            let v9 = get_mut_pool<T1, T0>(arg0, !arg2);
            let v10 = is_tax_coin<T0>(0x1::ascii::into_bytes(v9.tax_coin));
            let (v11, v12, _) = get_reserves_size<T1, T0>(v9);
            if (v10) {
                v0 = arg1 - 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div(arg1, (v9.buy_tax as u64), 100);
            };
            let v14 = get_amount_out(v0, v12, v11);
            let v15 = v14;
            if (!v10) {
                v15 = v14 - v14 * (v9.sell_tax as u64) / 100;
            };
            v15
        }
    }

    public fun global_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.global
    }

    public(friend) fun has_registered<T0, T1>(arg0: &Global) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    public(friend) fun id<T0, T1>(arg0: &Global) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                  : 0x2::object::new(arg0),
            has_paused          : false,
            controller          : @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45,
            beneficiary         : @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45,
            admin               : @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45,
            pool_fee            : 30,
            burn_amount         : 5000000000000,
            register_flag       : false,
            register_white_list : 0x1::vector::empty<address>(),
            pools               : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun is_create_pool(arg0: &Global, arg1: &address) : bool {
        arg0.register_flag == false && !0x1::vector::contains<address>(&arg0.register_white_list, arg1) && false || true
    }

    public(friend) fun is_emergency(arg0: &Global) : bool {
        arg0.has_paused
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::comparator::is_equal(&v2), 9);
        0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::comparator::is_smaller_than(&v2)
    }

    public fun is_sui<T0>() : bool {
        let v0 = 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI");
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::comparator::compare<0x1::ascii::String>(&v1, &v0);
        0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::comparator::is_equal(&v2)
    }

    public fun is_tax_coin<T0>(arg0: vector<u8>) : bool {
        let v0 = 0x1::ascii::string(arg0);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::comparator::compare<0x1::ascii::String>(&v1, &v0);
        0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::comparator::is_equal(&v2)
    }

    public(friend) fun modify_add_register(arg0: &mut Global, arg1: address) {
        let v0 = &mut arg0.register_white_list;
        if (!0x1::vector::contains<address>(v0, &arg1)) {
            0x1::vector::push_back<address>(v0, arg1);
        };
    }

    public(friend) fun modify_admin(arg0: &mut Global, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun modify_burn_amount(arg0: &mut Global, arg1: u64) {
        arg0.burn_amount = arg1;
    }

    public(friend) fun modify_controller(arg0: &mut Global, arg1: address) {
        arg0.controller = arg1;
    }

    public(friend) fun modify_last_time<T0, T1>(arg0: &mut Global, arg1: u64) {
        get_mut_pool<T0, T1>(arg0, is_order<T0, T1>()).last_burn_time = arg1;
    }

    public(friend) fun modify_pool_config<T0, T1>(arg0: &mut Global, arg1: address, arg2: address, arg3: 0x1::ascii::String) {
        let v0 = get_mut_pool<T0, T1>(arg0, is_order<T0, T1>());
        v0.market_address = arg1;
        v0.burn_address = arg2;
        v0.tax_coin = arg3;
    }

    public(friend) fun modify_pool_fee(arg0: &mut Global, arg1: u64) {
        arg0.pool_fee = arg1;
    }

    public(friend) fun modify_rebot_addr<T0, T1>(arg0: &mut Global, arg1: address) {
        get_mut_pool<T0, T1>(arg0, is_order<T0, T1>()).rebot = arg1;
    }

    public(friend) fun modify_register_flag(arg0: &mut Global, arg1: bool) {
        arg0.register_flag = arg1;
    }

    public(friend) fun modify_remove_register(arg0: &mut Global, arg1: address) {
        let v0 = &mut arg0.register_white_list;
        assert!(!0x1::vector::is_empty<address>(v0), 1);
        let (_, v2) = 0x1::vector::index_of<address>(v0, &arg1);
        0x1::vector::remove<address>(v0, v2);
    }

    public(friend) fun modify_switch_config<T0, T1>(arg0: &mut Global, arg1: bool, arg2: bool) {
        let v0 = get_mut_pool<T0, T1>(arg0, is_order<T0, T1>());
        v0.sell_paused = arg1;
        v0.buy_paused = arg2;
    }

    public(friend) fun modify_tax_config<T0, T1>(arg0: &mut Global, arg1: u8, arg2: u8) {
        let v0 = get_mut_pool<T0, T1>(arg0, is_order<T0, T1>());
        v0.sell_tax = arg1;
        v0.buy_tax = arg2;
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Global, arg1: bool) {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
        let v1 = if (!is_sui<T0>()) {
            0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
        } else {
            0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())
        };
        let v2 = LP<T0, T1>{dummy_field: false};
        let v3 = Pool<T0, T1>{
            global         : 0x2::object::uid_to_inner(&arg0.id),
            coin_x         : 0x2::balance::zero<T0>(),
            fee_coin_x     : 0x2::balance::zero<T0>(),
            coin_y         : 0x2::balance::zero<T1>(),
            fee_coin_y     : 0x2::balance::zero<T1>(),
            lp_supply      : 0x2::balance::create_supply<LP<T0, T1>>(v2),
            min_liquidity  : 0x2::balance::zero<LP<T0, T1>>(),
            sell_paused    : true,
            buy_paused     : true,
            market_address : @0x0,
            burn_address   : @0x0,
            rebot          : @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45,
            last_burn_time : 1733913322000,
            sell_tax       : 5,
            buy_tax        : 0,
            tax_coin       : v1,
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v3);
    }

    public(friend) fun removeYY<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::tx_context::sender(arg3) == arg0.rebot, 12);
        assert!(arg1 > 0, 12);
        assert!(!is_sui<T0>(), 17);
        assert!((0x2::clock::timestamp_ms(arg2) - arg0.last_burn_time) / 82800000 > 0, 18);
        arg0.last_burn_time = 0x2::clock::timestamp_ms(arg2);
        let (v0, _, _) = get_reserves_size<T0, T1>(arg0);
        assert!(v0 > arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_x, arg1, arg3), arg0.burn_address);
        let (v3, _, _) = get_reserves_size<T0, T1>(arg0);
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, v0);
        0x1::vector::push_back<u64>(&mut v6, arg1);
        0x1::vector::push_back<u64>(&mut v6, v3);
        v6
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div(v2, v0, v3), arg3))
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.has_paused = false;
    }

    public(friend) fun swapCoin<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        if (arg3) {
            let v1 = get_mut_pool<T0, T1>(arg0, arg3);
            let (v2, v3, _) = get_reserves_size<T0, T1>(v1);
            assert!(v2 > 0 && v3 > 0, 1);
            let v5 = get_amount_out(0x2::coin::value<T0>(&arg1), v2, v3);
            assert!(v5 >= arg2, 7);
            0x2::balance::join<T0>(&mut v1.coin_x, 0x2::coin::into_balance<T0>(arg1));
            let (v6, v7, _) = get_reserves_size<T0, T1>(v1);
            assert_lp_value_is_increased(v2, v3, v6, v7);
            0x2::coin::take<T1>(&mut v1.coin_y, v5, arg4)
        } else {
            let v9 = get_mut_pool<T1, T0>(arg0, !arg3);
            let (v10, v11, _) = get_reserves_size<T1, T0>(v9);
            assert!(v10 > 0 && v11 > 0, 1);
            let v13 = get_amount_out(0x2::coin::value<T0>(&arg1), v11, v10);
            assert!(v13 >= arg2, 7);
            0x2::balance::join<T0>(&mut v9.coin_y, 0x2::coin::into_balance<T0>(arg1));
            let (v14, v15, _) = get_reserves_size<T1, T0>(v9);
            assert_lp_value_is_increased(v10, v11, v14, v15);
            0x2::coin::take<T1>(&mut v9.coin_x, v13, arg4)
        }
    }

    public(friend) fun swap_out<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        if (arg3) {
            let v1 = get_mut_pool<T0, T1>(arg0, arg3);
            let v2 = is_tax_coin<T0>(0x1::ascii::into_bytes(v1.tax_coin));
            if (v2 && v1.buy_paused) {
                abort 19
            };
            if (!v2 && v1.sell_paused) {
                abort 20
            };
            let (v3, v4, _) = get_reserves_size<T0, T1>(v1);
            assert!(v3 > 0 && v4 > 0, 1);
            let v6 = 0x2::coin::value<T0>(&arg1);
            let v7 = v6;
            let v8 = 0x2::coin::into_balance<T0>(arg1);
            if (v2) {
                let v9 = v6 * (v1.buy_tax as u64) / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v8, v9, arg4), v1.market_address);
                v7 = v6 - v9;
            };
            let v10 = get_amount_out(v7, v3, v4);
            let v11 = v10;
            if (!v2) {
                let v12 = v10 * (v1.sell_tax as u64) / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v1.coin_y, v12, arg4), v1.market_address);
                v11 = v10 - v12;
            };
            assert!(v11 >= arg2, 7);
            0x2::balance::join<T0>(&mut v1.coin_x, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v1.coin_y, v11, arg4), 0x2::tx_context::sender(arg4));
            let (v13, v14, _) = get_reserves_size<T0, T1>(v1);
            assert_lp_value_is_increased(v3, v4, v13, v14);
            let v16 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v16, v7);
            0x1::vector::push_back<u64>(&mut v16, 0);
            0x1::vector::push_back<u64>(&mut v16, 0);
            0x1::vector::push_back<u64>(&mut v16, v11);
            v16
        } else {
            let v17 = get_mut_pool<T1, T0>(arg0, !arg3);
            let v18 = is_tax_coin<T0>(0x1::ascii::into_bytes(v17.tax_coin));
            if (v18 && v17.buy_paused) {
                abort 19
            };
            if (!v18 && v17.sell_paused) {
                abort 20
            };
            let (v19, v20, _) = get_reserves_size<T1, T0>(v17);
            assert!(v19 > 0 && v20 > 0, 1);
            let v22 = 0x2::coin::value<T0>(&arg1);
            let v23 = v22;
            let v24 = 0x2::coin::into_balance<T0>(arg1);
            if (v18) {
                let v25 = 0xb228acbf5ff20d43f4d611fc33dd6a93366c899e9452258aec87e544d13d7e22::math::mul_div(v22, (v17.buy_tax as u64), 100);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v24, v25, arg4), v17.market_address);
                v23 = v22 - v25;
            };
            let v26 = get_amount_out(v23, v20, v19);
            let v27 = v26;
            if (!v18) {
                let v28 = v26 * (v17.sell_tax as u64) / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v17.coin_x, v28, arg4), v17.market_address);
                v27 = v26 - v28;
            };
            assert!(v27 >= arg2, 7);
            0x2::balance::join<T0>(&mut v17.coin_y, v24);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v17.coin_x, v27, arg4), 0x2::tx_context::sender(arg4));
            let (v29, v30, _) = get_reserves_size<T1, T0>(v17);
            assert_lp_value_is_increased(v19, v20, v29, v30);
            let v32 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v32, 0);
            0x1::vector::push_back<u64>(&mut v32, v27);
            0x1::vector::push_back<u64>(&mut v32, v23);
            0x1::vector::push_back<u64>(&mut v32, 0);
            v32
        }
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.fee_coin_x);
        let v1 = 0x2::balance::value<T1>(&arg0.fee_coin_y);
        assert!(v0 > 0 && v1 > 0, 0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_coin_x, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_coin_y, v1), arg1), v0, v1)
    }

    // decompiled from Move bytecode v6
}

