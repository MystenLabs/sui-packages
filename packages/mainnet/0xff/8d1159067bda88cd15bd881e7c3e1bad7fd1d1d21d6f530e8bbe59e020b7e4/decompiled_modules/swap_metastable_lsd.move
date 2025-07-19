module 0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::swap_metastable_lsd {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T1, T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::swap_transaction::SwapTransaction<T2, T3>, arg5: &0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T1, T0>(arg0, arg1, arg2, arg3, 0, arg6);
        let v1 = 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>>(arg0);
        0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::swap_event::emit_common_swap<T0, T1>(0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::consts::DEX_METASTABLE(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T1, T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::swap_transaction::SwapTransaction<T2, T3>, arg5: &0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T1, T0>(arg0, arg1, arg2, arg3, 0, arg6);
        let v1 = 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>>(arg0);
        0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::swap_event::emit_common_swap<T0, T1>(0xff8d1159067bda88cd15bd881e7c3e1bad7fd1d1d21d6f530e8bbe59e020b7e4::consts::DEX_METASTABLE(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

