module 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::keyed_big_vector {
    struct KeyedBigVector has store, key {
        id: 0x2::object::UID,
        key_type: 0x1::type_name::TypeName,
        value_type: 0x1::type_name::TypeName,
        slice_idx: u16,
        slice_size: u32,
        length: u64,
    }

    struct KeyIndexTableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Slice<T0: copy + drop + store, T1: store> has store {
        idx: u16,
        vector: vector<Element<T0, T1>>,
    }

    struct Element<T0: copy + drop + store, T1: store> has store {
        key: T0,
        value: T1,
    }

    public fun length(arg0: &KeyedBigVector) : u64 {
        arg0.length
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: u64) : (T0, &T1) {
        assert!(arg1 < arg0.length, 3301);
        borrow_<T0, T1>(arg0, arg1)
    }

    public fun push_back<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: T0, arg2: T1) {
        assert!(!contains<T0>(arg0, arg1), 3300);
        let v0 = Element<T0, T1>{
            key   : arg1,
            value : arg2,
        };
        if (is_empty(arg0) || length(arg0) % (arg0.slice_size as u64) == 0) {
            arg0.slice_idx = ((length(arg0) / (arg0.slice_size as u64)) as u16);
            assert!(arg0.slice_idx < 1000, 3304);
            let v1 = 0x1::vector::empty<Element<T0, T1>>();
            0x1::vector::push_back<Element<T0, T1>>(&mut v1, v0);
            let v2 = Slice<T0, T1>{
                idx    : arg0.slice_idx,
                vector : v1,
            };
            0x2::dynamic_field::add<u16, Slice<T0, T1>>(&mut arg0.id, arg0.slice_idx, v2);
        } else {
            let v3 = arg0.slice_idx;
            let v4 = borrow_slice_mut_<T0, T1>(arg0, v3);
            0x1::vector::push_back<Element<T0, T1>>(&mut v4.vector, v0);
        };
        let v5 = arg0.length;
        let v6 = key_index_table_mut<T0>(arg0);
        0x2::table::add<T0, u64>(v6, arg1, v5);
        arg0.length = arg0.length + 1;
    }

    public fun pop_back<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector) : (T0, T1) {
        assert!(!is_empty(arg0), 3301);
        let v0 = arg0.slice_idx;
        let v1 = borrow_slice_mut_<T0, T1>(arg0, v0);
        let Element {
            key   : v2,
            value : v3,
        } = 0x1::vector::pop_back<Element<T0, T1>>(&mut v1.vector);
        let v4 = key_index_table_mut<T0>(arg0);
        0x2::table::remove<T0, u64>(v4, v2);
        arg0.length = arg0.length - 1;
        trim_slice<T0, T1>(arg0);
        (v2, v3)
    }

    public fun destroy_empty<T0: copy + drop + store>(arg0: KeyedBigVector) {
        let KeyedBigVector {
            id         : v0,
            key_type   : _,
            value_type : _,
            slice_idx  : _,
            slice_size : _,
            length     : v5,
        } = arg0;
        assert!(v5 == 0, 3305);
        let v6 = v0;
        let v7 = KeyIndexTableKey{dummy_field: false};
        0x2::table::destroy_empty<T0, u64>(0x2::dynamic_field::remove<KeyIndexTableKey, 0x2::table::Table<T0, u64>>(&mut v6, v7));
        0x2::object::delete(v6);
    }

    public fun is_empty(arg0: &KeyedBigVector) : bool {
        arg0.length == 0
    }

    public fun swap_remove<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u64) : (T0, T1) {
        assert!(arg1 < arg0.length, 3301);
        let v0 = arg0.length - 1;
        if (arg1 == v0) {
            return pop_back<T0, T1>(arg0)
        };
        let v1 = ((arg1 / (arg0.slice_size as u64)) as u16);
        let v2 = arg1 % (arg0.slice_size as u64);
        let v3 = ((v0 / (arg0.slice_size as u64)) as u16);
        let (v4, v5, v6) = if (v1 == v3) {
            let v7 = borrow_slice_mut_<T0, T1>(arg0, v1);
            let Element {
                key   : v8,
                value : v9,
            } = 0x1::vector::swap_remove<Element<T0, T1>>(&mut v7.vector, v2);
            let v10 = if (v2 < 0x1::vector::length<Element<T0, T1>>(&v7.vector)) {
                0x1::vector::borrow<Element<T0, T1>>(&v7.vector, v2).key
            } else {
                v8
            };
            (v8, v9, v10)
        } else {
            let v11 = borrow_slice_mut_<T0, T1>(arg0, v3);
            let Element {
                key   : v12,
                value : v13,
            } = 0x1::vector::pop_back<Element<T0, T1>>(&mut v11.vector);
            let v14 = borrow_slice_mut_<T0, T1>(arg0, v1);
            let v15 = Element<T0, T1>{
                key   : v12,
                value : v13,
            };
            0x1::vector::push_back<Element<T0, T1>>(&mut v14.vector, v15);
            let Element {
                key   : v16,
                value : v17,
            } = 0x1::vector::swap_remove<Element<T0, T1>>(&mut v14.vector, v2);
            (v16, v17, v12)
        };
        let v18 = key_index_table_mut<T0>(arg0);
        *0x2::table::borrow_mut<T0, u64>(v18, v6) = arg1;
        let v19 = key_index_table_mut<T0>(arg0);
        0x2::table::remove<T0, u64>(v19, v4);
        arg0.length = arg0.length - 1;
        trim_slice<T0, T1>(arg0);
        (v4, v5)
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : KeyedBigVector {
        assert!(arg0 > 0 && arg0 <= 262144, 3302);
        let v0 = 0x2::object::new(arg1);
        let v1 = KeyIndexTableKey{dummy_field: false};
        0x2::dynamic_field::add<KeyIndexTableKey, 0x2::table::Table<T0, u64>>(&mut v0, v1, 0x2::table::new<T0, u64>(arg1));
        KeyedBigVector{
            id         : v0,
            key_type   : 0x1::type_name::with_defining_ids<T0>(),
            value_type : 0x1::type_name::with_defining_ids<T1>(),
            slice_idx  : 0,
            slice_size : arg0,
            length     : 0,
        }
    }

    public fun contains<T0: copy + drop + store>(arg0: &KeyedBigVector, arg1: T0) : bool {
        0x2::table::contains<T0, u64>(key_index_table<T0>(arg0), arg1)
    }

    fun borrow_<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: u64) : (T0, &T1) {
        let v0 = 0x1::vector::borrow<Element<T0, T1>>(&borrow_slice_<T0, T1>(arg0, ((arg1 / (arg0.slice_size as u64)) as u16)).vector, arg1 % (arg0.slice_size as u64));
        (v0.key, &v0.value)
    }

    public fun borrow_by_key<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: T0) : &T1 {
        assert!(contains<T0>(arg0, arg1), 3303);
        let (_, v1) = borrow_<T0, T1>(arg0, *0x2::table::borrow<T0, u64>(key_index_table<T0>(arg0), arg1));
        v1
    }

    public fun borrow_from_slice<T0: copy + drop + store, T1: store>(arg0: &Slice<T0, T1>, arg1: u64) : (T0, &T1) {
        assert!(arg1 < 0x1::vector::length<Element<T0, T1>>(&arg0.vector), 3301);
        let v0 = 0x1::vector::borrow<Element<T0, T1>>(&arg0.vector, arg1);
        (v0.key, &v0.value)
    }

    public fun borrow_slice<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: u16) : &Slice<T0, T1> {
        assert!(!is_empty(arg0) && arg1 <= arg0.slice_idx, 3301);
        borrow_slice_<T0, T1>(arg0, arg1)
    }

    fun borrow_slice_<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: u16) : &Slice<T0, T1> {
        0x2::dynamic_field::borrow<u16, Slice<T0, T1>>(&arg0.id, arg1)
    }

    public fun borrow_slice_mut<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u16) : &mut Slice<T0, T1> {
        assert!(!is_empty(arg0) && arg1 <= arg0.slice_idx, 3301);
        borrow_slice_mut_<T0, T1>(arg0, arg1)
    }

    fun borrow_slice_mut_<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u16) : &mut Slice<T0, T1> {
        0x2::dynamic_field::borrow_mut<u16, Slice<T0, T1>>(&mut arg0.id, arg1)
    }

    fun key_index_table<T0: copy + drop + store>(arg0: &KeyedBigVector) : &0x2::table::Table<T0, u64> {
        let v0 = KeyIndexTableKey{dummy_field: false};
        0x2::dynamic_field::borrow<KeyIndexTableKey, 0x2::table::Table<T0, u64>>(&arg0.id, v0)
    }

    fun key_index_table_mut<T0: copy + drop + store>(arg0: &mut KeyedBigVector) : &mut 0x2::table::Table<T0, u64> {
        let v0 = KeyIndexTableKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<KeyIndexTableKey, 0x2::table::Table<T0, u64>>(&mut arg0.id, v0)
    }

    fun remove_empty_slice<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector) {
        let Slice {
            idx    : _,
            vector : v1,
        } = 0x2::dynamic_field::remove<u16, Slice<T0, T1>>(&mut arg0.id, arg0.slice_idx);
        0x1::vector::destroy_empty<Element<T0, T1>>(v1);
    }

    public fun slice_idx(arg0: &KeyedBigVector) : u16 {
        arg0.slice_idx
    }

    public fun slice_size(arg0: &KeyedBigVector) : u32 {
        arg0.slice_size
    }

    public fun swap_remove_by_key<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: T0) : T1 {
        assert!(contains<T0>(arg0, arg1), 3303);
        let v0 = *0x2::table::borrow<T0, u64>(key_index_table<T0>(arg0), arg1);
        let (_, v2) = swap_remove<T0, T1>(arg0, v0);
        v2
    }

    fun trim_slice<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector) {
        if (arg0.length == 0) {
            remove_empty_slice<T0, T1>(arg0);
        } else if (0x1::vector::is_empty<Element<T0, T1>>(&borrow_slice_<T0, T1>(arg0, arg0.slice_idx).vector)) {
            remove_empty_slice<T0, T1>(arg0);
            arg0.slice_idx = arg0.slice_idx - 1;
        };
    }

    // decompiled from Move bytecode v7
}

