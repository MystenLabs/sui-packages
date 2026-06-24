module 0x47eacef13293da506e01ac96fbc16628a9fa23c415886c5ba5565c18ca89be47::flowxv2 {
    public fun swap<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, 0x2::coin::from_balance<T0>(v0, arg3), arg3);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T0, T1>(arg0, b"FLOWXV2", 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg1, 0x2::coin::from_balance<T1>(v0, arg3), arg3);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T1, T0>(arg0, b"FLOWXV2", 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v7
}

