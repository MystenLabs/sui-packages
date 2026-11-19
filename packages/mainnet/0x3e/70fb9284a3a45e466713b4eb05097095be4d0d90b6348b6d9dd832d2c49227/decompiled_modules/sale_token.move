module 0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::sale_token {
    public fun new<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<T0>, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::sealed_treasury_cap::SealedTreasuryCap<T0>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (v0, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::sealed_treasury_cap::new<T0, 0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::PackageWitness>(0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::package_witness(), v1, arg6))
    }

    // decompiled from Move bytecode v7
}

