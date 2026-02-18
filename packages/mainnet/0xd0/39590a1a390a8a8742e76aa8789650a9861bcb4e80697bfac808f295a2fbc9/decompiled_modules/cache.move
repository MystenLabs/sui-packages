module 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::vault::Vault<T0>, arg1: &mut 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::config::Config, arg3: &mut 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::protected::ProtectedMarket, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock) {
        let v0 = 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::state::create_extension_key();
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::cache::account_for_extension_liquidity_of_type<T0, T1, 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::state::ExtensionKey>(arg1, arg2, &v0, 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::state::total_active_liquidity<T1>(0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::vault::borrow_extension<T0, 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::state::ExtensionKey, 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::state::ExtensionStateV1>(arg0, v0), 0xd039590a1a390a8a8742e76aa8789650a9861bcb4e80697bfac808f295a2fbc9::protected::borrow_mut(arg3), arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

