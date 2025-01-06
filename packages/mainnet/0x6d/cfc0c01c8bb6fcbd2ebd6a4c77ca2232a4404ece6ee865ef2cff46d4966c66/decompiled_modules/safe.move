module 0x6dcfc0c01c8bb6fcbd2ebd6a4c77ca2232a4404ece6ee865ef2cff46d4966c66::safe {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Safe<T0> has key {
        id: 0x2::object::UID,
        owner_cap_id: 0x2::object::ID,
        authorized_object_id: 0x1::option::Option<0x2::object::ID>,
        obj: T0,
    }

    public fun assert_authorization<T0>(arg0: &Safe<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.authorized_object_id), 2);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&arg0.authorized_object_id), 1);
    }

    public fun authorize<T0>(arg0: &mut Safe<T0>, arg1: &OwnerCap, arg2: 0x2::object::ID) {
        assert!(0x2::object::id<OwnerCap>(arg1) == arg0.owner_cap_id, 0);
        arg0.authorized_object_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public fun borrow_obj<T0>(arg0: &Safe<T0>) : &T0 {
        &arg0.obj
    }

    public fun borrow_obj_mut<T0>(arg0: &mut Safe<T0>, arg1: &0x2::object::UID) : &mut T0 {
        assert_authorization<T0>(arg0, 0x2::object::uid_to_inner(arg1));
        &mut arg0.obj
    }

    public fun create<T0: store>(arg0: T0, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg2)};
        let v1 = Safe<T0>{
            id                   : 0x2::object::new(arg2),
            owner_cap_id         : 0x2::object::id<OwnerCap>(&v0),
            authorized_object_id : arg1,
            obj                  : arg0,
        };
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Safe<T0>>(v1);
    }

    public fun revoke_auth<T0>(arg0: &mut Safe<T0>, arg1: &OwnerCap) {
        assert!(0x2::object::id<OwnerCap>(arg1) == arg0.owner_cap_id, 0);
        arg0.authorized_object_id = 0x1::option::none<0x2::object::ID>();
    }

    // decompiled from Move bytecode v6
}

