module 0xdd29bf1c22e01b953bc686e84c2ba46832f31a47a01e71ceb916c51eb9c7ba7e::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::AdminCap, arg1: &mut 0xdd29bf1c22e01b953bc686e84c2ba46832f31a47a01e71ceb916c51eb9c7ba7e::leverage_app::LeverageApp, arg2: 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap) {
        abort 0
    }

    public fun onboard_market<T0>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::AdminCap, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun remove_protocol_caller_cap(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::AdminCap, arg1: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xdd29bf1c22e01b953bc686e84c2ba46832f31a47a01e71ceb916c51eb9c7ba7e::leverage_app::LeverageApp) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

