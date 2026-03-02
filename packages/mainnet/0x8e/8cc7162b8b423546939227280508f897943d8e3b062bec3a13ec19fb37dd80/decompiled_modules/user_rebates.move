module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::user_rebates {
    public fun can_generate_referral_code(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: address) : bool {
        abort 0
    }

    public fun claim_referral_rebates<T0>(arg0: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun generate_referral_code(arg0: &mut 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun get_referral_code(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: address) : 0x1::string::String {
        abort 0
    }

    public fun get_referral_rebates(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: address) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        abort 0
    }

    public fun has_referral_code(arg0: &0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app::ProtocolApp, arg1: address) : bool {
        abort 0
    }

    // decompiled from Move bytecode v6
}

