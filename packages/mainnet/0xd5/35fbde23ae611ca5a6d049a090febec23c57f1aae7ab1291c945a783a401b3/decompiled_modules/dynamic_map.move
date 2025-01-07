module 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map {
    struct DynamicMap<phantom T0: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        size: u64,
    }

    public fun length<T0: copy + drop + store>(arg0: &DynamicMap<T0>) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DynamicMap<T0>, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DynamicMap<T0>, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun destroy_empty<T0: copy + drop + store>(arg0: DynamicMap<T0>) {
        let DynamicMap {
            id   : v0,
            size : v1,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun remove<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DynamicMap<T0>, arg1: T0) : T1 {
        arg0.size = arg0.size - 1;
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : DynamicMap<T0> {
        DynamicMap<T0>{
            id   : 0x2::object::new(arg0),
            size : 0,
        }
    }

    public fun contains<T0: copy + drop + store>(arg0: &DynamicMap<T0>, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun force_drop<T0: copy + drop + store>(arg0: DynamicMap<T0>) {
        let DynamicMap {
            id   : v0,
            size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun insert<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DynamicMap<T0>, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        arg0.size = arg0.size + 1;
    }

    public fun is_empty<T0: copy + drop + store>(arg0: &DynamicMap<T0>) : bool {
        arg0.size == 0
    }

    // decompiled from Move bytecode v6
}

