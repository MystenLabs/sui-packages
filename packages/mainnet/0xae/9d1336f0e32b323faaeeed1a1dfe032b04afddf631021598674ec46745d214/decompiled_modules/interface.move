module 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::interface {
    public entry fun swap<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        let v0 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::swap_out<T0, T1>(arg0, arg1, arg2, 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_order<T0, T1>(), arg3);
        0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::event::swapped_event(0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::id<T0, T1>(arg0), 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        let v0 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_order<T0, T1>();
        if (!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::has_registered<T0, T1>(arg0)) {
            0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::register_pool<T0, T1>(arg0, v0);
        };
        let v1 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::add_liquidity<T0, T1>(v1, arg1, arg2, arg3, arg4, v0, arg5);
        let v4 = v3;
        assert!(0x1::vector::length<u64>(&v4) == 5, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg5));
        0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::event::added_event(0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::global_id<T0, T1>(v1), 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
    }

    public entry fun removeX_scale_liquidity<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::admin(arg0), 106);
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        let v0 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_order<T0, T1>();
        let v1 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_mut_pool<T0, T1>(arg0, v0);
        let v2 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::removeX_scale_liquidity<T0, T1>(v1, arg1, v0, arg2);
        0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::event::burn_event(0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::global_id<T0, T1>(v1), 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2));
    }

    public entry fun removeY_scale_liquidity<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::admin(arg0), 106);
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        let v0 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_order<T0, T1>();
        let v1 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_mut_pool<T0, T1>(arg0, v0);
        let v2 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::removeY_scale_liquidity<T0, T1>(v1, arg1, v0, arg2);
        0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::event::burn_event(0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::global_id<T0, T1>(v1), 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: 0x2::coin::Coin<0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        let v0 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_order<T0, T1>();
        let v1 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::remove_liquidity<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::event::removed_event(0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::global_id<T0, T1>(v1), 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::LP<T0, T1>>(&arg1));
    }

    public fun getLpliquidity<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global) : (u64, u64, u64) {
        let v0 = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_order<T0, T1>();
        if (v0) {
            0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_reserves_size<T0, T1>(0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_mut_pool<T0, T1>(arg0, v0))
        } else {
            let (v4, v5, v6) = 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_reserves_size<T1, T0>(0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::get_mut_pool<T1, T0>(arg0, !v0));
            (v5, v4, v6)
        }
    }

    public entry fun multi_add_liquidity<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1) && !0x1::vector::is_empty<0x2::coin::Coin<T1>>(&arg4), 105);
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

    public entry fun multi_remove_liquidity<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: vector<0x2::coin::Coin<0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::LP<T0, T1>>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::LP<T0, T1>>>(&arg1), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::LP<T0, T1>>>(&mut arg1);
        0x2::pay::join_vec<0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::LP<T0, T1>>(&mut v0, arg1);
        remove_liquidity<T0, T1>(arg0, v0, arg2);
    }

    public entry fun multi_swap<T0, T1>(arg0: &mut 0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xae9d1336f0e32b323faaeeed1a1dfe032b04afddf631021598674ec46745d214::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1), 105);
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

    // decompiled from Move bytecode v6
}

