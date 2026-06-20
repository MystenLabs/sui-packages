module 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::interface {
    public fun swap<T0, T1>(arg0: &mut 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_emergency(arg0), 102);
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::version::check_version(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_version(arg0));
        let v0 = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::swap_out<T0, T1>(arg0, arg1, arg2, 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_order<T0, T1>(), arg3);
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::event::swapped_event(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::id(arg0), 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public fun add_liquidity<T0, T1>(arg0: &mut 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_emergency(arg0), 102);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_in_black_list(arg0, &v0), 108);
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::version::check_version(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_version(arg0));
        let v1 = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_order<T0, T1>();
        if (!0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::has_registered<T0, T1>(arg0)) {
            0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::register_pool<T0, T1>(arg0, v1);
        };
        let v2 = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_mut_pool<T0, T1>(arg0, v1);
        let (v3, v4) = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::add_liquidity<T0, T1>(v2, arg1, arg2, arg3, arg4, v1, arg5);
        let v5 = v4;
        assert!(0x1::vector::length<u64>(&v5) == 5, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::LP<T0, T1>>>(v3, 0x2::tx_context::sender(arg5));
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::event::added_event(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::global_id<T0, T1>(v2), 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5), 0x1::vector::pop_back<u64>(&mut v5));
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::Global, arg1: 0x2::coin::Coin<0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_emergency(arg0), 102);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_in_black_list(arg0, &v0), 108);
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::version::check_version(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_version(arg0));
        let v1 = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_order<T0, T1>();
        let v2 = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_mut_pool<T0, T1>(arg0, v1);
        let (v3, v4) = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::remove_liquidity<T0, T1>(v2, arg1, v1, arg2);
        let v5 = v4;
        let v6 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg2));
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::event::removed_event(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::global_id<T0, T1>(v2), 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v5), 0x2::coin::value<0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::LP<T0, T1>>(&arg1));
    }

    public fun swapCoin<T0, T1>(arg0: &mut 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_emergency(arg0), 102);
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::version::check_version(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_version(arg0));
        let v0 = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::swapCoin<T0, T1>(arg0, arg1, arg2, 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_order<T0, T1>(), arg3);
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::event::swapped_event(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::id(arg0), 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&arg1), 0, 0, 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun get_amount_out<T0, T1>(arg0: &mut 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::Global, arg1: u64) : u64 {
        0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_swap_out<T0, T1>(arg0, arg1, 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_order<T0, T1>())
    }

    public fun get_lpliquidity<T0, T1>(arg0: &mut 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::Global) : (u64, u64, u64) {
        let v0 = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::is_order<T0, T1>();
        if (v0) {
            0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_reserves_size<T0, T1>(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_mut_pool<T0, T1>(arg0, v0))
        } else {
            let (v4, v5, v6) = 0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_reserves_size<T1, T0>(0xa74af6ab271682c2397104b182642857beb61af4f1769ea4301064bdaff2e7d::implements::get_mut_pool<T1, T0>(arg0, !v0));
            (v5, v4, v6)
        }
    }

    // decompiled from Move bytecode v7
}

