module 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config {
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
        vesca_key: 0x1::option::Option<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg1),
            package_version : 1,
            is_active       : false,
            protocol_fee    : arg0,
            vesca_key       : 0x1::option::none<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(),
        };
        0x2::transfer::public_share_object<GlobalConfig>(v0);
    }

    public(friend) fun assert_active(arg0: &GlobalConfig) {
        assert!(arg0.is_active, 3);
    }

    public(friend) fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    public(friend) fun borrow_mut_vesca_key(arg0: &mut GlobalConfig) : &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey {
        0x1::option::borrow_mut<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&mut arg0.vesca_key)
    }

    public fun info(arg0: &GlobalConfig) : (u64, bool, u64, bool) {
        (arg0.package_version, arg0.is_active, arg0.protocol_fee, 0x1::option::is_some<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key))
    }

    public(friend) fun is_vesca_key_some(arg0: &GlobalConfig) : bool {
        0x1::option::is_some<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&arg0.vesca_key)
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

