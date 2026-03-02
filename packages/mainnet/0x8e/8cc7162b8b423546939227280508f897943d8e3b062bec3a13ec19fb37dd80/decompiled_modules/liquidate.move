module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::liquidate {
    public fun liquidate<T0, T1, T2>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun liquidate_as_coin<T0, T1, T2>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::PackageCallerCap, arg2: 0x2::object::ID, arg3: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

