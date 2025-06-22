module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::arttoo {
    struct Registry has key {
        id: 0x2::object::UID,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
        roles: 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleStore,
        treasury_store: 0x2::object::ID,
    }

    public fun add_admin(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::add_capability<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(&mut arg0.roles, arg1, 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::new_admin(), arg2);
    }

    public fun add_compatible_version(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::has_cap<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(&arg0.roles, 0x2::tx_context::sender(arg2)), 5);
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, arg1);
    }

    public fun add_super_admin(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::add_capability<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(&mut arg0.roles, arg1, 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::new_super_admin(), arg2);
    }

    public fun admin_proof(arg0: &Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin> {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::create_role_proof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(&arg0.roles, arg1)
    }

    public fun assert_version_compatibility(arg0: &Registry) {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::versioning::assert_object_version_is_compatible_with_package(arg0.compatible_versions);
    }

    public fun get_compatible_versions(arg0: &Registry) : 0x2::vec_set::VecSet<u64> {
        arg0.compatible_versions
    }

    public fun has_cap<T0: store>(arg0: &Registry, arg1: address) : bool {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::has_cap<T0>(&arg0.roles, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store::new(arg0);
        let v1 = Registry{
            id                  : 0x2::object::new(arg0),
            compatible_versions : 0x2::vec_set::singleton<u64>(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::versioning::current_version()),
            roles               : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::new(arg0),
            treasury_store      : 0x2::object::id<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store::TreasuryStore>(&v0),
        };
        0x2::transfer::share_object<Registry>(v1);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store::share(v0);
    }

    public fun is_version_compatible(arg0: &Registry, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.compatible_versions, &arg1)
    }

    public fun remove_admin(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::remove_capability<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(&mut arg0.roles, arg1, arg2);
    }

    public fun remove_compatible_version(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::has_cap<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(&arg0.roles, 0x2::tx_context::sender(arg2)), 5);
        assert!(0x2::vec_set::contains<u64>(&arg0.compatible_versions, &arg1), 6);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &arg1);
    }

    public fun remove_super_admin(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::remove_capability<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(&mut arg0.roles, arg1, arg2);
    }

    public fun super_admin_proof(arg0: &Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin> {
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::create_role_proof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(&arg0.roles, arg1)
    }

    public fun treasury_id(arg0: &Registry) : 0x2::object::ID {
        arg0.treasury_store
    }

    // decompiled from Move bytecode v6
}

