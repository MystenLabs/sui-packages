module 0x85769d63565ce99c7622f8e336ca1460926ddf29738ad2a39407b5cac29f61fe::typed_id {
    struct TypedID<phantom T0: key> has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun as_id<T0: key>(arg0: &TypedID<T0>) : &0x2::object::ID {
        &arg0.id
    }

    public fun equals_object<T0: key>(arg0: &TypedID<T0>, arg1: &T0) : bool {
        arg0.id == 0x2::object::id<T0>(arg1)
    }

    public fun new<T0: key>(arg0: &T0) : TypedID<T0> {
        TypedID<T0>{id: 0x2::object::id<T0>(arg0)}
    }

    public fun to_id<T0: key>(arg0: TypedID<T0>) : 0x2::object::ID {
        let TypedID { id: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

