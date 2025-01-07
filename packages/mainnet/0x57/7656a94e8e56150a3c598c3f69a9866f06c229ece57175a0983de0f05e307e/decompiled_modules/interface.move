module 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::interface {
    public entry fun swap<T0, T1>(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 102);
        let v0 = 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::swap_out<T0, T1>(arg0, arg1, arg2, 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_order<T0, T1>(), arg3);
        0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::event::swapped_event(0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::id<T0, T1>(arg0), 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0), 0x1::vector::pop_back<u64>(&mut v0));
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 102);
        let v0 = 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_order<T0, T1>();
        if (!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::has_registered<T0, T1>(arg0)) {
            0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::register_pool<T0, T1>(arg0, v0);
        };
        let v1 = 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::add_liquidity<T0, T1>(v1, arg1, arg2, arg3, arg4, v0, arg5);
        let v4 = v3;
        assert!(0x1::vector::length<u64>(&v4) == 3, 104);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg5));
        0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::event::added_event(0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::global_id<T0, T1>(v1), 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4), 0x1::vector::pop_back<u64>(&mut v4));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: 0x2::coin::Coin<0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 102);
        let v0 = 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_order<T0, T1>();
        let v1 = 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::get_mut_pool<T0, T1>(arg0, v0);
        let (v2, v3) = 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::remove_liquidity<T0, T1>(v1, arg1, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg2));
        0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::event::removed_event(0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::global_id<T0, T1>(v1), 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::generate_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v5), 0x2::coin::value<T1>(&v4), 0x2::coin::value<0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::LP<T0, T1>>(&arg1));
    }

    public entry fun multi_add_liquidity<T0, T1>(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1) && !0x1::vector::is_empty<0x2::coin::Coin<T1>>(&arg4), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        if (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1)) {
            0x2::pay::join_vec<T0>(&mut v0, arg1);
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        };
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg7);
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg4);
        if (!0x1::vector::is_empty<0x2::coin::Coin<T1>>(&arg4)) {
            0x2::pay::join_vec<T1>(&mut v2, arg4);
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(arg4);
        };
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

    public entry fun multi_remove_liquidity<T0, T1>(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: vector<0x2::coin::Coin<0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::LP<T0, T1>>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 102);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::LP<T0, T1>>>(&arg1), 105);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::LP<T0, T1>>>(&mut arg1);
        0x2::pay::join_vec<0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::LP<T0, T1>>(&mut v0, arg1);
        remove_liquidity<T0, T1>(arg0, v0, arg2);
    }

    public entry fun multi_swap<T0, T1>(arg0: &mut 0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x577656a94e8e56150a3c598c3f69a9866f06c229ece57175a0983de0f05e307e::implements::is_emergency(arg0), 102);
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

