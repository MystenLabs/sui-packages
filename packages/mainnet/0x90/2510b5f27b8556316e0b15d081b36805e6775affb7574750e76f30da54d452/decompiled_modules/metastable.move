module 0x902510b5f27b8556316e0b15d081b36805e6775affb7574750e76f30da54d452::metastable {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::SwapContext, arg1: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T1, T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::take_balance<T0>(arg0, arg4);
        let v1 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T1, T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg5), 0, arg5);
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::emit_swap_event<T0, T1>(arg0, b"METASTABLE", 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>>(arg1), 0x2::balance::value<T0>(&v0), 0x2::coin::value<T1>(&v1), 0);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::SwapContext, arg1: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T1, T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::take_balance<T1>(arg0, arg4);
        let v1 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T1, T0>(arg1, arg2, arg3, 0x2::coin::from_balance<T1>(v0, arg5), 0, arg5);
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::emit_swap_event<T1, T0>(arg0, b"METASTABLE", 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>>(arg1), 0x2::balance::value<T1>(&v0), 0x2::coin::value<T0>(&v1), 0);
    }

    // decompiled from Move bytecode v7
}

