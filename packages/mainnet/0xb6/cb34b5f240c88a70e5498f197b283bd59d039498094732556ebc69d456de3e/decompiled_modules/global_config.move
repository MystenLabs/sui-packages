module 0x473c220d79b49b847ddac4ec7e237f15f50720ab28d7e895079530697c16b35f::global_config {
    struct SetPackageVersion has copy, drop {
        sender: address,
        new_version: u64,
        old_version: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        protocol_fee: u64,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg1),
            package_version : 1,
            protocol_fee    : arg0,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    public fun check_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    public fun get_info(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee
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

