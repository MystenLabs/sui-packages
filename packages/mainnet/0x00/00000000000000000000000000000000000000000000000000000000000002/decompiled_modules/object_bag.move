module 0x2::object_bag {
    struct ObjectBag has store, key {
        id: 0x2::object::UID,
        size: u64,
    }

    public fun length(arg0: &ObjectBag) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: store + key>(arg0: &ObjectBag, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store + key>(arg0: &mut ObjectBag, arg1: T0) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun destroy_empty(arg0: ObjectBag) {
        let ObjectBag {
            id   : v0,
            size : v1,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun add<T0: copy + drop + store, T1: store + key>(arg0: &mut ObjectBag, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        arg0.size = arg0.size + 1;
    }

    public fun remove<T0: copy + drop + store, T1: store + key>(arg0: &mut ObjectBag, arg1: T0) : T1 {
        arg0.size = arg0.size - 1;
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ObjectBag {
        ObjectBag{
            id   : 0x2::object::new(arg0),
            size : 0,
        }
    }

    public fun contains<T0: copy + drop + store>(arg0: &ObjectBag, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun contains_with_type<T0: copy + drop + store, T1: store + key>(arg0: &ObjectBag, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public fun is_empty(arg0: &ObjectBag) : bool {
        arg0.size == 0
    }

    public fun value_id<T0: copy + drop + store>(arg0: &ObjectBag, arg1: T0) : 0x1::option::Option<0x2::object::ID> {
        0x2::dynamic_object_field::id<T0>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

