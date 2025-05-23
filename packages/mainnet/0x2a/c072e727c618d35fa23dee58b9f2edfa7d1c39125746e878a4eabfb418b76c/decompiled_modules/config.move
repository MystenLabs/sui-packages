module 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::config {
    struct VeScaProtocolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
    }

    struct VeScaProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_protocol_enabled(arg0: &VeScaProtocolConfig) {
        assert!(arg0.enabled, 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::error_code::protocol_disabled());
    }

    public fun assert_protocol_version(arg0: &VeScaProtocolConfig) {
        assert!(arg0.version == 0, 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::error_code::protocol_version_mismatch());
    }

    public fun assert_protocol_version_and_status(arg0: &VeScaProtocolConfig) {
        assert_protocol_enabled(arg0);
        assert_protocol_version(arg0);
    }

    public fun disable_protocol(arg0: &VeScaProtocolAdminCap, arg1: &mut VeScaProtocolConfig) {
        arg1.enabled = false;
    }

    public fun enable_protocol(arg0: &VeScaProtocolAdminCap, arg1: &mut VeScaProtocolConfig) {
        arg1.enabled = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VeScaProtocolConfig{
            id      : 0x2::object::new(arg0),
            version : 0,
            enabled : true,
        };
        let v1 = VeScaProtocolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VeScaProtocolConfig>(v0);
        0x2::transfer::transfer<VeScaProtocolAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun upgrade_protocol_version(arg0: &VeScaProtocolAdminCap, arg1: &mut VeScaProtocolConfig, arg2: u64) {
        assert!(arg2 > arg1.version, 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::error_code::protocol_version_can_only_increase());
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

