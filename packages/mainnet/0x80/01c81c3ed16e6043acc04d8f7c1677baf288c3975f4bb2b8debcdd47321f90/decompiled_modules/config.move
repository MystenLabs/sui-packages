module 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config {
    struct VeScaProtocolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
    }

    struct VeScaProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_protocol_enabled(arg0: &VeScaProtocolConfig) {
        assert!(arg0.enabled, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::protocol_disabled());
    }

    public fun assert_protocol_version(arg0: &VeScaProtocolConfig) {
        assert!(arg0.version == 2, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::protocol_version_mismatch());
    }

    public fun assert_protocol_version_and_status(arg0: &VeScaProtocolConfig) {
        assert_protocol_enabled(arg0);
        assert_protocol_version(arg0);
    }

    public fun de_whitelist_subscriber<T0: drop>(arg0: &VeScaProtocolAdminCap, arg1: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist) {
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::remove_subscriber<T0>(arg1);
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
            version : 2,
            enabled : true,
        };
        let v1 = VeScaProtocolAdminCap{id: 0x2::object::new(arg0)};
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::initialize(arg0);
        0x2::transfer::share_object<VeScaProtocolConfig>(v0);
        0x2::transfer::transfer<VeScaProtocolAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_subscribers(arg0: &VeScaProtocolAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::initialize(arg1);
    }

    public fun protocol_enabled(arg0: &VeScaProtocolConfig) : bool {
        arg0.enabled
    }

    public fun upgrade_protocol_version(arg0: &VeScaProtocolAdminCap, arg1: &mut VeScaProtocolConfig, arg2: u64) {
        assert!(arg2 > arg1.version, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::protocol_version_downgrade());
        arg1.version = arg2;
    }

    public fun whitelist_subscriber<T0: drop>(arg0: &VeScaProtocolAdminCap, arg1: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist) {
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::add_subscriber_to_whitelist<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

