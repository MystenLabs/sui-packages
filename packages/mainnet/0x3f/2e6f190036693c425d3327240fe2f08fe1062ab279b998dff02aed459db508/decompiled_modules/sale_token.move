module 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::sale_token {
    public fun new<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<T0>, 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::SealedTreasuryCap<T0>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (v0, 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::new<T0, 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::PackageWitness>(0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::package_witness(), v1, arg6))
    }

    // decompiled from Move bytecode v7
}

