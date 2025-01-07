module 0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::config {
    struct ConfigVersion has store, key {
        id: 0x2::object::UID,
        package_version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        config_cap_id: 0x2::object::ID,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun checked_package_version(arg0: &ConfigVersion) {
        assert!(arg0.package_version == 1, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_admin_cap(arg0);
        let (v2, v3) = new_config_cap(arg0);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ConfigVersion>(v2);
        let v4 = InitConfigEvent{
            admin_cap_id  : v1,
            config_cap_id : v3,
        };
        0x2::event::emit<InitConfigEvent>(v4);
    }

    fun new_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : (AdminCap, 0x2::object::ID) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCap{id: v0};
        (v1, 0x2::object::uid_to_inner(&v0))
    }

    fun new_config_cap(arg0: &mut 0x2::tx_context::TxContext) : (ConfigVersion, 0x2::object::ID) {
        let v0 = 0x2::object::new(arg0);
        let v1 = ConfigVersion{
            id              : v0,
            package_version : 1,
        };
        (v1, 0x2::object::uid_to_inner(&v0))
    }

    public entry fun update_package_version(arg0: &AdminCap, arg1: &mut ConfigVersion, arg2: u64) {
        checked_package_version(arg1);
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    // decompiled from Move bytecode v6
}

