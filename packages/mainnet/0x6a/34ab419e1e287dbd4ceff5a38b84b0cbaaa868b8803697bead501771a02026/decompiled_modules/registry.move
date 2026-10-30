module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        versioning: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::versioning::Versioning,
        roles: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::Roles,
        protocol_admin_count: u64,
    }

    public fun auth<T0: drop>(arg0: &Registry, arg1: &0x2::tx_context::TxContext) : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<Registry, T0> {
        assert_valid_version(arg0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::new<Registry, T0>(&arg0.roles, 0x2::tx_context::sender(arg1))
    }

    public fun assert_valid_version(arg0: &Registry) {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::versioning::assert_valid_version(&arg0.versioning);
    }

    public fun grant_protocol_admin(arg0: &mut Registry, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<Registry, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>, arg2: address) {
        if (grant_role<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>(arg0, arg2)) {
            arg0.protocol_admin_count = arg0.protocol_admin_count + 1;
        };
    }

    public fun roles(arg0: &Registry) : &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::Roles {
        &arg0.roles
    }

    fun grant_role<T0: drop>(arg0: &mut Registry, arg1: address) : bool {
        assert_valid_version(arg0);
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::grant<T0>(&mut arg0.roles, arg1);
        if (v0) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_granted(0x2::object::id<Registry>(arg0), 0x1::type_name::with_original_ids<T0>(), arg1);
        };
        v0
    }

    public fun grant_vault_creator(arg0: &mut Registry, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<Registry, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>, arg2: address) {
        grant_role<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::VaultCreatorRole>(arg0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::new(0x1::option::none<address>(), arg0);
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::grant<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                   : 0x2::object::new(arg0),
            versioning           : 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::versioning::new(),
            roles                : v0,
            protocol_admin_count : 1,
        };
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_granted(0x2::object::id<Registry>(&v1), 0x1::type_name::with_original_ids<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>(), 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun min_version(arg0: &Registry) : u64 {
        0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::versioning::min_version(&arg0.versioning)
    }

    public fun protocol_admin_count(arg0: &Registry) : u64 {
        arg0.protocol_admin_count
    }

    public fun retire_older_versions(arg0: &mut Registry) {
        assert_valid_version(arg0);
        if (0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::versioning::retire_older_versions(&mut arg0.versioning)) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_min_version_raised(0x2::object::id<Registry>(arg0), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::versioning::min_version(&arg0.versioning), 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::versioning::min_version(&arg0.versioning));
        };
    }

    public fun revoke_protocol_admin(arg0: &mut Registry, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<Registry, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>, arg2: address) {
        if (revoke_role<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>(arg0, arg2)) {
            assert!(arg0.protocol_admin_count > 1, 13835058523433598977);
            arg0.protocol_admin_count = arg0.protocol_admin_count - 1;
        };
    }

    fun revoke_role<T0: drop>(arg0: &mut Registry, arg1: address) : bool {
        assert_valid_version(arg0);
        let v0 = 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::revoke<T0>(&mut arg0.roles, arg1);
        if (v0) {
            0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::events::emit_role_revoked(0x2::object::id<Registry>(arg0), 0x1::type_name::with_original_ids<T0>(), arg1);
        };
        v0
    }

    public fun revoke_vault_creator(arg0: &mut Registry, arg1: &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::auth::Auth<Registry, 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::ProtocolAdminRole>, arg2: address) {
        revoke_role<0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles::VaultCreatorRole>(arg0, arg2);
    }

    public(friend) fun uid_mut(arg0: &mut Registry) : &mut 0x2::object::UID {
        assert_valid_version(arg0);
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

