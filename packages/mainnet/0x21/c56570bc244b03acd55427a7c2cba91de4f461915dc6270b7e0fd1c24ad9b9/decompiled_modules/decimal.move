module 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::decimal {
    public fun register_decimals<T0>(arg0: &0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::DragonBallCollector, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_can_summon_shenron(arg0);
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg3));
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::decimals_admin::register_decimals<T0>(0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::lending_admin_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

