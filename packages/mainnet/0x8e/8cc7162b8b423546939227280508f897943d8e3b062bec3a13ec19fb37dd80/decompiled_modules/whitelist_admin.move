module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::whitelist_admin {
    public fun burn_whitelist(arg0: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::PackageCallerCap) {
        abort 0
    }

    public fun enter_market_with_emode() : u8 {
        1
    }

    public fun flash_loan() : u8 {
        0
    }

    public fun liquidation() : u8 {
        2
    }

    public fun mint_new_whitelist(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: &mut 0x2::tx_context::TxContext) : 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::PackageCallerCap {
        abort 0
    }

    public fun remove_whitelist(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: 0x2::object::ID) {
        abort 0
    }

    public fun update_permission(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::AdminCap, arg1: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg2: 0x2::object::ID, arg3: u8, arg4: bool) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

