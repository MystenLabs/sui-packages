module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        pause_non_admin_operations: bool,
        platform_fee_recipient: address,
        min_rate: u64,
        max_rate: u64,
        default_rate: u64,
        min_rate_interval: u64,
        max_rate_interval: u64,
        max_fee_percentage: u64,
    }

    public fun get_default_rate(arg0: &ProtocolConfig) : u64 {
        arg0.default_rate
    }

    public fun get_max_allowed_fee_percentage(arg0: &ProtocolConfig) : u64 {
        arg0.max_fee_percentage
    }

    public fun get_max_rate(arg0: &ProtocolConfig) : u64 {
        arg0.max_rate
    }

    public fun get_max_rate_interval(arg0: &ProtocolConfig) : u64 {
        arg0.max_rate_interval
    }

    public fun get_min_rate(arg0: &ProtocolConfig) : u64 {
        arg0.min_rate
    }

    public fun get_min_rate_interval(arg0: &ProtocolConfig) : u64 {
        arg0.min_rate_interval
    }

    public fun get_platform_fee_recipient(arg0: &ProtocolConfig) : address {
        arg0.platform_fee_recipient
    }

    public fun get_protocol_pause_status(arg0: &ProtocolConfig) : bool {
        arg0.pause_non_admin_operations
    }

    public fun increase_supported_package_version(arg0: &mut ProtocolConfig, arg1: &AdminCap) {
        assert!(arg0.version < 3, 1001);
        increase_version(arg0);
    }

    fun increase_version(arg0: &mut ProtocolConfig) {
        arg0.version = arg0.version + 1;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_supported_version_update_event(arg0.version, arg0.version);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = ProtocolConfig{
            id                         : 0x2::object::new(arg0),
            version                    : 3,
            pause_non_admin_operations : false,
            platform_fee_recipient     : v1,
            min_rate                   : 250000000,
            max_rate                   : 5000000000,
            default_rate               : 1000000000,
            min_rate_interval          : 3600000,
            max_rate_interval          : 86400000,
            max_fee_percentage         : 100000000,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, v1);
        0x2::transfer::public_share_object<ProtocolConfig>(v2);
    }

    public fun pause_non_admin_operations(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: bool) {
        arg0.pause_non_admin_operations = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_pause_non_admin_operations_event(arg2);
    }

    public fun update_default_rate(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: u64) {
        let v0 = if (arg2 >= arg0.min_rate) {
            if (arg2 <= arg0.max_rate) {
                arg2 != arg0.default_rate
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1003);
        arg0.default_rate = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_default_rate_update_event(arg0.default_rate, arg2);
    }

    public fun update_max_fee_percentage(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 < 1000000000 && arg2 != arg0.max_fee_percentage, 1004);
        arg0.max_fee_percentage = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_max_allowed_fee_percentage_updated_event(arg0.max_fee_percentage, arg2);
    }

    public fun update_max_rate(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: u64) {
        let v0 = if (arg2 >= arg0.min_rate) {
            if (arg2 >= arg0.default_rate) {
                arg2 != arg0.max_rate
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1003);
        arg0.max_rate = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_max_rate_update_event(arg0.max_rate, arg2);
    }

    public fun update_max_rate_interval(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 >= arg0.min_rate_interval && arg2 != arg0.max_rate_interval, 1006);
        arg0.max_rate_interval = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_max_rate_interval_update_event(arg0.max_rate_interval, arg2);
    }

    public fun update_min_rate(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: u64) {
        let v0 = if (arg2 > 0) {
            if (arg2 <= arg0.max_rate) {
                if (arg2 <= arg0.default_rate) {
                    arg2 != arg0.min_rate
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1003);
        arg0.min_rate = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_min_rate_update_event(arg0.min_rate, arg2);
    }

    public fun update_min_rate_interval(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: u64) {
        let v0 = if (arg2 >= 60000) {
            if (arg2 <= arg0.max_rate_interval) {
                arg2 != arg0.min_rate_interval
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1006);
        arg0.min_rate_interval = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_min_rate_interval_update_event(arg0.min_rate_interval, arg2);
    }

    public fun update_platform_fee_recipient(arg0: &mut ProtocolConfig, arg1: &AdminCap, arg2: address) {
        assert!(arg2 != @0x0 && arg2 != arg0.platform_fee_recipient, 1002);
        arg0.platform_fee_recipient = arg2;
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::events::emit_platform_fee_recipient_update_event(arg0.platform_fee_recipient, arg2);
    }

    public fun verify_protocol_not_paused(arg0: &ProtocolConfig) {
        assert!(!arg0.pause_non_admin_operations, 1005);
    }

    public fun verify_supported_package(arg0: &ProtocolConfig) {
        assert!(arg0.version == 3, 1000);
    }

    // decompiled from Move bytecode v6
}

