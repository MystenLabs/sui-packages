module 0x112f661e9d13a8d1c3045587c6b94759d79bc88f8aeb8441639aafd9013eba84::metastable {
    public fun swap<T0, T1, T2>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration, arg3: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T2>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = deposit<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        withdraw<T2, T1>(arg0, v0, arg2, arg3, arg5, arg6, arg7, arg8)
    }

    public fun deposit<T0, T1>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration, arg3: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T1, T0>(arg3, arg5, 0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::create_deposit_cap<T1, T0>(arg2, arg3, arg4, arg6), arg1, 0, arg7)
    }

    public fun withdraw<T0, T1>(arg0: &0x91dd844df4f20026f6c6a4c44d0c87a960316e2e3f8c8a0e55e1532a05a86ab2::router::HopReceipt, arg1: 0x2::coin::Coin<T0>, arg2: &0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::MetaVaultPythIntegration, arg3: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg3, arg5, 0x5a6df33a03a69959065b5e87aecac72d0afff893a1923833a77dcfb0d2f42980::pyth::create_withdraw_cap<T0, T1>(arg2, arg3, arg4, arg6), arg1, 0, arg7)
    }

    // decompiled from Move bytecode v7
}

