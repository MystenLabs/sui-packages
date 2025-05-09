module 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector {
    struct KeyedBigVector has store, key {
        id: 0x2::object::UID,
        key_type: 0x1::type_name::TypeName,
        value_type: 0x1::type_name::TypeName,
        slice_idx: u16,
        slice_size: u32,
        length: u64,
    }

    struct Slice<T0: copy + drop + store, T1: store> has drop, store {
        idx: u16,
        vector: vector<Element<T0, T1>>,
    }

    struct Element<T0: copy + drop + store, T1: store> has drop, store {
        key: T0,
        value: T1,
    }

    public fun length(arg0: &KeyedBigVector) : u64 {
        arg0.length
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: u64) : (T0, &T1) {
        assert!(arg1 < arg0.length, index_out_of_bounds());
        borrow_<T0, T1>(arg0, arg1)
    }

    public fun push_back<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: T0, arg2: T1) {
        assert!(!contains<T0>(arg0, arg1), duplicate_key());
        let v0 = Element<T0, T1>{
            key   : arg1,
            value : arg2,
        };
        if (is_empty(arg0) || length(arg0) % (arg0.slice_size as u64) == 0) {
            arg0.slice_idx = ((length(arg0) / (arg0.slice_size as u64)) as u16);
            assert!(arg0.slice_idx < 1000, max_slice_amount_reached());
            let v1 = 0x1::vector::empty<Element<T0, T1>>();
            0x1::vector::push_back<Element<T0, T1>>(&mut v1, v0);
            let v2 = Slice<T0, T1>{
                idx    : arg0.slice_idx,
                vector : v1,
            };
            0x2::dynamic_field::add<u16, Slice<T0, T1>>(&mut arg0.id, arg0.slice_idx, v2);
        } else {
            let v3 = &mut arg0.id;
            0x1::vector::push_back<Element<T0, T1>>(&mut borrow_slice_mut_<T0, T1>(v3, arg0.slice_idx).vector, v0);
        };
        0x2::table::add<T0, u64>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<T0, u64>>(&mut arg0.id, 0x1::string::utf8(b"key_index_table")), arg1, arg0.length);
        arg0.length = arg0.length + 1;
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u64) : (T0, &mut T1) {
        assert!(arg1 < arg0.length, index_out_of_bounds());
        borrow_mut_<T0, T1>(arg0, arg1)
    }

    public fun pop_back<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector) : (T0, T1) {
        assert!(!is_empty(arg0), index_out_of_bounds());
        let v0 = &mut arg0.id;
        let Element {
            key   : v1,
            value : v2,
        } = 0x1::vector::pop_back<Element<T0, T1>>(&mut borrow_slice_mut_<T0, T1>(v0, arg0.slice_idx).vector);
        trim_slice<T0, T1>(arg0);
        0x2::table::remove<T0, u64>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<T0, u64>>(&mut arg0.id, 0x1::string::utf8(b"key_index_table")), v1);
        arg0.length = arg0.length - 1;
        (v1, v2)
    }

    public fun destroy_empty(arg0: KeyedBigVector) {
        let KeyedBigVector {
            id         : v0,
            key_type   : _,
            value_type : _,
            slice_idx  : _,
            slice_size : _,
            length     : v5,
        } = arg0;
        assert!(v5 == 0, not_empty());
        0x2::object::delete(v0);
    }

    public fun is_empty(arg0: &KeyedBigVector) : bool {
        arg0.length == 0
    }

    public fun swap_remove<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u64) : (T0, T1) {
        assert!(arg1 < arg0.length, index_out_of_bounds());
        swap_remove_<T0, T1>(arg0, arg1)
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : KeyedBigVector {
        assert!(arg0 > 0 && arg0 <= 262144, invalid_slice_size());
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<T0, u64>>(&mut v0, 0x1::string::utf8(b"key_index_table"), 0x2::table::new<T0, u64>(arg1));
        KeyedBigVector{
            id         : v0,
            key_type   : 0x1::type_name::get<T0>(),
            value_type : 0x1::type_name::get<T1>(),
            slice_idx  : 0,
            slice_size : arg0,
            length     : 0,
        }
    }

    public fun contains<T0: copy + drop + store>(arg0: &KeyedBigVector, arg1: T0) : bool {
        0x2::table::contains<T0, u64>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<T0, u64>>(&arg0.id, 0x1::string::utf8(b"key_index_table")), arg1)
    }

    fun borrow_<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: u64) : (T0, &T1) {
        let v0 = 0x1::vector::borrow<Element<T0, T1>>(&borrow_slice_<T0, T1>(&arg0.id, ((arg1 / (arg0.slice_size as u64)) as u16)).vector, arg1 % (arg0.slice_size as u64));
        (v0.key, &v0.value)
    }

    public fun borrow_by_key<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: T0) : &T1 {
        assert!(contains<T0>(arg0, arg1), key_not_found());
        let (_, v1) = borrow_<T0, T1>(arg0, *0x2::table::borrow<T0, u64>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<T0, u64>>(&arg0.id, 0x1::string::utf8(b"key_index_table")), arg1));
        v1
    }

    public fun borrow_by_key_mut<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: T0) : &mut T1 {
        assert!(contains<T0>(arg0, arg1), key_not_found());
        let v0 = *0x2::table::borrow<T0, u64>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<T0, u64>>(&arg0.id, 0x1::string::utf8(b"key_index_table")), arg1);
        let (_, v2) = borrow_mut_<T0, T1>(arg0, v0);
        v2
    }

    public fun borrow_from_slice<T0: copy + drop + store, T1: store>(arg0: &Slice<T0, T1>, arg1: u64) : (T0, &T1) {
        assert!(arg1 < 0x1::vector::length<Element<T0, T1>>(&arg0.vector), index_out_of_bounds());
        let v0 = 0x1::vector::borrow<Element<T0, T1>>(&arg0.vector, arg1);
        (v0.key, &v0.value)
    }

    public fun borrow_from_slice_mut<T0: copy + drop + store, T1: store>(arg0: &mut Slice<T0, T1>, arg1: u64) : (T0, &mut T1) {
        assert!(arg1 < 0x1::vector::length<Element<T0, T1>>(&arg0.vector), index_out_of_bounds());
        let v0 = 0x1::vector::borrow_mut<Element<T0, T1>>(&mut arg0.vector, arg1);
        (v0.key, &mut v0.value)
    }

    fun borrow_mut_<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u64) : (T0, &mut T1) {
        let v0 = &mut arg0.id;
        let v1 = 0x1::vector::borrow_mut<Element<T0, T1>>(&mut borrow_slice_mut_<T0, T1>(v0, ((arg1 / (arg0.slice_size as u64)) as u16)).vector, arg1 % (arg0.slice_size as u64));
        (v1.key, &mut v1.value)
    }

    public fun borrow_slice<T0: copy + drop + store, T1: store>(arg0: &KeyedBigVector, arg1: u16) : &Slice<T0, T1> {
        assert!(arg1 <= arg0.slice_idx, index_out_of_bounds());
        borrow_slice_<T0, T1>(&arg0.id, arg1)
    }

    fun borrow_slice_<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: u16) : &Slice<T0, T1> {
        0x2::dynamic_field::borrow<u16, Slice<T0, T1>>(arg0, arg1)
    }

    public fun borrow_slice_mut<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u16) : &mut Slice<T0, T1> {
        assert!(arg1 <= arg0.slice_idx, index_out_of_bounds());
        let v0 = &mut arg0.id;
        borrow_slice_mut_<T0, T1>(v0, arg1)
    }

    fun borrow_slice_mut_<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: u16) : &mut Slice<T0, T1> {
        0x2::dynamic_field::borrow_mut<u16, Slice<T0, T1>>(arg0, arg1)
    }

    public fun completely_drop<T0: copy + drop + store, T1: drop + store>(arg0: KeyedBigVector) {
        let KeyedBigVector {
            id         : v0,
            key_type   : _,
            value_type : _,
            slice_idx  : v3,
            slice_size : _,
            length     : v5,
        } = arg0;
        let v6 = v0;
        if (v5 > 0) {
            let v7 = 0;
            while (v7 < v3 + 1) {
                0x2::dynamic_field::remove<u16, Slice<T0, T1>>(&mut v6, v3 - v7);
                v7 = v7 + 1;
            };
        };
        0x2::object::delete(v6);
    }

    public fun drop(arg0: KeyedBigVector) {
        let KeyedBigVector {
            id         : v0,
            key_type   : _,
            value_type : _,
            slice_idx  : _,
            slice_size : _,
            length     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun duplicate_key() : u64 {
        abort 0
    }

    public fun get_slice_idx<T0: copy + drop + store, T1: store>(arg0: &Slice<T0, T1>) : u16 {
        arg0.idx
    }

    public fun get_slice_length<T0: copy + drop + store, T1: store>(arg0: &Slice<T0, T1>) : u64 {
        0x1::vector::length<Element<T0, T1>>(&arg0.vector)
    }

    fun index_out_of_bounds() : u64 {
        abort 0
    }

    fun invalid_slice_size() : u64 {
        abort 0
    }

    fun key_not_found() : u64 {
        abort 0
    }

    fun max_slice_amount_reached() : u64 {
        abort 0
    }

    fun not_empty() : u64 {
        abort 0
    }

    public fun slice_idx(arg0: &KeyedBigVector) : u16 {
        arg0.slice_idx
    }

    public fun slice_size(arg0: &KeyedBigVector) : u32 {
        arg0.slice_size
    }

    fun swap_remove_<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: u64) : (T0, T1) {
        let (v0, v1) = pop_back<T0, T1>(arg0);
        if (arg1 == length(arg0)) {
            (v0, v1)
        } else {
            0x2::table::add<T0, u64>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<T0, u64>>(&mut arg0.id, 0x1::string::utf8(b"key_index_table")), v0, arg1);
            let v4 = &mut arg0.id;
            let v5 = borrow_slice_mut_<T0, T1>(v4, ((arg1 / (arg0.slice_size as u64)) as u16));
            let v6 = Element<T0, T1>{
                key   : v0,
                value : v1,
            };
            0x1::vector::push_back<Element<T0, T1>>(&mut v5.vector, v6);
            let Element {
                key   : v7,
                value : v8,
            } = 0x1::vector::swap_remove<Element<T0, T1>>(&mut v5.vector, arg1 % (arg0.slice_size as u64));
            0x2::table::remove<T0, u64>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<T0, u64>>(&mut arg0.id, 0x1::string::utf8(b"key_index_table")), v7);
            (v7, v8)
        }
    }

    public fun swap_remove_by_key<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector, arg1: T0) : T1 {
        assert!(contains<T0>(arg0, arg1), key_not_found());
        let v0 = *0x2::table::borrow<T0, u64>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<T0, u64>>(&arg0.id, 0x1::string::utf8(b"key_index_table")), arg1);
        let (_, v2) = swap_remove_<T0, T1>(arg0, v0);
        v2
    }

    fun trim_slice<T0: copy + drop + store, T1: store>(arg0: &mut KeyedBigVector) {
        if (0x1::vector::is_empty<Element<T0, T1>>(&borrow_slice_<T0, T1>(&arg0.id, arg0.slice_idx).vector)) {
            let Slice {
                idx    : _,
                vector : v1,
            } = 0x2::dynamic_field::remove<u16, Slice<T0, T1>>(&mut arg0.id, arg0.slice_idx);
            0x1::vector::destroy_empty<Element<T0, T1>>(v1);
            if (arg0.slice_idx > 0) {
                arg0.slice_idx = arg0.slice_idx - 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

