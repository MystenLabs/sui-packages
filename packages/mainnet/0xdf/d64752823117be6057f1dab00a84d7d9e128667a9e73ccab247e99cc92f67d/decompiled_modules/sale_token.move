module 0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::sale_token {
    public fun new<T0: drop>(arg0: T0, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<T0>, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::sealed_treasury_cap::SealedTreasuryCap<T0>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (v0, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::sealed_treasury_cap::new<T0, 0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::PackageWitness>(0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::package_witness(), v1, arg6))
    }

    // decompiled from Move bytecode v7
}

