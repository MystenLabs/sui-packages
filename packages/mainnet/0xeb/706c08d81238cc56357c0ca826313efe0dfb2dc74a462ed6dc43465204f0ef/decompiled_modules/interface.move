module 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::interface {
    public entry fun swap<T0, T1>(arg0: &mut 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_emergency(arg0), 101);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1), 103);
        let (v0, v1) = merge_and_split<T0>(arg1, arg2, arg4);
        let v2 = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::swap_out<T0, T1>(arg0, v0, arg3, 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_order<T0, T1>(), arg4);
        0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::event::swapped_event(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::id<T0, T1>(arg0), 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::generate_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2));
        return_back_or_delete<T0>(v1, arg4);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::Global, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_emergency(arg0), 101);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1) && !0x1::vector::is_empty<0x2::coin::Coin<T1>>(&arg4), 103);
        let (v0, v1) = merge_and_split<T0>(arg1, arg2, arg7);
        let (v2, v3) = merge_and_split<T1>(arg4, arg5, arg7);
        let v4 = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_order<T0, T1>();
        0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::register_pool<T0, T1>(arg0, v4);
        let v5 = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::get_mut_pool<T0, T1>(arg0, v4);
        let (v6, v7, v8) = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::add_liquidity<T0, T1>(v5, v0, arg3, v2, arg6, v4, arg7);
        0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::event::added_event(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::global_id<T0, T1>(v5), 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::generate_lp_name<T0, T1>(), v6, v7, v8);
        return_back_or_delete<T0>(v1, arg7);
        return_back_or_delete<T1>(v3, arg7);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::Global, arg1: vector<0x2::coin::Coin<0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::LP<T0, T1>>>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_emergency(arg0), 101);
        assert!(!0x1::vector::is_empty<0x2::coin::Coin<0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::LP<T0, T1>>>(&arg1), 103);
        let (v0, v1) = merge_and_split<0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::LP<T0, T1>>(arg1, arg2, arg5);
        let v2 = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_order<T0, T1>();
        let v3 = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::get_mut_pool<T0, T1>(arg0, v2);
        let (v4, v5, v6) = 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::remove_liquidity<T0, T1>(v3, v0, arg3, arg4, v2, arg5);
        0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::event::removed_event(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::global_id<T0, T1>(v3), 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::generate_lp_name<T0, T1>(), v4, v5, v6);
        return_back_or_delete<0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::LP<T0, T1>>(v1, arg5);
    }

    fun merge_and_split<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 104);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    fun return_back_or_delete<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

