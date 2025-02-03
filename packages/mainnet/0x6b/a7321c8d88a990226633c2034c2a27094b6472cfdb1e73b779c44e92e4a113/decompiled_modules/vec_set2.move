module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_set2 {
    struct VecSet<T0: copy + drop> has copy, drop, store {
        contents: vector<T0>,
    }

    public fun empty<T0: copy + drop>() : VecSet<T0> {
        VecSet<T0>{contents: 0x1::vector::empty<T0>()}
    }

    public fun remove<T0: copy + drop>(arg0: &mut VecSet<T0>, arg1: T0) {
        let v0 = get_index<T0>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::vector::remove<T0>(&mut arg0.contents, 0x1::option::destroy_some<u64>(v0));
        };
    }

    public fun add<T0: copy + drop>(arg0: &mut VecSet<T0>, arg1: T0) {
        let v0 = get_index<T0>(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            0x1::vector::push_back<T0>(&mut arg0.contents, arg1);
        };
    }

    public fun contains<T0: copy + drop>(arg0: &VecSet<T0>, arg1: T0) : bool {
        let v0 = get_index<T0>(arg0, arg1);
        0x1::option::is_some<u64>(&v0)
    }

    public fun create<T0: copy + drop>(arg0: vector<T0>) : VecSet<T0> {
        VecSet<T0>{contents: arg0}
    }

    public fun get_index<T0: copy + drop>(arg0: &VecSet<T0>, arg1: T0) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < size<T0>(arg0)) {
            if (0x1::vector::borrow<T0>(&arg0.contents, v0) == &arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun into_keys<T0: copy + drop>(arg0: &VecSet<T0>) : vector<T0> {
        arg0.contents
    }

    public fun is_empty<T0: copy + drop>(arg0: &VecSet<T0>) : bool {
        size<T0>(arg0) == 0
    }

    public fun size<T0: copy + drop>(arg0: &VecSet<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.contents)
    }

    // decompiled from Move bytecode v6
}

