module 0x2::vec_set {
    struct VecSet<T0: copy + drop> has copy, drop, store {
        contents: vector<T0>,
    }

    public fun empty<T0: copy + drop>() : VecSet<T0> {
        VecSet<T0>{contents: 0x1::vector::empty<T0>()}
    }

    public fun length<T0: copy + drop>(arg0: &VecSet<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.contents)
    }

    public fun remove<T0: copy + drop>(arg0: &mut VecSet<T0>, arg1: &T0) {
        let v0 = &arg0.contents;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<T0>(v0)) {
            if (0x1::vector::borrow<T0>(v0, v1) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<T0>(&mut arg0.contents, 0x1::option::destroy_some<u64>(v2));
                    return
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    abort 1
                };
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun contains<T0: copy + drop>(arg0: &VecSet<T0>, arg1: &T0) : bool {
        let v0 = &arg0.contents;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<T0>(v0)) {
            if (0x1::vector::borrow<T0>(v0, v1) == arg1) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public fun from_keys<T0: copy + drop>(arg0: vector<T0>) : VecSet<T0> {
        let v0 = empty<T0>();
        0x1::vector::reverse<T0>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&arg0)) {
            let v2 = &mut v0;
            insert<T0>(v2, 0x1::vector::pop_back<T0>(&mut arg0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
        v0
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
        length<T0>(arg0) == 0
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

