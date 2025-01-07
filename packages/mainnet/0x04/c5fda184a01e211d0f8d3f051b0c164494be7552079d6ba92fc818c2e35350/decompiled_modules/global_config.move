module 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::global_config {
    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        protocol_fee: u64,
    }

    public fun check_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    public fun get_global_config_info(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee
    }

    public(friend) fun new_global_config(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg1),
            package_version : 1,
            protocol_fee    : arg0,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    entry fun set_package_version(arg0: &mut 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::permission::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        let v0 = arg1.package_version;
        assert!(arg2 > v0, 2);
        arg1.package_version = arg2;
        let v1 = SetPackageVersion{
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    entry fun set_protocol_fee(arg0: &mut 0x4c5fda184a01e211d0f8d3f051b0c164494be7552079d6ba92fc818c2e35350::permission::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.protocol_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

