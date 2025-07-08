module 0x2::dynamic_object_field {
    struct Wrapper<T0> has copy, drop, store {
        name: T0,
    }

    public fun borrow<T0: copy + drop + store, T1: store + key>(arg0: &0x2::object::UID, arg1: T0) : &T1 {
        let v0 = Wrapper<T0>{name: arg1};
        let (v1, v2) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::borrow_child_object<T1>(v1, v2)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store + key>(arg0: &mut 0x2::object::UID, arg1: T0) : &mut T1 {
        let v0 = Wrapper<T0>{name: arg1};
        let (v1, v2) = 0x2::dynamic_field::field_info_mut<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::borrow_child_object_mut<T1>(v1, v2)
    }

    public fun add<T0: copy + drop + store, T1: store + key>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        let v0 = Wrapper<T0>{name: arg1};
        0x2::dynamic_field::add<Wrapper<T0>, 0x2::object::ID>(arg0, v0, 0x2::object::id<T1>(&arg2));
        let (v1, _) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::add_child_object<T1>(0x2::object::uid_to_address(v1), arg2);
    }

    public fun exists_with_type<T0: copy + drop + store, T1: store + key>(arg0: &0x2::object::UID, arg1: T0) : bool {
        let v0 = Wrapper<T0>{name: arg1};
        if (!0x2::dynamic_field::exists_with_type<Wrapper<T0>, 0x2::object::ID>(arg0, v0)) {
            false
        } else {
            let (v2, v3) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
            0x2::dynamic_field::has_child_object_with_ty<T1>(0x2::object::uid_to_address(v2), v3)
        }
    }

    public fun remove<T0: copy + drop + store, T1: store + key>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let v0 = Wrapper<T0>{name: arg1};
        let (v1, v2) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::remove<Wrapper<T0>, 0x2::object::ID>(arg0, v0);
        0x2::dynamic_field::remove_child_object<T1>(0x2::object::uid_to_address(v1), v2)
    }

    public fun exists_<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : bool {
        let v0 = Wrapper<T0>{name: arg1};
        0x2::dynamic_field::exists_with_type<Wrapper<T0>, 0x2::object::ID>(arg0, v0)
    }

    public fun id<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : 0x1::option::Option<0x2::object::ID> {
        let v0 = Wrapper<T0>{name: arg1};
        if (!0x2::dynamic_field::exists_with_type<Wrapper<T0>, 0x2::object::ID>(arg0, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let (_, v2) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
        0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(v2))
    }

    public(friend) fun internal_add<T0: copy + drop + store, T1: key>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        let v0 = Wrapper<T0>{name: arg1};
        0x2::dynamic_field::add<Wrapper<T0>, 0x2::object::ID>(arg0, v0, 0x2::object::id<T1>(&arg2));
        let (v1, _) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::add_child_object<T1>(0x2::object::uid_to_address(v1), arg2);
    }

    public(friend) fun internal_borrow<T0: copy + drop + store, T1: key>(arg0: &0x2::object::UID, arg1: T0) : &T1 {
        let v0 = Wrapper<T0>{name: arg1};
        let (v1, v2) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::borrow_child_object<T1>(v1, v2)
    }

    public(friend) fun internal_borrow_mut<T0: copy + drop + store, T1: key>(arg0: &mut 0x2::object::UID, arg1: T0) : &mut T1 {
        let v0 = Wrapper<T0>{name: arg1};
        let (v1, v2) = 0x2::dynamic_field::field_info_mut<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::borrow_child_object_mut<T1>(v1, v2)
    }

    public(friend) fun internal_exists_with_type<T0: copy + drop + store, T1: key>(arg0: &0x2::object::UID, arg1: T0) : bool {
        let v0 = Wrapper<T0>{name: arg1};
        if (!0x2::dynamic_field::exists_with_type<Wrapper<T0>, 0x2::object::ID>(arg0, v0)) {
            false
        } else {
            let (v2, v3) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
            0x2::dynamic_field::has_child_object_with_ty<T1>(0x2::object::uid_to_address(v2), v3)
        }
    }

    public(friend) fun internal_remove<T0: copy + drop + store, T1: key>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let v0 = Wrapper<T0>{name: arg1};
        let (v1, v2) = 0x2::dynamic_field::field_info<Wrapper<T0>>(arg0, v0);
        0x2::dynamic_field::remove<Wrapper<T0>, 0x2::object::ID>(arg0, v0);
        0x2::dynamic_field::remove_child_object<T1>(0x2::object::uid_to_address(v1), v2)
    }

    // decompiled from Move bytecode v6
}

