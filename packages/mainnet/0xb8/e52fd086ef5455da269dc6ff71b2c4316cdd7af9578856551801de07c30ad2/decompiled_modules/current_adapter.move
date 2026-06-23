module 0xb8e52fd086ef5455da269dc6ff71b2c4316cdd7af9578856551801de07c30ad2::current_adapter {
    struct Current has drop {
        dummy_field: bool,
    }

    struct CurrentAdapter has key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap>,
    }

    public fun deposit<T0, T1>(arg0: &mut CurrentAdapter, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg3: 0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::Deposit<T0, Current>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Current{dummy_field: false};
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::deposit::deposit<T1, T0>(arg1, arg2, 0x1::option::borrow<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap>(&arg0.cap), 0x2::coin::from_balance<T0>(0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::unwrap_deposit<T0, Current>(arg3, v0), arg5), arg4, arg5);
    }

    public fun withdraw<T0, T1>(arg0: &mut CurrentAdapter, arg1: &0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::Vault<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: 0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::Withdraw<T0, Current>, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::Deposit<T0, 0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::MainVault> {
        let v0 = Current{dummy_field: false};
        let v1 = Current{dummy_field: false};
        0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::wrap_deposit_from_adapter<T0, Current>(arg1, v1, 0x2::coin::into_balance<T0>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::withdraw::withdraw_as_coin<T1, T0>(arg2, arg3, 0x1::option::borrow<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap>(&arg0.cap), arg4, 0x3f2d9aa53be2cd12ce875394660581e45b5eed67117adaa68d3d722a3a909881::vault::unwrap_withdraw<T0, Current>(arg5, v0), arg6, arg7, arg8)))
    }

    // decompiled from Move bytecode v7
}

