module 0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_obligation {
    struct LeverageMarketOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun open_obligation<T0>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_app::LeverageApp, arg2: &0x1458952488088244c236f405a9460bd43876c42ad308cd1e17489bb3ce1e276e::leverage_market::LeverageMarket, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: &mut 0x2::tx_context::TxContext) : LeverageMarketOwnerCap {
        abort 0
    }

    // decompiled from Move bytecode v7
}

