module 0x663012c11fd49ce0c833e2e33e2d0ebd6af8fc5e632c9807290426fdd47a7fdc::blast_presale_admin {
    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct AdminCapReplaced has copy, drop {
        previous_admin_cap_id: 0x1::option::Option<0x2::object::ID>,
        admin_cap_id: 0x2::object::ID,
    }

    struct AdminCapRevoked has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    public(friend) fun assert_admin_cap(arg0: &AdminRegistry, arg1: &AdminCap) {
        assert!(arg0.admin_cap_id == 0x1::option::some<0x2::object::ID>(0x2::object::id<AdminCap>(arg1)), 13835058428944318465);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = AdminRegistry{
            id           : 0x2::object::new(arg0),
            admin_cap_id : 0x1::option::some<0x2::object::ID>(0x2::object::id<AdminCap>(&v0)),
        };
        let v2 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AdminRegistry>(v1);
    }

    public fun replace_admin_cap(arg0: &mut AdminRegistry, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        arg0.admin_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<AdminCap>(&v0));
        let v1 = AdminCapReplaced{
            previous_admin_cap_id : arg0.admin_cap_id,
            admin_cap_id          : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::event::emit<AdminCapReplaced>(v1);
        v0
    }

    public fun revoke_admin_cap(arg0: &mut AdminRegistry, arg1: &SuperAdminCap) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.admin_cap_id), 13835339826611748867);
        let v0 = AdminCapRevoked{admin_cap_id: 0x1::option::extract<0x2::object::ID>(&mut arg0.admin_cap_id)};
        0x2::event::emit<AdminCapRevoked>(v0);
    }

    public fun transfer_super_admin(arg0: SuperAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 13835621340243296261);
        0x2::transfer::transfer<SuperAdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

