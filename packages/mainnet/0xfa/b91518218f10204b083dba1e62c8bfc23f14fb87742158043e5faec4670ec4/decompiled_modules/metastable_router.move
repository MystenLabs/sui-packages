module 0xfab91518218f10204b083dba1e62c8bfc23f14fb87742158043e5faec4670ec4::metastable_router {
    public fun swap<T0, T1, T2>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1>, arg4: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T1>(arg0, arg5);
        let v1 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::swap<T0, T1, T2>(arg1, arg2, arg3, arg4, 0x2::coin::from_balance<T1>(v0, arg6), 0, arg6);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T2>(arg0, 0x2::coin::into_balance<T2>(v1));
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T1, T2>(arg0, b"metastable", 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>>(arg1), 0x2::balance::value<T1>(&v0), 0x2::coin::value<T2>(&v1), 0);
    }

    public fun swap_from_meta_coin<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T0>(arg0, arg4);
        let v1 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg5), 0, arg5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T0, T1>(arg0, b"metastable", 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>>(arg1), 0x2::balance::value<T0>(&v0), 0x2::coin::value<T1>(&v1), 0);
    }

    public fun swap_to_meta_coin<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T1>(arg0, arg4);
        let v1 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T1>(v0, arg5), 0, arg5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T1, T0>(arg0, b"metastable", 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>>(arg1), 0x2::balance::value<T1>(&v0), 0x2::coin::value<T0>(&v1), 0);
    }

    // decompiled from Move bytecode v6
}

