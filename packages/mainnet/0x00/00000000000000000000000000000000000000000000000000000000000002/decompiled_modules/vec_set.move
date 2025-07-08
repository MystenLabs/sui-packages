module 0x2::vec_set {
    struct VecSet<T0: copy + drop> has copy, drop, store {
        contents: vector<T0>,
    }

    public fun empty<T0: copy + drop>() : VecSet<T0> {
        VecSet<T0>{contents: 0x1::vector::empty<T0>()}
    }

    public fun remove<T0: copy + drop>(arg0: &mut VecSet<T0>, arg1: &T0) {
        0x1::vector::remove<T0>(&mut arg0.contents, get_idx<T0>(arg0, arg1));
    }

    public fun contains<T0: copy + drop>(arg0: &VecSet<T0>, arg1: &T0) : bool {
        let v0 = get_idx_opt<T0>(arg0, arg1);
        0x1::option::is_some<u64>(&v0)
    }

    public fun from_keys<T0: copy + drop>(arg0: vector<T0>) : VecSet<T0> {
        0x1::vector::reverse<T0>(&mut arg0);
        let v0 = empty<T0>();
        while (0x1::vector::length<T0>(&arg0) != 0) {
            let v1 = &mut v0;
            insert<T0>(v1, 0x1::vector::pop_back<T0>(&mut arg0));
        };
        v0
    }

    fun get_idx<T0: copy + drop>(arg0: &VecSet<T0>, arg1: &T0) : u64 {
        let v0 = get_idx_opt<T0>(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 1);
        0x1::option::destroy_some<u64>(v0)
    }

    fun get_idx_opt<T0: copy + drop>(arg0: &VecSet<T0>, arg1: &T0) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < size<T0>(arg0)) {
            if (0x1::vector::borrow<T0>(&arg0.contents, v0) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun insert<T0: copy + drop>(arg0: &mut VecSet<T0>, arg1: T0) {
        assert!(!contains<T0>(arg0, &arg1), 0);
        0x1::vector::push_back<T0>(&mut arg0.contents, arg1);
    }

    public fun into_keys<T0: copy + drop>(arg0: VecSet<T0>) : vector<T0> {
        let VecSet { contents: v0 } = arg0;
        v0
    }

    public fun is_empty<T0: copy + drop>(arg0: &VecSet<T0>) : bool {
        size<T0>(arg0) == 0
    }

    public fun keys<T0: copy + drop>(arg0: &VecSet<T0>) : &vector<T0> {
        &arg0.contents
    }

    public fun singleton<T0: copy + drop>(arg0: T0) : VecSet<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::push_back<T0>(&mut v0, arg0);
        VecSet<T0>{contents: v0}
    }

    public fun size<T0: copy + drop>(arg0: &VecSet<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.contents)
    }

    // decompiled from Move bytecode v6
}

