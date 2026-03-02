module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::emode_admin {
    public fun create_emode_params(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::limiter::NewLimiter, arg8: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::limiter::NewLimiter) : 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::emode::NewEMode {
        abort 0
    }

    public fun create_limiter(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: u64, arg2: u32, arg3: u32) : 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::limiter::NewLimiter {
        abort 0
    }

    public fun onboard_asset_to_emode_group<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg3: u8, arg4: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun onboard_new_emode_group<T0>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_asset_in_emode_group<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg3: u8, arg4: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::emode::NewEMode, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

