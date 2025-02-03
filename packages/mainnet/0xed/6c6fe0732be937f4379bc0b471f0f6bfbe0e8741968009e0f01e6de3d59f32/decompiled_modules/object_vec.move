module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_vec {
    struct ObjectVec<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        size: u64,
    }

    public fun length<T0: store + key>(arg0: &ObjectVec<T0>) : u64 {
        arg0.size
    }

    public fun borrow<T0: store + key>(arg0: &ObjectVec<T0>, arg1: u64) : &T0 {
        0x2::dynamic_object_field::borrow<u64, T0>(&arg0.id, arg1)
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut ObjectVec<T0>, arg1: u64) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<u64, T0>(&mut arg0.id, arg1)
    }

    public fun destroy_empty<T0: store + key>(arg0: ObjectVec<T0>) {
        let ObjectVec {
            id   : v0,
            size : v1,
        } = arg0;
        assert!(v1 == 0, 524296);
        0x2::object::delete(v0);
    }

    public fun add<T0: store + key>(arg0: &mut ObjectVec<T0>, arg1: T0) {
        0x2::dynamic_object_field::add<u64, T0>(&mut arg0.id, arg0.size + 1, arg1);
        arg0.size = arg0.size + 1;
    }

    public fun remove<T0: store + key>(arg0: &mut ObjectVec<T0>, arg1: u64) : T0 {
        arg0.size = arg0.size - 1;
        0x2::dynamic_object_field::remove<u64, T0>(&mut arg0.id, arg1)
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : ObjectVec<T0> {
        ObjectVec<T0>{
            id   : 0x2::object::new(arg0),
            size : 0,
        }
    }

    public fun contains<T0: store + key>(arg0: &ObjectVec<T0>, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)
    }

    public fun is_empty<T0: store + key>(arg0: &ObjectVec<T0>) : bool {
        arg0.size == 0
    }

    public fun value_id<T0: store + key>(arg0: &ObjectVec<T0>, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        0x2::dynamic_object_field::id<u64>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

