module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box {
    struct ObjectBox has store, key {
        id: 0x2::object::UID,
        len: u64,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : ObjectBox {
        ObjectBox{
            id  : 0x2::object::new(arg0),
            len : 0,
        }
    }

    public fun borrow<T0: store + key>(arg0: &ObjectBox) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, T0>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut ObjectBox) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, T0>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public fun add<T0: store + key>(arg0: &mut ObjectBox, arg1: T0) {
        assert!(arg0.len == 0, 395008);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, T0>(&mut arg0.id, 0x1::type_name::get<T0>(), arg1);
        arg0.len = arg0.len + 1;
    }

    public fun remove<T0: store + key>(arg0: &mut ObjectBox) : T0 {
        arg0.len = arg0.len - 1;
        0x2::dynamic_object_field::remove<0x1::type_name::TypeName, T0>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public fun new<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : ObjectBox {
        let v0 = ObjectBox{
            id  : 0x2::object::new(arg1),
            len : 0,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, T0>(&mut v0.id, 0x1::type_name::get<T0>(), arg0);
        v0.len = 1;
        v0
    }

    public fun has_object<T0: store + key>(arg0: &ObjectBox) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun is_empty(arg0: &ObjectBox) : bool {
        arg0.len == 0
    }

    // decompiled from Move bytecode v6
}

