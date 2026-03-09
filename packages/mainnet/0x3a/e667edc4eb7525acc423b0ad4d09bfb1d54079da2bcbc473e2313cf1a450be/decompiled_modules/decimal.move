module 0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::decimal {
    public fun register_decimals<T0>(arg0: &0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::DragonBallCollector, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_functional(arg0);
        0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::decimals_admin::register_decimals<T0>(0x3ae667edc4eb7525acc423b0ad4d09bfb1d54079da2bcbc473e2313cf1a450be::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

