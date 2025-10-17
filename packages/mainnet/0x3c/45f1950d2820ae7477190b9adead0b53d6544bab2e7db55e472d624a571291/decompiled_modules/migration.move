module 0x3c45f1950d2820ae7477190b9adead0b53d6544bab2e7db55e472d624a571291::migration {
    public fun safe_migration<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::coin_registry::exists<T0>(arg0), 1);
        0x2::coin_registry::migrate_legacy_metadata<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

