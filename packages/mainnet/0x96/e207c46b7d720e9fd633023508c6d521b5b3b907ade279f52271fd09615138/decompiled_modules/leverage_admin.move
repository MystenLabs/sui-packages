module 0x96e207c46b7d720e9fd633023508c6d521b5b3b907ade279f52271fd09615138::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::AdminCap, arg1: &mut 0x96e207c46b7d720e9fd633023508c6d521b5b3b907ade279f52271fd09615138::leverage_app::LeverageApp, arg2: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap) {
        abort 0
    }

    public fun onboard_market<T0>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::AdminCap, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun remove_protocol_caller_cap(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::AdminCap, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0x96e207c46b7d720e9fd633023508c6d521b5b3b907ade279f52271fd09615138::leverage_app::LeverageApp) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

