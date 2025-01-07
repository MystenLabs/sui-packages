module 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::enumerable_set_ring {
    struct EnnumerableSetRing<T0: copy + drop + store> has store {
        list: vector<T0>,
        map: 0x2::table::Table<T0, u64>,
        pointer: u64,
        capacity: u64,
    }

    public fun length<T0: copy + drop + store>(arg0: &EnnumerableSetRing<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.list)
    }

    public fun add<T0: copy + drop + store>(arg0: &mut EnnumerableSetRing<T0>, arg1: T0) {
        assert!(!contains<T0>(arg0, arg1), 0);
        if (0x1::vector::length<T0>(&arg0.list) == arg0.capacity) {
            let v0 = 0x1::vector::borrow_mut<T0>(&mut arg0.list, arg0.pointer);
            0x2::table::remove<T0, u64>(&mut arg0.map, *v0);
            *v0 = arg1;
        } else {
            0x1::vector::push_back<T0>(&mut arg0.list, arg1);
        };
        0x2::table::add<T0, u64>(&mut arg0.map, arg1, arg0.pointer);
        arg0.pointer = (arg0.pointer + 1) % arg0.capacity;
    }

    public fun contains<T0: copy + drop + store>(arg0: &EnnumerableSetRing<T0>, arg1: T0) : bool {
        0x2::table::contains<T0, u64>(&arg0.map, arg1)
    }

    public fun new<T0: copy + drop + store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : EnnumerableSetRing<T0> {
        EnnumerableSetRing<T0>{
            list     : 0x1::vector::empty<T0>(),
            map      : 0x2::table::new<T0, u64>(arg1),
            pointer  : 0,
            capacity : arg0,
        }
    }

    public fun add_all<T0: copy + drop + store>(arg0: &mut EnnumerableSetRing<T0>, arg1: vector<T0>) {
        assert!(!0x1::vector::is_empty<T0>(&arg1), 1);
        assert!(0x1::vector::length<T0>(&arg1) <= arg0.capacity, 2);
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            add<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1));
        };
    }

    public fun destroy<T0: copy + drop + store>(arg0: &mut EnnumerableSetRing<T0>) {
        while (!0x1::vector::is_empty<T0>(&arg0.list)) {
            0x2::table::remove<T0, u64>(&mut arg0.map, 0x1::vector::pop_back<T0>(&mut arg0.list));
        };
        arg0.pointer = 0;
    }

    public fun list<T0: copy + drop + store>(arg0: &EnnumerableSetRing<T0>) : vector<T0> {
        arg0.list
    }

    // decompiled from Move bytecode v6
}

