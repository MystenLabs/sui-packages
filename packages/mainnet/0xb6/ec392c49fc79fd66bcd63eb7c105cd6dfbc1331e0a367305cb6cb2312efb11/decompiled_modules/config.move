module 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::config {
    struct VeScaProtocolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
    }

    struct VeScaProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_protocol_enabled(arg0: &VeScaProtocolConfig) {
        assert!(arg0.enabled, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code::protocol_disabled());
    }

    public fun assert_protocol_version(arg0: &VeScaProtocolConfig) {
        assert!(arg0.version == 0, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code::protocol_version_mismatch());
    }

    public fun assert_protocol_version_and_status(arg0: &VeScaProtocolConfig) {
        assert_protocol_enabled(arg0);
        assert_protocol_version(arg0);
    }

    public fun create_protocol_config_and_cap_for_test(arg0: &mut 0x2::tx_context::TxContext) : (VeScaProtocolConfig, VeScaProtocolAdminCap) {
        let v0 = VeScaProtocolConfig{
            id      : 0x2::object::new(arg0),
            version : 0,
            enabled : true,
        };
        let v1 = VeScaProtocolAdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
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

    public fun upgrade_protocol_version(arg0: &VeScaProtocolAdminCap, arg1: &mut VeScaProtocolConfig) {
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

