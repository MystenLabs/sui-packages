module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::id {
    struct PermissionID has copy, drop, store {
        id: u64,
    }

    struct RoleID has copy, drop, store {
        id: u64,
    }

    struct QueryID<T0> has copy, drop {
        id: T0,
        is_ref: bool,
    }

    public fun deserialize_permission_id(arg0: &mut 0x2::bcs::BCS) : PermissionID {
        PermissionID{id: 0x2::bcs::peel_u64(arg0)}
    }

    public fun deserialize_permission_query_id(arg0: &mut 0x2::bcs::BCS) : QueryID<PermissionID> {
        let v0 = deserialize_permission_id(arg0);
        QueryID<PermissionID>{
            id     : v0,
            is_ref : 0x2::bcs::peel_bool(arg0),
        }
    }

    public fun deserialize_role_id(arg0: &mut 0x2::bcs::BCS) : RoleID {
        RoleID{id: 0x2::bcs::peel_u64(arg0)}
    }

    public fun deserialize_role_query_id(arg0: &mut 0x2::bcs::BCS) : QueryID<RoleID> {
        let v0 = deserialize_role_id(arg0);
        QueryID<RoleID>{
            id     : v0,
            is_ref : 0x2::bcs::peel_bool(arg0),
        }
    }

    public fun deserialize_vec_permission_query_id(arg0: &mut 0x2::bcs::BCS) : vector<QueryID<PermissionID>> {
        let v0 = 0x1::vector::empty<QueryID<PermissionID>>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            0x1::vector::push_back<QueryID<PermissionID>>(&mut v0, deserialize_permission_query_id(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_id<T0>(arg0: &QueryID<T0>) : &T0 {
        assert!(!arg0.is_ref, 1001);
        &arg0.id
    }

    public fun get_permission_ref(arg0: &QueryID<PermissionID>) : u64 {
        assert!(arg0.is_ref, 1000);
        arg0.id.id
    }

    public fun get_role_ref(arg0: &QueryID<RoleID>) : u64 {
        assert!(arg0.is_ref, 1000);
        arg0.id.id
    }

    public fun is_ref<T0>(arg0: &QueryID<T0>) : bool {
        arg0.is_ref
    }

    public fun new_permission_id(arg0: u64) : PermissionID {
        PermissionID{id: arg0}
    }

    public fun new_role_id(arg0: u64) : RoleID {
        RoleID{id: arg0}
    }

    // decompiled from Move bytecode v6
}

