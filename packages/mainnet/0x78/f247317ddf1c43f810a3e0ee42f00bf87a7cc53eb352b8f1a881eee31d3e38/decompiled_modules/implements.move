module 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::implements {
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
        rebot: address,
        swap_caller: address,
        sell_tax: u8,
        buy_tax: u8,
        white_list: 0x2::vec_set::VecSet<address>,
        tax_coin: 0x1::ascii::String,
    }

    struct Global has key {
        id: 0x2::object::UID,
        has_paused: bool,
        controller: address,
        black_list: 0x2::vec_set::VecSet<address>,
        version: u64,
        pools: 0x2::bag::Bag,
    }

    struct SwapCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_black_list(arg0: &mut Global, arg1: address) {
        if (!0x2::vec_set::contains<address>(&arg0.black_list, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.black_list, arg1);
        };
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
            let v10 = 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::sqrt(0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_to_u128(v7, v8));
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
        let v13 = vector[];
        0x1::vector::push_back<u64>(&mut v13, v0);
        0x1::vector::push_back<u64>(&mut v13, v1);
        0x1::vector::push_back<u64>(&mut v13, v7);
        0x1::vector::push_back<u64>(&mut v13, v8);
        0x1::vector::push_back<u64>(&mut v13, v9);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v9), arg6), v13)
    }

    public(friend) fun add_white_list<T0, T1>(arg0: &mut Global, arg1: address) {
        if (is_order<T0, T1>()) {
            let v0 = get_mut_pool<T0, T1>(arg0, true);
            if (!0x2::vec_set::contains<address>(&v0.white_list, &arg1)) {
                0x2::vec_set::insert<address>(&mut v0.white_list, arg1);
            };
        } else {
            let v1 = get_mut_pool<T1, T0>(arg0, true);
            if (!0x2::vec_set::contains<address>(&v1.white_list, &arg1)) {
                0x2::vec_set::insert<address>(&mut v1.white_list, arg1);
            };
        };
    }

    public fun assert_lp_value_is_increased(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) < (arg2 as u128) * (arg3 as u128), 14);
    }

    fun calc_optimal_coin_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0 && arg5 == 0) {
            (arg0, arg1)
        } else {
            let v2 = 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div(arg0, arg5, arg4);
            if (v2 <= arg1) {
                assert!(v2 >= arg3, 4);
                (arg0, v2)
            } else {
                let v3 = 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div(arg1, arg4, arg5);
                assert!(v3 <= arg0, 6);
                assert!(v3 >= arg2, 3);
                (v3, arg1)
            }
        }
    }

    public(friend) fun controller(arg0: &Global) : address {
        arg0.controller
    }

    public(friend) fun create_swap_cap(arg0: &mut 0x2::tx_context::TxContext) : SwapCap {
        SwapCap{id: 0x2::object::new(arg0)}
    }

    public fun generate_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"LP-");
        if (is_order<T0, T1>()) {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())));
        } else {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        };
        v0
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * ((10000 - 30) as u128);
        0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div_u128(v0, (arg2 as u128), (arg1 as u128) * (10000 as u128) + v0)
    }

    public fun get_fee_amount<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.fee_coin_x), 0x2::balance::value<T1>(&arg0.fee_coin_y))
    }

    public fun get_fee_to_fundation(arg0: u64, arg1: u64) : u64 {
        0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div(arg0, arg1, 10000)
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
            assert!(v11 > 0 && v12 > 0, 1);
            if (v10) {
                v0 = arg1 - 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div(arg1, (v9.buy_tax as u64), 100);
            };
            let v14 = get_amount_out(v0, v12, v11);
            let v15 = v14;
            if (!v10) {
                v15 = v14 - v14 * (v9.sell_tax as u64) / 100;
            };
            v15
        }
    }

    public(friend) fun get_switch_config<T0, T1>(arg0: &mut Global) : (bool, bool) {
        if (is_order<T0, T1>()) {
            let v2 = get_mut_pool<T0, T1>(arg0, true);
            (v2.buy_paused, v2.sell_paused)
        } else {
            let v3 = get_mut_pool<T1, T0>(arg0, true);
            (v3.buy_paused, v3.sell_paused)
        }
    }

    public(friend) fun get_tax_config<T0, T1>(arg0: &mut Global) : (u8, u8) {
        if (is_order<T0, T1>()) {
            let v2 = get_mut_pool<T0, T1>(arg0, true);
            (v2.buy_tax, v2.sell_tax)
        } else {
            let v3 = get_mut_pool<T1, T0>(arg0, true);
            (v3.buy_tax, v3.sell_tax)
        }
    }

    public fun get_version(arg0: &Global) : u64 {
        arg0.version
    }

    public(friend) fun get_white_list<T0, T1>(arg0: &mut Global) : vector<address> {
        if (is_order<T0, T1>()) {
            *0x2::vec_set::keys<address>(&get_mut_pool<T0, T1>(arg0, true).white_list)
        } else {
            *0x2::vec_set::keys<address>(&get_mut_pool<T1, T0>(arg0, true).white_list)
        }
    }

    public fun global_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        arg0.global
    }

    public(friend) fun has_registered<T0, T1>(arg0: &Global) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, generate_lp_name<T0, T1>())
    }

    public(friend) fun id(arg0: &Global) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id         : 0x2::object::new(arg0),
            has_paused : false,
            controller : @0x7e98f1333ac573ba5dd795fa54528ab99e6b9d9086c07276d12df0bb20866d9a,
            black_list : 0x2::vec_set::empty<address>(),
            version    : 1,
            pools      : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
        let v1 = create_swap_cap(arg0);
        0x2::transfer::public_transfer<SwapCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_emergency(arg0: &Global) : bool {
        arg0.has_paused
    }

    public(friend) fun is_in_black_list(arg0: &Global, arg1: &address) : bool {
        0x2::vec_set::contains<address>(&arg0.black_list, arg1)
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::comparator::compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::comparator::is_equal(&v2), 9);
        0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::comparator::is_smaller_than(&v2)
    }

    public fun is_sui<T0>() : bool {
        let v0 = 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI");
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::comparator::compare<0x1::ascii::String>(&v1, &v0);
        0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::comparator::is_equal(&v2)
    }

    public fun is_tax_coin<T0>(arg0: vector<u8>) : bool {
        let v0 = 0x1::ascii::string(arg0);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v2 = 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::comparator::compare<0x1::ascii::String>(&v1, &v0);
        0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::comparator::is_equal(&v2)
    }

    public(friend) fun modify_buy_tax<T0, T1>(arg0: &mut Global, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.controller, 21);
        assert!(arg1 <= 100, 24);
        if (is_order<T0, T1>()) {
            get_mut_pool<T0, T1>(arg0, true).buy_tax = arg1;
        } else {
            get_mut_pool<T1, T0>(arg0, true).buy_tax = arg1;
        };
    }

    public(friend) fun modify_controller(arg0: &mut Global, arg1: address) {
        arg0.controller = arg1;
    }

    public(friend) fun modify_pool_config<T0, T1>(arg0: &mut Global, arg1: address, arg2: 0x1::ascii::String) {
        if (is_order<T0, T1>()) {
            let v0 = get_mut_pool<T0, T1>(arg0, true);
            v0.market_address = arg1;
            v0.tax_coin = arg2;
        } else {
            let v1 = get_mut_pool<T1, T0>(arg0, true);
            v1.market_address = arg1;
            v1.tax_coin = arg2;
        };
    }

    public(friend) fun modify_rebot_addr<T0, T1>(arg0: &mut Global, arg1: address) {
        if (is_order<T0, T1>()) {
            get_mut_pool<T0, T1>(arg0, true).rebot = arg1;
        } else {
            get_mut_pool<T1, T0>(arg0, true).rebot = arg1;
        };
    }

    public(friend) fun modify_sell_tax<T0, T1>(arg0: &mut Global, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.controller;
        assert!(arg1 <= 100, 24);
        if (is_order<T0, T1>()) {
            let v2 = get_mut_pool<T0, T1>(arg0, true);
            assert!(v0 == v2.rebot || v0 == v1, 21);
            v2.sell_tax = arg1;
        } else {
            let v3 = get_mut_pool<T1, T0>(arg0, true);
            assert!(v0 == v3.rebot || v0 == v1, 21);
            v3.sell_tax = arg1;
        };
    }

    public(friend) fun modify_swap_caller<T0, T1>(arg0: &mut Global, arg1: address) {
        if (is_order<T0, T1>()) {
            get_mut_pool<T0, T1>(arg0, true).swap_caller = arg1;
        } else {
            get_mut_pool<T1, T0>(arg0, true).swap_caller = arg1;
        };
    }

    public(friend) fun modify_switch_config<T0, T1>(arg0: &mut Global, arg1: bool, arg2: bool) {
        if (is_order<T0, T1>()) {
            let v0 = get_mut_pool<T0, T1>(arg0, true);
            v0.buy_paused = arg1;
            v0.sell_paused = arg2;
        } else {
            let v1 = get_mut_pool<T1, T0>(arg0, true);
            v1.buy_paused = arg1;
            v1.sell_paused = arg2;
        };
    }

    public(friend) fun pause(arg0: &mut Global) {
        arg0.has_paused = true;
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Global, arg1: bool) {
        assert!(arg1, 12);
        let v0 = generate_lp_name<T0, T1>();
        assert!(!0x2::bag::contains_with_type<0x1::string::String, Pool<T0, T1>>(&arg0.pools, v0), 10);
        let v1 = if (is_sui<T0>()) {
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
            sell_paused    : false,
            buy_paused     : false,
            market_address : @0x7e98f1333ac573ba5dd795fa54528ab99e6b9d9086c07276d12df0bb20866d9a,
            rebot          : @0xc9ad15e938d818c55c1961a66ff05533166fbcc3801ca9eeba565ffaabd88c7f,
            swap_caller    : @0xed32c207b585e6861bb7b75ee3ea491d61e0e8c9034d3b1fab24aafc994c61ca,
            sell_tax       : 10,
            buy_tax        : 0,
            white_list     : 0x2::vec_set::empty<address>(),
            tax_coin       : v1,
        };
        0x2::bag::add<0x1::string::String, Pool<T0, T1>>(&mut arg0.pools, v0, v3);
    }

    public(friend) fun remove_black_list(arg0: &mut Global, arg1: address) {
        if (0x2::vec_set::contains<address>(&arg0.black_list, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.black_list, &arg1);
        };
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2, 12);
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_reserves_size<T0, T1>(arg0);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div(v1, v0, v3), arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div(v2, v0, v3), arg3))
    }

    public(friend) fun remove_white_list<T0, T1>(arg0: &mut Global, arg1: address) {
        if (is_order<T0, T1>()) {
            let v0 = get_mut_pool<T0, T1>(arg0, true);
            if (0x2::vec_set::contains<address>(&v0.white_list, &arg1)) {
                0x2::vec_set::remove<address>(&mut v0.white_list, &arg1);
            };
        } else {
            let v1 = get_mut_pool<T1, T0>(arg0, true);
            if (0x2::vec_set::contains<address>(&v1.white_list, &arg1)) {
                0x2::vec_set::remove<address>(&mut v1.white_list, &arg1);
            };
        };
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
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_set::contains<address>(&arg0.black_list, &v0), 22);
        if (arg3) {
            let v2 = get_mut_pool<T0, T1>(arg0, arg3);
            let v3 = is_tax_coin<T0>(0x1::ascii::into_bytes(v2.tax_coin));
            let v4 = 0x2::vec_set::contains<address>(&v2.white_list, &v0);
            let v5 = if (v3) {
                if (v2.buy_paused) {
                    !v4
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                abort 19
            };
            let v6 = if (!v3) {
                if (v2.sell_paused) {
                    !v4
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                abort 20
            };
            let (v7, v8, _) = get_reserves_size<T0, T1>(v2);
            assert!(v7 > 0 && v8 > 0, 1);
            let v10 = 0x2::coin::value<T0>(&arg1);
            let v11 = v10;
            let v12 = 0x2::coin::into_balance<T0>(arg1);
            if (v3) {
                let v13 = v10 * (v2.buy_tax as u64) / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v12, v13, arg4), v2.market_address);
                v11 = v10 - v13;
            };
            let v14 = get_amount_out(v11, v7, v8);
            let v15 = v14;
            if (!v3) {
                let v16 = v14 * (v2.sell_tax as u64) / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v2.coin_y, v16, arg4), v2.market_address);
                v15 = v14 - v16;
            };
            assert!(v15 >= arg2, 7);
            0x2::balance::join<T0>(&mut v2.coin_x, v12);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v2.coin_y, v15, arg4), 0x2::tx_context::sender(arg4));
            let (v17, v18, _) = get_reserves_size<T0, T1>(v2);
            assert_lp_value_is_increased(v7, v8, v17, v18);
            let v20 = vector[];
            0x1::vector::push_back<u64>(&mut v20, v11);
            0x1::vector::push_back<u64>(&mut v20, 0);
            0x1::vector::push_back<u64>(&mut v20, 0);
            0x1::vector::push_back<u64>(&mut v20, v15);
            v20
        } else {
            let v21 = get_mut_pool<T1, T0>(arg0, !arg3);
            let v22 = is_tax_coin<T0>(0x1::ascii::into_bytes(v21.tax_coin));
            let v23 = 0x2::vec_set::contains<address>(&v21.white_list, &v0);
            let v24 = if (v22) {
                if (v21.buy_paused) {
                    !v23
                } else {
                    false
                }
            } else {
                false
            };
            if (v24) {
                abort 19
            };
            let v25 = if (!v22) {
                if (v21.sell_paused) {
                    !v23
                } else {
                    false
                }
            } else {
                false
            };
            if (v25) {
                abort 20
            };
            let (v26, v27, _) = get_reserves_size<T1, T0>(v21);
            assert!(v26 > 0 && v27 > 0, 1);
            let v29 = 0x2::coin::value<T0>(&arg1);
            let v30 = v29;
            let v31 = 0x2::coin::into_balance<T0>(arg1);
            if (v22) {
                let v32 = 0x2441fbeefd1cb2e892b6c27cdc5eec6fda9dd1cebf6c1fea46304ec4d208d644::math::mul_div(v29, (v21.buy_tax as u64), 100);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v31, v32, arg4), v21.market_address);
                v30 = v29 - v32;
            };
            let v33 = get_amount_out(v30, v27, v26);
            let v34 = v33;
            if (!v22) {
                let v35 = v33 * (v21.sell_tax as u64) / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v21.coin_x, v35, arg4), v21.market_address);
                v34 = v33 - v35;
            };
            assert!(v34 >= arg2, 7);
            0x2::balance::join<T0>(&mut v21.coin_y, v31);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v21.coin_x, v34, arg4), 0x2::tx_context::sender(arg4));
            let (v36, v37, _) = get_reserves_size<T1, T0>(v21);
            assert_lp_value_is_increased(v26, v27, v36, v37);
            let v39 = vector[];
            0x1::vector::push_back<u64>(&mut v39, 0);
            0x1::vector::push_back<u64>(&mut v39, v34);
            0x1::vector::push_back<u64>(&mut v39, v30);
            0x1::vector::push_back<u64>(&mut v39, 0);
            v39
        }
    }

    public(friend) fun upgrade_version(arg0: &mut Global) {
        arg0.version = arg0.version + 1;
    }

    // decompiled from Move bytecode v7
}

