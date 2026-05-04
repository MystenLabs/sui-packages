module 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::acl {
    struct PermissionKey has copy, drop, store {
        permission: vector<u8>,
        operator: address,
    }

    struct GrantEvent has copy, drop, store {
        owner: 0x2::object::ID,
        permission: vector<u8>,
        operator: address,
    }

    struct RevokeEvent has copy, drop, store {
        owner: 0x2::object::ID,
        permission: vector<u8>,
        operator: address,
    }

    public(friend) fun assert_authorized(arg0: &0x2::object::UID, arg1: vector<u8>, arg2: address) {
        assert!(is_authorized(arg0, arg1, arg2), 0);
    }

    public(friend) fun grant(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: address) {
        let v0 = permission_key(arg1, arg2);
        if (!0x2::dynamic_field::exists_with_type<PermissionKey, bool>(arg0, v0)) {
            0x2::dynamic_field::add<PermissionKey, bool>(arg0, v0, true);
            let v1 = GrantEvent{
                owner      : 0x2::object::uid_to_inner(arg0),
                permission : arg1,
                operator   : arg2,
            };
            0x2::event::emit<GrantEvent>(v1);
        };
    }

    public(friend) fun is_authorized(arg0: &0x2::object::UID, arg1: vector<u8>, arg2: address) : bool {
        0x2::dynamic_field::exists_with_type<PermissionKey, bool>(arg0, permission_key(arg1, arg2))
    }

    fun permission_key(arg0: vector<u8>, arg1: address) : PermissionKey {
        PermissionKey{
            permission : arg0,
            operator   : arg1,
        }
    }

    public(friend) fun revoke(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: address) {
        let v0 = permission_key(arg1, arg2);
        if (0x2::dynamic_field::exists_with_type<PermissionKey, bool>(arg0, v0)) {
            0x2::dynamic_field::remove<PermissionKey, bool>(arg0, v0);
            let v1 = RevokeEvent{
                owner      : 0x2::object::uid_to_inner(arg0),
                permission : arg1,
                operator   : arg2,
            };
            0x2::event::emit<RevokeEvent>(v1);
        };
    }

    // decompiled from Move bytecode v7
}

