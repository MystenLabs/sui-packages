module 0xc8826b294d63405515391ea31c831c2e762bc56510c36df53592a04850404d1d::global_config {
    struct SetPackageVersion has copy, drop {
        sender: address,
        new_version: u64,
        old_version: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        is_active: bool,
        protocol_fee: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg1),
            package_version : 1,
            is_active       : false,
            protocol_fee    : arg0,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    public(friend) fun assert_active(arg0: &GlobalConfig) {
        assert!(arg0.is_active, 3);
    }

    public(friend) fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    public fun info(arg0: &GlobalConfig) : (u64, bool, u64) {
        (arg0.package_version, arg0.is_active, arg0.protocol_fee)
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

    public(friend) fun set_protocol_fee(arg0: &mut GlobalConfig, arg1: u64) {
        arg0.protocol_fee = arg1;
    }

    // decompiled from Move bytecode v6
}

