module 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::config {
    struct UpgradeEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct UpdateAccelerationFactorEvent has copy, drop {
        id: 0x2::object::ID,
        factor: u8,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::ACL,
        acceleration_factor: 0x2::table::Table<0x2::object::ID, u8>,
        pools: 0x2::table::Table<0x2::object::ID, bool>,
        package_version: u64,
    }

    public fun add_acceleration_factor(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext, arg2: 0x2::object::ID, arg3: u8) {
        checked_package_version(arg0);
        assert!(0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::operator_role()), 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::permission_denied());
        if (0x2::table::contains<0x2::object::ID, u8>(&arg0.acceleration_factor, arg2)) {
            0x2::table::remove<0x2::object::ID, u8>(&mut arg0.acceleration_factor, arg2);
        };
        0x2::table::add<0x2::object::ID, u8>(&mut arg0.acceleration_factor, arg2, arg3);
        let v0 = UpdateAccelerationFactorEvent{
            id     : arg2,
            factor : arg3,
        };
        0x2::event::emit<UpdateAccelerationFactorEvent>(v0);
    }

    public(friend) fun add_pool(arg0: &mut GlobalConfig, arg1: 0x2::object::ID) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pools, arg1, true);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::error::version_mismatch_error());
    }

    public fun get_acceleration_factor(arg0: &GlobalConfig, arg1: 0x2::object::ID) : u8 {
        if (0x2::table::contains<0x2::object::ID, u8>(&arg0.acceleration_factor, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u8>(&arg0.acceleration_factor, arg1)
        } else {
            1
        }
    }

    public fun get_acl(arg0: &GlobalConfig) : &0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::ACL {
        &arg0.acl
    }

    public(friend) fun has_pool(arg0: &GlobalConfig, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.pools, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                  : 0x2::object::new(arg0),
            acl                 : 0x7bfaae484d7b42982ade438d65a455472320a9070ef5275186622d0d3d526fad::acl::new(arg0),
            acceleration_factor : 0x2::table::new<0x2::object::ID, u8>(arg0),
            pools               : 0x2::table::new<0x2::object::ID, bool>(arg0),
            package_version     : 1,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public fun upgrade(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 1;
        arg0.package_version = v0;
        let v1 = UpgradeEvent{
            old_version : arg0.package_version,
            new_version : v0,
        };
        0x2::event::emit<UpgradeEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

