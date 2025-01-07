module 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::global_config {
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
        assert!(arg0.package_version == 2, 1);
    }

    public fun get_global_config_info(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee
    }

    public(friend) fun new_global_config(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg1),
            package_version : 2,
            protocol_fee    : arg0,
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    entry fun set_package_version(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        let v0 = arg1.package_version;
        assert!(arg2 > v0, 2);
        arg1.package_version = arg2;
        let v1 = SetPackageVersion{
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    entry fun set_protocol_fee(arg0: &mut 0xbd2576d54613eb60ab2764612fcaf041df60c76f486f0c44167f3b9952bdf3a1::permission::AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.protocol_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

