module 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements {
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
        has_paused: bool,
        market_address: address,
        burn_address: address,
        free_ratio: u8,
        main_coin: 0x1::ascii::String,
    }

    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        controller: address,
        beneficiary: address,
        admin: address,
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
            let v10 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::sqrt(0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_to_u128(v7, v8));
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

    public fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 4);
            return (arg0, v0)
        };
        let v1 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(arg1, arg4, arg5);
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
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (10000 as u128) + v0)
    }

    public fun get_fee_amount<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.fee_coin_x), 0x2::balance::value<T1>(&arg0.fee_coin_y))
    }

    public fun get_fee_to_fundation(arg0: u64) : u64 {
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(arg0, 30 / 5, 10000)
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
            id          : 0x2::object::new(arg0),
            has_paused  : false,
            controller  : @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797,
            beneficiary : @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797,
            admin       : @0x5f5fdde75def86cf3449cd9f8e5b33d87d34bbd3080f892c1af185aec0bf3797,
            pools       : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public(friend) fun is_emergency(arg0: &Global) : bool {
        arg0.has_paused
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::comparator::is_equal(&v2), 9);
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::comparator::is_smaller_than(&v2)
    }

    public fun is_sui<T0>(arg0: vector<u8>) : bool {
        let v0 = 0x1::ascii::string(arg0);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::comparator::compare<0x1::ascii::String>(&v1, &v0);
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::comparator::is_equal(&v2)
    }

    public(friend) fun modify_admin(arg0: &mut Global, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun modify_controller(arg0: &mut Global, arg1: address) {
        arg0.controller = arg1;
    }

    public(friend) fun modify_pool_config<T0, T1>(arg0: &mut Global, arg1: bool, arg2: address, arg3: address, arg4: u8, arg5: 0x1::ascii::String) {
        let v0 = get_mut_pool<T0, T1>(arg0, is_order<T0, T1>());
        v0.has_paused = arg1;
        v0.market_address = arg2;
        v0.burn_address = arg3;
        v0.free_ratio = arg4;
        v0.main_coin = arg5;
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Global, arg1: bool) {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
        let v1 = LP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            global         : 0x2::object::uid_to_inner(&arg0.id),
            coin_x         : 0x2::balance::zero<T0>(),
            fee_coin_x     : 0x2::balance::zero<T0>(),
            coin_y         : 0x2::balance::zero<T1>(),
            fee_coin_y     : 0x2::balance::zero<T1>(),
            lp_supply      : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            min_liquidity  : 0x2::balance::zero<LP<T0, T1>>(),
            has_paused     : false,
            market_address : @0x0,
            burn_address   : @0x0,
            free_ratio     : 0,
            main_coin      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v2);
    }

    public(friend) fun removeX_scale_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(arg2, 12);
        if (arg1 >= 50 || arg1 <= 0) {
            abort 0
        };
        let (v0, _, _) = get_reserves_size<T0, T1>(arg0);
        assert!(v0 > 0, 0);
        let v3 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(v0, arg1, 100);
        assert!(v3 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_x, v3, arg3), arg0.burn_address);
        let (v4, _, _) = get_reserves_size<T0, T1>(arg0);
        let v7 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v7, v0);
        0x1::vector::push_back<u64>(&mut v7, v3);
        0x1::vector::push_back<u64>(&mut v7, v4);
        v7
    }

    public(friend) fun removeY_scale_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(arg2, 12);
        if (arg1 >= 100 || arg1 <= 0) {
            abort 0
        };
        let (_, v1, _) = get_reserves_size<T0, T1>(arg0);
        assert!(v1 > 0, 0);
        let v3 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(v1, arg1, 100);
        assert!(v3 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.coin_y, v3, arg3), arg0.burn_address);
        let (_, v5, _) = get_reserves_size<T0, T1>(arg0);
        let v7 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v7, v1);
        0x1::vector::push_back<u64>(&mut v7, v3);
        0x1::vector::push_back<u64>(&mut v7, v5);
        v7
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(v2, v0, v3), arg3))
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.has_paused = false;
    }

    public(friend) fun swap_out<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        if (arg3) {
            let v1 = get_mut_pool<T0, T1>(arg0, arg3);
            if (is_sui<T0>(0x1::ascii::into_bytes(v1.main_coin)) && v1.has_paused) {
                abort 16
            };
            let (v2, v3, _) = get_reserves_size<T0, T1>(v1);
            assert!(v2 > 0 && v3 > 0, 1);
            let v5 = 0x2::coin::value<T0>(&arg1);
            let v6 = get_amount_out(v5, v2, v3);
            assert!(v6 >= arg2, 7);
            let v7 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v1.fee_coin_x, 0x2::balance::split<T0>(&mut v7, get_fee_to_fundation(v5)));
            0x2::balance::join<T0>(&mut v1.coin_x, v7);
            let v8 = 0x2::coin::take<T1>(&mut v1.coin_y, v6, arg4);
            let v9 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(v6, (v1.free_ratio as u64), 100);
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v8, v9, arg4), v1.market_address);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, 0x2::tx_context::sender(arg4));
            let (v10, v11, _) = get_reserves_size<T0, T1>(v1);
            assert_lp_value_is_increased(v2, v3, v10, v11);
            let v13 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v13, v5);
            0x1::vector::push_back<u64>(&mut v13, 0);
            0x1::vector::push_back<u64>(&mut v13, 0);
            0x1::vector::push_back<u64>(&mut v13, v6 - v9);
            v13
        } else {
            let v14 = get_mut_pool<T1, T0>(arg0, !arg3);
            if (is_sui<T1>(0x1::ascii::into_bytes(v14.main_coin)) && v14.has_paused) {
                abort 16
            };
            let (v15, v16, _) = get_reserves_size<T1, T0>(v14);
            assert!(v15 > 0 && v16 > 0, 1);
            let v18 = 0x2::coin::value<T0>(&arg1);
            let v19 = get_amount_out(v18, v16, v15);
            assert!(v19 >= arg2, 7);
            let v20 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v14.fee_coin_y, 0x2::balance::split<T0>(&mut v20, get_fee_to_fundation(v18)));
            0x2::balance::join<T0>(&mut v14.coin_y, v20);
            let v21 = 0x2::coin::take<T1>(&mut v14.coin_x, v19, arg4);
            let v22 = 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::math::mul_div(v19, (v14.free_ratio as u64), 100);
            if (v22 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v21, v22, arg4), v14.market_address);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v21, 0x2::tx_context::sender(arg4));
            let (v23, v24, _) = get_reserves_size<T1, T0>(v14);
            assert_lp_value_is_increased(v15, v16, v23, v24);
            let v26 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v26, 0);
            0x1::vector::push_back<u64>(&mut v26, v19 - v22);
            0x1::vector::push_back<u64>(&mut v26, v18);
            0x1::vector::push_back<u64>(&mut v26, 0);
            v26
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

