module 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::amm {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store {
        global: 0x2::object::ID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        min_liquidity: 0x2::balance::Balance<LP<T0, T1>>,
    }

    struct AMMGlobal has key {
        id: 0x2::object::UID,
        admin: vector<address>,
        has_paused: bool,
        pools: 0x2::bag::Bag,
    }

    public entry fun swap<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 21);
        let v0 = swap_out<T0, T1>(arg0, arg1, arg2, is_order<T0, T1>(), arg3);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::swapped_event(id<T0, T1>(arg0), generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public entry fun add_admin(arg0: &mut AMMGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        assert!(!0x1::vector::contains<address>(&arg0.admin, &arg1), 18);
        0x1::vector::push_back<address>(&mut arg0.admin, arg1);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 21);
        let v0 = is_order<T0, T1>();
        if (!has_registered<T0, T1>(arg0)) {
            register_pool<T0, T1>(arg0, v0);
        };
        let v1 = get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = add_liquidity_non_entry<T0, T1>(v1, arg1, arg2, arg3, arg4, v0, arg5);
        let v4 = v3;
        assert!(0x1::vector::length<u64>(&v4) == 3, 23);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg5));
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::added_event(global_id<T0, T1>(v1), generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
    }

    public fun add_liquidity_non_entry<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        assert!(arg5, 12);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        let (v4, v5, v6) = get_reserves_size<T0, T1>(arg0);
        let (v7, v8) = calc_optimal_coin_values(v0, v1, arg2, arg4, v4, v5);
        let v9 = if (0 == v6) {
            let v10 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::sqrt(0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_to_u128(v7, v8));
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

    public fun balance_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.coin_x)
    }

    public fun balance_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.coin_y)
    }

    public fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(arg0, arg5, arg4);
        if (v0 <= arg1) {
            assert!(v0 >= arg3, 4);
            return (arg0, v0)
        };
        let v1 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(arg1, arg4, arg5);
        assert!(v1 <= arg0, 6);
        assert!(v1 >= arg2, 3);
        (v1, arg1)
    }

    fun check_admin(arg0: &AMMGlobal, arg1: address) {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admin, &arg1);
        assert!(v0, 16);
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
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div_u128((arg0 as u128), (arg2 as u128), (arg1 as u128) + (arg0 as u128))
    }

    public fun get_mut_pool<T0, T1>(arg0: &mut AMMGlobal, arg1: bool) : &mut Pool<T0, T1> {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 11);
        0x2::bag::borrow_mut<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0)
    }

    public fun get_mut_pool_for_testing<T0, T1>(arg0: &mut AMMGlobal) : &mut Pool<T0, T1> {
        get_mut_pool<T0, T1>(arg0, is_order<T0, T1>())
    }

    public fun get_reserves_size<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x), 0x2::balance::value<T1>(&arg0.coin_y), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun global_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.global
    }

    public fun has_registered<T0, T1>(arg0: &AMMGlobal) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    public fun id<T0, T1>(arg0: &AMMGlobal) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = AMMGlobal{
            id         : 0x2::object::new(arg0),
            admin      : v0,
            has_paused : false,
            pools      : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<AMMGlobal>(v1);
    }

    public fun is_emergency(arg0: &AMMGlobal) : bool {
        arg0.has_paused
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::comparator::is_equal(&v2), 9);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::comparator::is_smaller_than(&v2)
    }

    public entry fun multi_add_liquidity<T0, T1>(arg0: &mut AMMGlobal, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 21);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1) && !0x1::vector::is_empty<0x2::coin::Coin<T1>>(&arg4), 24);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg7);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg4);
        0x2::pay::join_vec<T1>(&mut v2, arg4);
        let v3 = 0x2::coin::split<T1>(&mut v2, arg5, arg7);
        add_liquidity<T0, T1>(arg0, v1, arg3, v3, arg6, arg7);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public entry fun multi_remove_liquidity<T0, T1>(arg0: &mut AMMGlobal, arg1: vector<0x2::coin::Coin<LP<T0, T1>>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 21);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<LP<T0, T1>>>(&arg1), 24);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<LP<T0, T1>>>(&mut arg1);
        0x2::pay::join_vec<LP<T0, T1>>(&mut v0, arg1);
        remove_liquidity<T0, T1>(arg0, v0, arg2);
    }

    public entry fun multi_swap<T0, T1>(arg0: &mut AMMGlobal, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 21);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1), 24);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg4);
        swap<T0, T1>(arg0, v1, arg3, arg4);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public entry fun pause(arg0: &mut AMMGlobal, arg1: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg1));
        arg0.has_paused = true;
    }

    public fun register_pool<T0, T1>(arg0: &mut AMMGlobal, arg1: bool) {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
        let v1 = LP<T0, T1>{dummy_field: false};
        let v2 = Pool<T0, T1>{
            global        : 0x2::object::uid_to_inner(&arg0.id),
            coin_x        : 0x2::balance::zero<T0>(),
            coin_y        : 0x2::balance::zero<T1>(),
            lp_supply     : 0x2::balance::create_supply<LP<T0, T1>>(v1),
            min_liquidity : 0x2::balance::zero<LP<T0, T1>>(),
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v2);
    }

    public entry fun remove_admin(arg0: &mut AMMGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admin, &arg1);
        assert!(v0, 19);
        0x1::vector::remove<address>(&mut arg0.admin, v1);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 21);
        let v0 = is_order<T0, T1>();
        let v1 = get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = remove_liquidity_non_entry<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::removed_event(global_id<T0, T1>(v1), generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<LP<T0, T1>>(&arg1));
    }

    public fun remove_liquidity_non_entry<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::math::mul_div(v2, v0, v3), arg3))
    }

    public entry fun resume(arg0: &mut AMMGlobal, arg1: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, 0x2::tx_context::sender(arg1));
        arg0.has_paused = false;
    }

    public fun swap_out<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        if (arg3) {
            let v1 = get_mut_pool<T0, T1>(arg0, arg3);
            let (v2, v3, _) = get_reserves_size<T0, T1>(v1);
            assert!(v2 > 0 && v3 > 0, 1);
            let v5 = 0x2::coin::value<T0>(&arg1);
            let v6 = get_amount_out(v5, v2, v3);
            assert!(v6 >= arg2, 7);
            0x2::balance::join<T0>(&mut v1.coin_x, 0x2::coin::into_balance<T0>(arg1));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v1.coin_y, v6, arg4), 0x2::tx_context::sender(arg4));
            let (v7, v8, _) = get_reserves_size<T0, T1>(v1);
            assert_lp_value_is_increased(v2, v3, v7, v8);
            let v10 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v10, v5);
            0x1::vector::push_back<u64>(&mut v10, 0);
            0x1::vector::push_back<u64>(&mut v10, 0);
            0x1::vector::push_back<u64>(&mut v10, v6);
            v10
        } else {
            let v11 = get_mut_pool<T1, T0>(arg0, !arg3);
            let (v12, v13, _) = get_reserves_size<T1, T0>(v11);
            assert!(v12 > 0 && v13 > 0, 1);
            let v15 = 0x2::coin::value<T0>(&arg1);
            let v16 = get_amount_out(v15, v13, v12);
            assert!(v16 >= arg2, 7);
            0x2::balance::join<T0>(&mut v11.coin_y, 0x2::coin::into_balance<T0>(arg1));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v11.coin_x, v16, arg4), 0x2::tx_context::sender(arg4));
            let (v17, v18, _) = get_reserves_size<T1, T0>(v11);
            assert_lp_value_is_increased(v12, v13, v17, v18);
            let v20 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v20, 0);
            0x1::vector::push_back<u64>(&mut v20, v16);
            0x1::vector::push_back<u64>(&mut v20, v15);
            0x1::vector::push_back<u64>(&mut v20, 0);
            v20
        }
    }

    public fun swap_out_for_coin<T0, T1>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
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

    public entry fun swap_xyz<T0, T1, T2>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_emergency(arg0), 21);
        let v0 = swap_xyz_non_entry<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::event::swapped_event(id<T0, T2>(arg0), generate_lp_name<T0, T2>(), 0x2::coin::value<T0>(&arg1), 0, 0, v0);
    }

    public fun swap_xyz_non_entry<T0, T1, T2>(arg0: &mut AMMGlobal, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = swap_out_for_coin<T0, T1>(arg0, arg1, 1, is_order<T0, T1>(), arg3);
        let v1 = swap_out_for_coin<T1, T2>(arg0, v0, arg2, is_order<T1, T2>(), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg3));
        0x2::coin::value<T2>(&v1)
    }

    // decompiled from Move bytecode v6
}

