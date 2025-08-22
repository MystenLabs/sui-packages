module 0x62e8d653b0617e106c90a0298f37c87fa5a8d7f3da79acc2454c9b3b553bcc3d::global_config {
    struct SetPackageVersion has copy, drop {
        sender: address,
        new_version: u64,
        old_version: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        is_active: bool,
        protocol_fee_percent: u64,
        shortfall_fee_percent: u64,
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg2),
            package_version       : 1,
            is_active             : false,
            protocol_fee_percent  : arg0,
            shortfall_fee_percent : arg1,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    public(friend) fun assert_active(arg0: &GlobalConfig) {
        assert!(arg0.is_active, 3);
    }

    public(friend) fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    public fun info(arg0: &GlobalConfig) : (u64, bool, u64, u64) {
        (arg0.package_version, arg0.is_active, arg0.protocol_fee_percent, arg0.shortfall_fee_percent)
    }

    public(friend) fun max_percent() : u64 {
        10000
    }

    public(friend) fun set_active_status(arg0: &mut GlobalConfig, arg1: bool) {
        arg0.is_active = arg1;
    }

    public(friend) fun set_package_version(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg0.package_version;
        assert!(arg1 > v0, 2);
        arg0.package_version = arg1;
        let v1 = SetPackageVersion{
            sender      : 0x2::tx_context::sender(arg2),
            new_version : arg1,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    public(friend) fun set_protocol_fee_percent(arg0: &mut GlobalConfig, arg1: u64) {
        arg0.protocol_fee_percent = arg1;
    }

    public(friend) fun set_shortfall_fee_percent(arg0: &mut GlobalConfig, arg1: u64) {
        arg0.shortfall_fee_percent = arg1;
    }

    // decompiled from Move bytecode v6
}

