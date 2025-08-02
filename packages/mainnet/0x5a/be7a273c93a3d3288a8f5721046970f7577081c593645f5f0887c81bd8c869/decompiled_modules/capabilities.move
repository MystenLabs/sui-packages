module 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::capabilities {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResolverCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResolverCapGranted has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        granted_by: address,
    }

    struct ResolverCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        revoked_by: address,
    }

    public fun get_admin_cap_id(arg0: &AdminCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_resolver_cap_id(arg0: &ResolverCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public entry fun grant_resolver_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolverCap{id: 0x2::object::new(arg2)};
        let v1 = ResolverCapGranted{
            cap_id     : 0x2::object::uid_to_inner(&v0.id),
            recipient  : arg1,
            granted_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ResolverCapGranted>(v1);
        0x2::transfer::transfer<ResolverCap>(v0, arg1);
    }

    public fun has_resolver_cap(arg0: &ResolverCap) : bool {
        true
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = ResolverCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::transfer<ResolverCap>(v2, v0);
    }

    public entry fun revoke_resolver_cap(arg0: &AdminCap, arg1: ResolverCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ResolverCapRevoked{
            cap_id     : 0x2::object::uid_to_inner(&arg1.id),
            revoked_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ResolverCapRevoked>(v0);
        let ResolverCap { id: v1 } = arg1;
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

