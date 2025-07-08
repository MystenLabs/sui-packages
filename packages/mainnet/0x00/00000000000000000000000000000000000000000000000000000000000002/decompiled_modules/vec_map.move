module 0x2::vec_map {
    struct VecMap<T0: copy, T1> has copy, drop, store {
        contents: vector<Entry<T0, T1>>,
    }

    struct Entry<T0: copy, T1> has copy, drop, store {
        key: T0,
        value: T1,
    }

    public fun empty<T0: copy, T1>() : VecMap<T0, T1> {
        VecMap<T0, T1>{contents: 0x1::vector::empty<Entry<T0, T1>>()}
    }

    public fun destroy_empty<T0: copy, T1>(arg0: VecMap<T0, T1>) {
        let VecMap { contents: v0 } = arg0;
        assert!(0x1::vector::is_empty<Entry<T0, T1>>(&v0), 2);
        0x1::vector::destroy_empty<Entry<T0, T1>>(v0);
    }

    public fun is_empty<T0: copy, T1>(arg0: &VecMap<T0, T1>) : bool {
        size<T0, T1>(arg0) == 0
    }

    public fun remove<T0: copy, T1>(arg0: &mut VecMap<T0, T1>, arg1: &T0) : (T0, T1) {
        let Entry {
            key   : v0,
            value : v1,
        } = 0x1::vector::remove<Entry<T0, T1>>(&mut arg0.contents, get_idx<T0, T1>(arg0, arg1));
        (v0, v1)
    }

    public fun contains<T0: copy, T1>(arg0: &VecMap<T0, T1>, arg1: &T0) : bool {
        let v0 = get_idx_opt<T0, T1>(arg0, arg1);
        0x1::option::is_some<u64>(&v0)
    }

    public fun from_keys_values<T0: copy, T1>(arg0: vector<T0>, arg1: vector<T1>) : VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 5);
        0x1::vector::reverse<T0>(&mut arg0);
        0x1::vector::reverse<T1>(&mut arg1);
        let v0 = empty<T0, T1>();
        while (0x1::vector::length<T0>(&arg0) != 0) {
            let v1 = &mut v0;
            insert<T0, T1>(v1, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
        };
        0x1::vector::destroy_empty<T0>(arg0);
        0x1::vector::destroy_empty<T1>(arg1);
        v0
    }

    public fun get<T0: copy, T1>(arg0: &VecMap<T0, T1>, arg1: &T0) : &T1 {
        &0x1::vector::borrow<Entry<T0, T1>>(&arg0.contents, get_idx<T0, T1>(arg0, arg1)).value
    }

    public fun get_entry_by_idx<T0: copy, T1>(arg0: &VecMap<T0, T1>, arg1: u64) : (&T0, &T1) {
        assert!(arg1 < size<T0, T1>(arg0), 3);
        let v0 = 0x1::vector::borrow<Entry<T0, T1>>(&arg0.contents, arg1);
        (&v0.key, &v0.value)
    }

    public fun get_entry_by_idx_mut<T0: copy, T1>(arg0: &mut VecMap<T0, T1>, arg1: u64) : (&T0, &mut T1) {
        assert!(arg1 < size<T0, T1>(arg0), 3);
        let v0 = 0x1::vector::borrow_mut<Entry<T0, T1>>(&mut arg0.contents, arg1);
        (&v0.key, &mut v0.value)
    }

    public fun get_idx<T0: copy, T1>(arg0: &VecMap<T0, T1>, arg1: &T0) : u64 {
        let v0 = get_idx_opt<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 1);
        0x1::option::destroy_some<u64>(v0)
    }

    public fun get_idx_opt<T0: copy, T1>(arg0: &VecMap<T0, T1>, arg1: &T0) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < size<T0, T1>(arg0)) {
            if (&0x1::vector::borrow<Entry<T0, T1>>(&arg0.contents, v0).key == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun get_mut<T0: copy, T1>(arg0: &mut VecMap<T0, T1>, arg1: &T0) : &mut T1 {
        &mut 0x1::vector::borrow_mut<Entry<T0, T1>>(&mut arg0.contents, get_idx<T0, T1>(arg0, arg1)).value
    }

    public fun insert<T0: copy, T1>(arg0: &mut VecMap<T0, T1>, arg1: T0, arg2: T1) {
        assert!(!contains<T0, T1>(arg0, &arg1), 0);
        let v0 = Entry<T0, T1>{
            key   : arg1,
            value : arg2,
        };
        0x1::vector::push_back<Entry<T0, T1>>(&mut arg0.contents, v0);
    }

    public fun into_keys_values<T0: copy, T1>(arg0: VecMap<T0, T1>) : (vector<T0>, vector<T1>) {
        let VecMap { contents: v0 } = arg0;
        0x1::vector::reverse<Entry<T0, T1>>(&mut v0);
        let v1 = 0;
        let v2 = 0x1::vector::empty<T0>();
        let v3 = 0x1::vector::empty<T1>();
        while (v1 < 0x1::vector::length<Entry<T0, T1>>(&v0)) {
            let Entry {
                key   : v4,
                value : v5,
            } = 0x1::vector::pop_back<Entry<T0, T1>>(&mut v0);
            0x1::vector::push_back<T0>(&mut v2, v4);
            0x1::vector::push_back<T1>(&mut v3, v5);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Entry<T0, T1>>(v0);
        (v2, v3)
    }

    public fun keys<T0: copy, T1>(arg0: &VecMap<T0, T1>) : vector<T0> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<T0>();
        while (v0 < 0x1::vector::length<Entry<T0, T1>>(&arg0.contents)) {
            0x1::vector::push_back<T0>(&mut v1, 0x1::vector::borrow<Entry<T0, T1>>(&arg0.contents, v0).key);
            v0 = v0 + 1;
        };
        v1
    }

    public fun pop<T0: copy, T1>(arg0: &mut VecMap<T0, T1>) : (T0, T1) {
        assert!(0x1::vector::length<Entry<T0, T1>>(&arg0.contents) != 0, 4);
        let Entry {
            key   : v0,
            value : v1,
        } = 0x1::vector::pop_back<Entry<T0, T1>>(&mut arg0.contents);
        (v0, v1)
    }

    public fun remove_entry_by_idx<T0: copy, T1>(arg0: &mut VecMap<T0, T1>, arg1: u64) : (T0, T1) {
        assert!(arg1 < size<T0, T1>(arg0), 3);
        let Entry {
            key   : v0,
            value : v1,
        } = 0x1::vector::remove<Entry<T0, T1>>(&mut arg0.contents, arg1);
        (v0, v1)
    }

    public fun size<T0: copy, T1>(arg0: &VecMap<T0, T1>) : u64 {
        0x1::vector::length<Entry<T0, T1>>(&arg0.contents)
    }

    public fun try_get<T0: copy, T1: copy>(arg0: &VecMap<T0, T1>, arg1: &T0) : 0x1::option::Option<T1> {
        if (contains<T0, T1>(arg0, arg1)) {
            0x1::option::some<T1>(*get<T0, T1>(arg0, arg1))
        } else {
            0x1::option::none<T1>()
        }
    }

    // decompiled from Move bytecode v6
}

