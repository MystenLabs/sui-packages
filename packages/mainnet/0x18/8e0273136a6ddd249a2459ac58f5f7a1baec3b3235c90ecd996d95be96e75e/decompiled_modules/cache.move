module 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::Vault<T0>, arg1: &mut 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::cache::UpdateLiquidityCacheCap<T0>, arg2: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config::Config, arg3: &mut 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::protected::ProtectedMarket, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock) {
        let v0 = 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::state::create_extension_key();
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::cache::account_for_extension_liquidity_of_type<T0, T1, 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::state::ExtensionKey>(arg1, arg2, &v0, 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::state::total_active_liquidity<T1>(0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::vault::borrow_extension<T0, 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::state::ExtensionKey, 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::state::ExtensionStateV1>(arg0, v0), 0x188e0273136a6ddd249a2459ac58f5f7a1baec3b3235c90ecd996d95be96e75e::protected::borrow_mut(arg3), arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

