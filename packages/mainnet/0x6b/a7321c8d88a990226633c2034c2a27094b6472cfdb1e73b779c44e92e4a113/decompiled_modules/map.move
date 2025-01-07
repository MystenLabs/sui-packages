module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::map {
    struct Map<T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        index: vector<T0>,
    }

    struct Iter<T0> has drop {
        for: 0x2::object::ID,
        keys: vector<T0>,
    }

    public fun empty<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::tx_context::TxContext) : Map<T0, T1> {
        Map<T0, T1>{
            id    : 0x2::object::new(arg0),
            index : 0x1::vector::empty<T0>(),
        }
    }

    public fun length<T0: copy + drop + store, T1: store>(arg0: &Map<T0, T1>) : u64 {
        0x1::vector::length<T0>(&arg0.index)
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &Map<T0, T1>, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut Map<T0, T1>, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut Map<T0, T1>, arg1: T0) : T1 {
        remove_from_index<T0, T1>(arg0, arg1);
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun add<T0: copy + drop + store, T1: store>(arg0: &mut Map<T0, T1>, arg1: T0, arg2: T1) {
        add_to_index<T0, T1>(arg0, arg1);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun delete<T0: copy + drop + store, T1: drop + store>(arg0: Map<T0, T1>) {
        let Map {
            id    : v0,
            index : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<T0>(&v2)) {
            0x2::dynamic_field::remove<T0, T1>(&mut v3, *0x1::vector::borrow<T0>(&v2, v4));
            v4 = v4 + 1;
        };
        0x2::object::delete(v3);
    }

    fun add_to_index<T0: drop, T1>(arg0: &mut Map<T0, T1>, arg1: T0) {
        assert!(!0x1::vector::contains<T0>(&arg0.index, &arg1), 0);
        assert!(0x1::vector::length<T0>(&arg0.index) < 65536, 2);
        0x1::vector::push_back<T0>(&mut arg0.index, arg1);
    }

    public fun delete_empty<T0: copy + drop + store, T1: store>(arg0: Map<T0, T1>) {
        assert!(0x1::vector::length<T0>(&arg0.index) == 0, 3);
        let Map {
            id    : v0,
            index : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun exists_<T0: copy + drop + store, T1: store>(arg0: &Map<T0, T1>, arg1: T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(&arg0.index, &arg1);
        v0
    }

    public fun into_keys<T0: copy + drop + store, T1: store>(arg0: &Map<T0, T1>) : vector<T0> {
        arg0.index
    }

    public fun iter<T0: copy + drop + store, T1: store>(arg0: &Map<T0, T1>) : Iter<T0> {
        Iter<T0>{
            for  : 0x2::object::uid_to_inner(&arg0.id),
            keys : arg0.index,
        }
    }

    public fun next<T0: copy + drop + store, T1: store>(arg0: &Map<T0, T1>, arg1: &mut Iter<T0>) : 0x1::option::Option<T0> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.for, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg1.keys)) {
            let v1 = 0x1::vector::remove<T0>(&mut arg1.keys, 0);
            if (exists_<T0, T1>(arg0, v1)) {
                return 0x1::option::some<T0>(v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<T0>()
    }

    fun remove_from_index<T0: drop, T1>(arg0: &mut Map<T0, T1>, arg1: T0) {
        let (v0, v1) = 0x1::vector::index_of<T0>(&arg0.index, &arg1);
        if (v0) {
            0x1::vector::remove<T0>(&mut arg0.index, v1);
        };
    }

    // decompiled from Move bytecode v6
}

