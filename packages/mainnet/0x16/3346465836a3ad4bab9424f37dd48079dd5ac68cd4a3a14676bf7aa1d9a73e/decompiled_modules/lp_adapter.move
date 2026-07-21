module 0x163346465836a3ad4bab9424f37dd48079dd5ac68cd4a3a14676bf7aa1d9a73e::lp_adapter {
    struct LpAdapter has drop {
        dummy_field: bool,
    }

    public fun begin_lp<T0, T1>(arg0: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::operator::OperatorHub, arg1: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::registry::AdapterRegistry, arg2: &mut 0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::vault::Vault, arg3: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::price::Price, arg4: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::price::Price, arg5: u8, arg6: u8, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : 0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::vault::PricedLoan {
        let v0 = LpAdapter{dummy_field: false};
        0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::vault::session_open_lp<T0, T1, LpAdapter>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun begin_spot<T0, T1>(arg0: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::operator::OperatorHub, arg1: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::registry::AdapterRegistry, arg2: &mut 0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::vault::Vault, arg3: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::price::Price, arg4: &0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::price::Price, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::vault::PricedLoan {
        let v0 = LpAdapter{dummy_field: false};
        0x9cc854d89b2986f9a26bb230ee8c511e6bb2c4e0d1482c6477c35a9a85b8b67d::vault::session_open<T0, T1, LpAdapter>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

