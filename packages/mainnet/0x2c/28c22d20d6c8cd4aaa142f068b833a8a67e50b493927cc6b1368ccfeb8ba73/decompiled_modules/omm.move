module 0x2c28c22d20d6c8cd4aaa142f068b833a8a67e50b493927cc6b1368ccfeb8ba73::omm {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T1, T0>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T1, T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T0>(arg0, arg4), arg6), 0, arg6)));
        if (arg5) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T0>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T0>(arg0), arg6);
        };
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T1, T0>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T1, T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T1>(0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T1>(arg0, arg4), arg6), 0, arg6)));
        if (arg5) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T1>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T1>(arg0), arg6);
        };
    }

    // decompiled from Move bytecode v7
}

