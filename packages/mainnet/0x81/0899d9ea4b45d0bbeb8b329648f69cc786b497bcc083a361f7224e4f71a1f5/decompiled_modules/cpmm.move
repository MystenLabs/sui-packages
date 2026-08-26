module 0x810899d9ea4b45d0bbeb8b329648f69cc786b497bcc083a361f7224e4f71a1f5::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: bool, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T0>(arg0, arg2), arg4);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, v0, arg4)));
        if (arg3) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T0>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T0>(arg0), arg4);
        };
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T1>(arg0, arg2), arg4);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg1, v0, arg4)));
        if (arg3) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T1>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T1>(arg0), arg4);
        };
    }

    // decompiled from Move bytecode v7
}

