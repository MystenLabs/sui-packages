module 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::router {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    struct RouterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Router has store, key {
        id: 0x2::object::UID,
        package_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    fun init(arg0: ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ROUTER>(arg0, arg1);
        let v0 = RouterAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<RouterAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Router{
            id                : 0x2::object::new(arg1),
            package_whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::public_share_object<Router>(v1);
    }

    public(friend) fun is_package_whitelisted<T0: drop>(arg0: &Router) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.package_whitelist, &v0)
    }

    public fun update_package_whitelist<T0: drop>(arg0: &RouterAdminCap, arg1: &mut Router, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg2) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.package_whitelist, &v0);
        } else {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.package_whitelist, v0);
        };
    }

    // decompiled from Move bytecode v6
}

