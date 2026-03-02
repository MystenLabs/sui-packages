module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::asset_admin {
    public fun create_interest_model(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::interest::InterestModel {
        abort 0
    }

    public fun create_market_asset_config(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::asset::AssetConfig {
        abort 0
    }

    public fun onboard_new_asset<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg3: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::interest::InterestModel, arg4: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::asset::AssetConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_asset_paused_state<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg3: u8, arg4: bool) {
        abort 0
    }

    public fun update_market_asset_config<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg3: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::asset::AssetConfig) {
        abort 0
    }

    public fun update_market_asset_interest_model<T0, T1>(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::market::Market<T0>, arg3: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::interest::InterestModel) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

