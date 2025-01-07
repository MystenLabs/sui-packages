module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils {
    struct Marker<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct IDMarker<phantom T0> has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun as_id<T0: key>(arg0: &IDMarker<T0>) : &0x2::object::ID {
        &arg0.id
    }

    public fun equals_object<T0: key>(arg0: &IDMarker<T0>, arg1: &T0) : bool {
        arg0.id == 0x2::object::id<T0>(arg1)
    }

    public fun id_marker<T0: key>(arg0: &T0) : IDMarker<T0> {
        IDMarker<T0>{id: 0x2::object::id<T0>(arg0)}
    }

    public fun marker<T0>() : Marker<T0> {
        Marker<T0>{dummy_field: false}
    }

    public fun to_id<T0: key>(arg0: IDMarker<T0>) : 0x2::object::ID {
        let IDMarker { id: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

