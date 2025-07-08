module 0x2::bag {
    struct Bag has store, key {
        id: 0x2::object::UID,
        size: u64,
    }

    public fun length(arg0: &Bag) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &Bag, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut Bag, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun destroy_empty(arg0: Bag) {
        let Bag {
            id   : v0,
            size : v1,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun add<T0: copy + drop + store, T1: store>(arg0: &mut Bag, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        arg0.size = arg0.size + 1;
    }

    public fun contains<T0: copy + drop + store>(arg0: &Bag, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun contains_with_type<T0: copy + drop + store, T1: store>(arg0: &Bag, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public fun is_empty(arg0: &Bag) : bool {
        arg0.size == 0
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Bag {
        Bag{
            id   : 0x2::object::new(arg0),
            size : 0,
        }
    }

    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut Bag, arg1: T0) : T1 {
        arg0.size = arg0.size - 1;
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

