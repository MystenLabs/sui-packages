module 0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::decimal {
    public fun register_decimals<T0>(arg0: &0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::decimals_admin::register_decimals<T0>(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun register_decimals_with_currency<T0>(arg0: &0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::DragonBallCollector, arg1: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::tx_context::TxContext) {
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_functional(arg0);
        0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::decimals_admin::register_decimals_with_currency<T0>(0xa2a32ced2fad3a86200a6f36c879ac77922763a69b9e52e31b0ea38b859a5713::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

