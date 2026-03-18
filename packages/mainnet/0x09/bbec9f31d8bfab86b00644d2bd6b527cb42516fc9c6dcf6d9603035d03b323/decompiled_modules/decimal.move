module 0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::decimal {
    public fun register_decimals<T0>(arg0: &0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::DragonBallCollector, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_functional(arg0);
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::decimals_admin::register_decimals<T0>(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    public fun register_decimals_with_currency<T0>(arg0: &0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::DragonBallCollector, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::tx_context::TxContext) {
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_functional(arg0);
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::decimals_admin::register_decimals_with_currency<T0>(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

