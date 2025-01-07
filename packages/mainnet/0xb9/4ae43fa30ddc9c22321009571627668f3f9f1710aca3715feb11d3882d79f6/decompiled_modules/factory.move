module 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store {
        global: 0x2::object::ID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_x_type: 0x1::string::String,
        coin_x_decimals: u64,
        fee_coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        coin_y_type: 0x1::string::String,
        coin_y_decimals: u64,
        fee_coin_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
    }

    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        controller: address,
        beneficiary: address,
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
            let v10 = 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::sqrt(0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::mul_to_u128(v7, v8));
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
        assert!(0x2::balance::join<T0>(&mut arg0.coin_x, v2) < 18446744073709551615, 2);
        assert!(0x2::balance::join<T1>(&mut arg0.coin_y, v3) < 18446744073709551615, 2);
        let v13 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v13, v0);
        0x1::vector::push_back<u64>(&mut v13, v1);
        0x1::vector::push_back<u64>(&mut v13, v9);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v9), arg6), v13)
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
        let v0 = 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 4);
            return (arg0, v0)
        };
        let v1 = 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::mul_div(arg1, arg4, arg5);
        assert!(v1 <= arg0, 6);
        assert!(v1 >= arg2, 3);
        (v1, arg1)
    }

    public(friend) fun controller(arg0: &Global) : address {
        arg0.controller
    }

    public fun generate_hop_name<T0, T1, T2>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T2>())));
        v0
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
        let v0 = (arg0 as u128) * ((1000000 - 50) as u128);
        0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (1000000 as u128) + v0)
    }

    public fun get_fee_amount<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.fee_coin_x), 0x2::balance::value<T1>(&arg0.fee_coin_y))
    }

    public fun get_fee_to_fundation(arg0: u64) : u64 {
        0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::mul_div(arg0, 50 / 5, 1000000)
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

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<FACTORY>(arg0, arg1);
        let v0 = Global{
            id          : 0x2::object::new(arg1),
            has_paused  : false,
            controller  : @0xf46c7e2374133fad58e3a7e1d6e50dae53dfbdf18fd63bd3ddace178b93bb052,
            beneficiary : @0xf46c7e2374133fad58e3a7e1d6e50dae53dfbdf18fd63bd3ddace178b93bb052,
            pools       : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public(friend) fun is_emergency(arg0: &Global) : bool {
        arg0.has_paused
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::comparator::is_equal(&v2), 9);
        0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::comparator::is_smaller_than(&v2)
    }

    public fun one_hop_swap<T0, T1, T2>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64, u64, u64, u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, _, v3, _) = swap_out<T0, T1>(arg0, arg1, 0, is_order<T0, T1>(), arg3);
        let (v5, _, _, v8) = swap_out<T1, T2>(arg0, v1, arg2, is_order<T1, T2>(), arg3);
        let v9 = v5;
        (v9, v0, 0x2::coin::value<T2>(&v9), v3, v8)
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Global, arg1: u64, arg2: u64, arg3: bool) {
        assert!(arg3, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v2 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v2, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        let v3 = LP<T0, T1>{dummy_field: false};
        let v4 = Pool<T0, T1>{
            global          : 0x2::object::uid_to_inner(&arg0.id),
            coin_x          : 0x2::balance::zero<T0>(),
            coin_x_type     : v1,
            coin_x_decimals : arg1,
            fee_coin_x      : 0x2::balance::zero<T0>(),
            coin_y          : 0x2::balance::zero<T1>(),
            coin_y_type     : v2,
            coin_y_decimals : arg2,
            fee_coin_y      : 0x2::balance::zero<T1>(),
            lp_supply       : 0x2::balance::create_supply<LP<T0, T1>>(v3),
            min_liquidity   : 0x2::balance::zero<LP<T0, T1>>(),
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v4);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::mul_div(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, 0xb94ae43fa30ddc9c22321009571627668f3f9f1710aca3715feb11d3882d79f6::math::mul_div(v2, v0, v3), arg3))
    }

    public(friend) fun resume(arg0: &mut Global) {
        arg0.has_paused = false;
    }

    public fun swap_out<T0, T1>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, vector<u64>, u64, u64) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        if (arg3) {
            let v4 = get_mut_pool<T0, T1>(arg0, arg3);
            let (v5, v6, _) = get_reserves_size<T0, T1>(v4);
            assert!(v5 > 0 && v6 > 0, 1);
            let v8 = 0x2::coin::value<T0>(&arg1);
            let v9 = get_amount_out(v8, v5, v6);
            assert!(v9 >= arg2, 7);
            let v10 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v4.fee_coin_x, 0x2::balance::split<T0>(&mut v10, get_fee_to_fundation(v8)));
            0x2::balance::join<T0>(&mut v4.coin_x, v10);
            let (v11, v12, _) = get_reserves_size<T0, T1>(v4);
            assert_lp_value_is_increased(v5, v6, v11, v12);
            let v14 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v14, v8);
            0x1::vector::push_back<u64>(&mut v14, 0);
            0x1::vector::push_back<u64>(&mut v14, 0);
            0x1::vector::push_back<u64>(&mut v14, v9);
            (0x2::coin::take<T1>(&mut v4.coin_y, v9, arg4), v14, v4.coin_x_decimals, v4.coin_y_decimals)
        } else {
            let v15 = get_mut_pool<T1, T0>(arg0, !arg3);
            let (v16, v17, _) = get_reserves_size<T1, T0>(v15);
            assert!(v16 > 0 && v17 > 0, 1);
            let v19 = 0x2::coin::value<T0>(&arg1);
            let v20 = get_amount_out(v19, v17, v16);
            assert!(v20 >= arg2, 7);
            let v21 = 0x2::coin::into_balance<T0>(arg1);
            0x2::balance::join<T0>(&mut v15.fee_coin_y, 0x2::balance::split<T0>(&mut v21, get_fee_to_fundation(v19)));
            0x2::balance::join<T0>(&mut v15.coin_y, v21);
            let (v22, v23, _) = get_reserves_size<T1, T0>(v15);
            assert_lp_value_is_increased(v16, v17, v22, v23);
            let v25 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v25, 0);
            0x1::vector::push_back<u64>(&mut v25, v20);
            0x1::vector::push_back<u64>(&mut v25, v19);
            0x1::vector::push_back<u64>(&mut v25, 0);
            (0x2::coin::take<T1>(&mut v15.coin_x, v20, arg4), v25, v15.coin_x_decimals, v15.coin_y_decimals)
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

