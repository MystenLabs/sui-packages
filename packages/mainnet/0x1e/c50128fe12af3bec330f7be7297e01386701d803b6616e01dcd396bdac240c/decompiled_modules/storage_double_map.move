module 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_double_map {
    struct Entry<T0: copy + drop + store, T1: copy + drop + store, T2: store> has copy, drop, store {
        key1: T0,
        key2: T1,
        value: T2,
    }

    struct StorageDoubleMap<T0: copy + drop + store, T1: copy + drop + store, T2: store> has store {
        contents: vector<Entry<T0, T1, T2>>,
    }

    public fun length<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &StorageDoubleMap<T0, T1, T2>) : u64 {
        0x1::vector::length<Entry<T0, T1, T2>>(&arg0.contents)
    }

    public fun borrow<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : &T2 {
        &0x1::vector::borrow<Entry<T0, T1, T2>>(&arg0.contents, get_idx<T0, T1, T2>(arg0, arg1, arg2)).value
    }

    public fun borrow_mut<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : &mut T2 {
        &mut 0x1::vector::borrow_mut<Entry<T0, T1, T2>>(&mut arg0.contents, get_idx<T0, T1, T2>(arg0, arg1, arg2)).value
    }

    public fun remove<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) {
        let v0 = get_idx_opt<T0, T1, T2>(arg0, arg1, arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::vector::remove<Entry<T0, T1, T2>>(&mut arg0.contents, 0x1::option::destroy_some<u64>(v0));
        };
    }

    public fun contains_key<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : bool {
        let v0 = get_idx_opt<T0, T1, T2>(arg0, arg1, arg2);
        0x1::option::is_some<u64>(&v0)
    }

    public fun get<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : T2 {
        0x1::vector::borrow<Entry<T0, T1, T2>>(&arg0.contents, get_idx<T0, T1, T2>(arg0, arg1, arg2)).value
    }

    public fun get_idx<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : u64 {
        let v0 = get_idx_opt<T0, T1, T2>(arg0, arg1, arg2);
        assert!(0x1::option::is_some<u64>(&v0), 0);
        0x1::option::destroy_some<u64>(v0)
    }

    public fun get_idx_opt<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : 0x1::option::Option<u64> {
        let v0 = &arg0.contents;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Entry<T0, T1, T2>>(v0)) {
            let v3 = 0x1::vector::borrow<Entry<T0, T1, T2>>(v0, v1);
            if (v3.key1 == arg1 && v3.key2 == arg2) {
                v2 = 0x1::option::some<u64>(v1);
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        v2
    }

    public fun insert<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1, arg3: T2) {
        assert!(!contains_key<T0, T1, T2>(arg0, arg1, arg2), 1);
        let v0 = Entry<T0, T1, T2>{
            key1  : arg1,
            key2  : arg2,
            value : arg3,
        };
        0x1::vector::push_back<Entry<T0, T1, T2>>(&mut arg0.contents, v0);
    }

    public fun keys<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &StorageDoubleMap<T0, T1, T2>) : (vector<T0>, vector<T1>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<T0>();
        let v2 = 0x1::vector::empty<T1>();
        while (v0 < 0x1::vector::length<Entry<T0, T1, T2>>(&arg0.contents)) {
            let v3 = 0x1::vector::borrow<Entry<T0, T1, T2>>(&arg0.contents, v0);
            0x1::vector::push_back<T0>(&mut v1, v3.key1);
            0x1::vector::push_back<T1>(&mut v2, v3.key2);
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    public fun new<T0: copy + drop + store, T1: copy + drop + store, T2: store>() : StorageDoubleMap<T0, T1, T2> {
        StorageDoubleMap<T0, T1, T2>{contents: 0x1::vector::empty<Entry<T0, T1, T2>>()}
    }

    public fun set<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1, arg3: T2) {
        let v0 = get_idx_opt<T0, T1, T2>(arg0, arg1, arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::vector::borrow_mut<Entry<T0, T1, T2>>(&mut arg0.contents, 0x1::option::destroy_some<u64>(v0)).value = arg3;
        } else {
            let v1 = Entry<T0, T1, T2>{
                key1  : arg1,
                key2  : arg2,
                value : arg3,
            };
            0x1::vector::push_back<Entry<T0, T1, T2>>(&mut arg0.contents, v1);
        };
    }

    public fun take<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : T2 {
        let Entry {
            key1  : _,
            key2  : _,
            value : v2,
        } = 0x1::vector::remove<Entry<T0, T1, T2>>(&mut arg0.contents, get_idx<T0, T1, T2>(arg0, arg1, arg2));
        v2
    }

    public fun try_get<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : 0x1::option::Option<T2> {
        if (contains_key<T0, T1, T2>(arg0, arg1, arg2)) {
            0x1::option::some<T2>(get<T0, T1, T2>(arg0, arg1, arg2))
        } else {
            0x1::option::none<T2>()
        }
    }

    public fun values<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>) : vector<T2> {
        let v0 = 0x1::vector::empty<T2>();
        let v1 = arg0.contents;
        0x1::vector::reverse<Entry<T0, T1, T2>>(&mut v1);
        while (0x1::vector::length<Entry<T0, T1, T2>>(&v1) != 0) {
            let v2 = 0x1::vector::pop_back<Entry<T0, T1, T2>>(&mut v1);
            0x1::vector::push_back<T2>(&mut v0, v2.value);
        };
        0x1::vector::destroy_empty<Entry<T0, T1, T2>>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

