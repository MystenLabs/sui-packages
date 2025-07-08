module 0x2::dynamic_field {
    struct Field<T0: copy + drop + store, T1: store> has key {
        id: 0x2::object::UID,
        name: T0,
        value: T1,
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: T0) : &T1 {
        &borrow_child_object<Field<T0, T1>>(arg0, hash_type_and_key<T0>(0x2::object::uid_to_address(arg0), arg1)).value
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : &mut T1 {
        let v0 = hash_type_and_key<T0>(0x2::object::uid_to_address(arg0), arg1);
        &mut borrow_child_object_mut<Field<T0, T1>>(arg0, v0).value
    }

    public fun add<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        let v0 = 0x2::object::uid_to_address(arg0);
        let v1 = hash_type_and_key<T0>(v0, arg1);
        assert!(!has_child_object(v0, v1), 0);
        let v2 = Field<T0, T1>{
            id    : 0x2::object::new_uid_from_hash(v1),
            name  : arg1,
            value : arg2,
        };
        add_child_object<Field<T0, T1>>(v0, v2);
    }

    native public(friend) fun add_child_object<T0: key>(arg0: address, arg1: T0);
    native public(friend) fun borrow_child_object<T0: key>(arg0: &0x2::object::UID, arg1: address) : &T0;
    native public(friend) fun borrow_child_object_mut<T0: key>(arg0: &mut 0x2::object::UID, arg1: address) : &mut T0;
    public fun exists_<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : bool {
        let v0 = 0x2::object::uid_to_address(arg0);
        has_child_object(v0, hash_type_and_key<T0>(v0, arg1))
    }

    public fun exists_with_type<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: T0) : bool {
        let v0 = 0x2::object::uid_to_address(arg0);
        has_child_object_with_ty<Field<T0, T1>>(v0, hash_type_and_key<T0>(v0, arg1))
    }

    public(friend) fun field_info<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : (&0x2::object::UID, address) {
        let v0 = borrow_child_object<Field<T0, 0x2::object::ID>>(arg0, hash_type_and_key<T0>(0x2::object::uid_to_address(arg0), arg1));
        (&v0.id, 0x2::object::id_to_address(&v0.value))
    }

    public(friend) fun field_info_mut<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) : (&mut 0x2::object::UID, address) {
        let v0 = hash_type_and_key<T0>(0x2::object::uid_to_address(arg0), arg1);
        let v1 = borrow_child_object_mut<Field<T0, 0x2::object::ID>>(arg0, v0);
        (&mut v1.id, 0x2::object::id_to_address(&mut v1.value))
    }

    native public(friend) fun has_child_object(arg0: address, arg1: address) : bool;
    native public(friend) fun has_child_object_with_ty<T0: key>(arg0: address, arg1: address) : bool;
    native public(friend) fun hash_type_and_key<T0: copy + drop + store>(arg0: address, arg1: T0) : address;
    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let v0 = 0x2::object::uid_to_address(arg0);
        let Field {
            id    : v1,
            name  : _,
            value : v3,
        } = remove_child_object<Field<T0, T1>>(v0, hash_type_and_key<T0>(v0, arg1));
        0x2::object::delete(v1);
        v3
    }

    native public(friend) fun remove_child_object<T0: key>(arg0: address, arg1: address) : T0;
    public fun remove_if_exists<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : 0x1::option::Option<T1> {
        if (exists_<T0>(arg0, arg1)) {
            0x1::option::some<T1>(remove<T0, T1>(arg0, arg1))
        } else {
            0x1::option::none<T1>()
        }
    }

    // decompiled from Move bytecode v6
}

