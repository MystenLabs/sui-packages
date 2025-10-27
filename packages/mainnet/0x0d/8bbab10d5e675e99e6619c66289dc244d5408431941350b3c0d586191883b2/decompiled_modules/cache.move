module 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::cache {
    public fun account_for_extension_liquidity_of_type<T0, T1>(arg0: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::vault::Vault<T0>, arg1: &mut 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::cache::UpdateLiquidityCacheCap<T0>, arg2: &0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::config::Config, arg3: &mut 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::protected::ProtectedMarket, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &0x2::clock::Clock) {
        let v0 = 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state::create_extension_key();
        0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::cache::account_for_extension_liquidity_of_type<T0, T1, 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state::ExtensionKey>(arg1, arg2, &v0, 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state::total_active_liquidity<T1>(0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::vault::borrow_extension<T0, 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state::ExtensionKey, 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::state::ExtensionStateV1>(arg0, v0), 0xd8bbab10d5e675e99e6619c66289dc244d5408431941350b3c0d586191883b2::protected::borrow_mut(arg3), arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

