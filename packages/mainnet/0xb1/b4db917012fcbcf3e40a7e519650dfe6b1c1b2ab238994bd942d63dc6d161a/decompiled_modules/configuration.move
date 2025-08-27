module 0xb1b4db917012fcbcf3e40a7e519650dfe6b1c1b2ab238994bd942d63dc6d161a::configuration {
    struct Configuration has key {
        id: 0x2::object::UID,
        admin: address,
        package_version: u64,
        verifier_pubkey: vector<u8>,
    }

    struct AdminChangedEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct ConfigurationInitEvent has copy, drop {
        id: 0x2::object::ID,
        admin: address,
        package_version: u64,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun check_package_version(arg0: &Configuration) {
        assert!(arg0.package_version == 1, 2000);
    }

    public(friend) fun get_admin(arg0: &Configuration) : address {
        arg0.admin
    }

    public(friend) fun get_verifier_pubkey(arg0: &Configuration) : vector<u8> {
        arg0.verifier_pubkey
    }

    public(friend) fun new_configuration_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Configuration{
            id              : 0x2::object::new(arg0),
            admin           : 0x2::tx_context::sender(arg0),
            package_version : 1,
            verifier_pubkey : 0x1::vector::empty<u8>(),
        };
        let v1 = 0x2::object::id<Configuration>(&v0);
        let v2 = ConfigurationInitEvent{
            id              : v1,
            admin           : 0x2::tx_context::sender(arg0),
            package_version : 1,
        };
        0x2::event::emit<ConfigurationInitEvent>(v2);
        0x2::transfer::share_object<Configuration>(v0);
        v1
    }

    public fun set_verifier_pubkey(arg0: &mut Configuration, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg2);
        arg0.verifier_pubkey = arg1;
    }

    public fun transfer_admin_cap(arg0: &mut Configuration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg2);
        arg0.admin = arg1;
        let v0 = AdminChangedEvent{
            old_admin : 0x2::tx_context::sender(arg2),
            new_admin : arg1,
        };
        0x2::event::emit<AdminChangedEvent>(v0);
    }

    public fun update_package_version(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg2);
        arg0.package_version = arg1;
        let v0 = SetPackageVersion{
            new_version : arg1,
            old_version : arg0.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public(friend) fun validate_admin(arg0: &Configuration, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2001);
    }

    // decompiled from Move bytecode v6
}

