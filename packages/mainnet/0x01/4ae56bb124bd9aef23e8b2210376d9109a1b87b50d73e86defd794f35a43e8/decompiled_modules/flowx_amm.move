module 0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::flowx_amm {
    public fun swap<T0, T1>(arg0: &mut 0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::take_balance<T0>(arg0, arg2), arg3);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, v0, arg3);
        0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::emit_swap_event<T0, T1>(arg0, b"FLOWX_AMM", 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::take_balance<T1>(arg0, arg2), arg3);
        let v1 = 0x2::coin::value<T1>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg1, v0, arg3);
        0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x14ae56bb124bd9aef23e8b2210376d9109a1b87b50d73e86defd794f35a43e8::router::emit_swap_event<T1, T0>(arg0, b"FLOWX_AMM", 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

