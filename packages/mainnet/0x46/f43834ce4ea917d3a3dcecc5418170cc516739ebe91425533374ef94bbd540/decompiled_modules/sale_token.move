module 0x46f43834ce4ea917d3a3dcecc5418170cc516739ebe91425533374ef94bbd540::sale_token {
    public fun new<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<T0>, 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::sealed_treasury_cap::SealedTreasuryCap<T0>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (v0, 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::sealed_treasury_cap::new<T0, 0x46f43834ce4ea917d3a3dcecc5418170cc516739ebe91425533374ef94bbd540::blast_presale_package::PackageWitness>(0x46f43834ce4ea917d3a3dcecc5418170cc516739ebe91425533374ef94bbd540::blast_presale_package::package_witness(), v1, arg6))
    }

    // decompiled from Move bytecode v7
}

