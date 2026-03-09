module 0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::decimal {
    public fun register_decimals<T0>(arg0: &0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::DragonBallCollector, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::ensure_functional(arg0);
        0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::decimals_admin::register_decimals<T0>(0xdafe2a3ac47075f97cae05908fe1ef6c0eaee4729e2d8a0517de9227ae9df9f8::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

