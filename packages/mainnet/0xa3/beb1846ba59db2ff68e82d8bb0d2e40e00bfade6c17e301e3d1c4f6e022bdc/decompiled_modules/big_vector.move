module 0xa3beb1846ba59db2ff68e82d8bb0d2e40e00bfade6c17e301e3d1c4f6e022bdc::big_vector {
    struct BigVector has store, key {
        id: 0x2::object::UID,
        element_type: 0x1::type_name::TypeName,
        slice_idx: u64,
        slice_size: u32,
        length: u64,
    }

    struct Slice<T0> has drop, store {
        idx: u64,
        vector: vector<T0>,
    }

    public fun length(arg0: &BigVector) : u64 {
        arg0.length
    }

    public fun borrow<T0: store>(arg0: &BigVector, arg1: u64) : &T0 {
        assert!(arg1 < arg0.length, 3);
        assert!(!is_empty(arg0), 2);
        0x1::vector::borrow<T0>(&borrow_slice_<T0>(&arg0.id, arg1 / (arg0.slice_size as u64)).vector, arg1 % (arg0.slice_size as u64))
    }

    public fun push_back<T0: store>(arg0: &mut BigVector, arg1: T0) {
        if (is_empty(arg0) || length(arg0) % (arg0.slice_size as u64) == 0) {
            arg0.slice_idx = length(arg0) / (arg0.slice_size as u64);
            let v0 = 0x1::vector::empty<T0>();
            0x1::vector::push_back<T0>(&mut v0, arg1);
            let v1 = Slice<T0>{
                idx    : arg0.slice_idx,
                vector : v0,
            };
            0x2::dynamic_field::add<u64, Slice<T0>>(&mut arg0.id, arg0.slice_idx, v1);
        } else {
            let v2 = &mut arg0.id;
            0x1::vector::push_back<T0>(&mut borrow_slice_mut_<T0>(v2, arg0.slice_idx).vector, arg1);
        };
        arg0.length = arg0.length + 1;
    }

    public fun borrow_mut<T0: store>(arg0: &mut BigVector, arg1: u64) : &mut T0 {
        assert!(arg1 < arg0.length, 3);
        assert!(!is_empty(arg0), 2);
        let v0 = &mut arg0.id;
        0x1::vector::borrow_mut<T0>(&mut borrow_slice_mut_<T0>(v0, arg1 / (arg0.slice_size as u64)).vector, arg1 % (arg0.slice_size as u64))
    }

    public fun pop_back<T0: store>(arg0: &mut BigVector) : T0 {
        assert!(!is_empty(arg0), 2);
        let v0 = &mut arg0.id;
        let v1 = 0x1::vector::pop_back<T0>(&mut borrow_slice_mut_<T0>(v0, arg0.slice_idx).vector);
        trim_slice<T0>(arg0);
        arg0.length = arg0.length - 1;
        v1
    }

    public fun destroy_empty(arg0: BigVector) {
        let BigVector {
            id           : v0,
            element_type : _,
            slice_idx    : _,
            slice_size   : _,
            length       : v4,
        } = arg0;
        assert!(v4 == 0, 1);
        0x2::object::delete(v0);
    }

    public fun is_empty(arg0: &BigVector) : bool {
        arg0.length == 0
    }

    public fun remove<T0: store>(arg0: &mut BigVector, arg1: u64) : T0 {
        assert!(arg1 < length(arg0), 3);
        let v0 = &mut arg0.id;
        let v1 = 0x1::vector::remove<T0>(&mut borrow_slice_mut_<T0>(v0, arg1 / (arg0.slice_size as u64)).vector, arg1 % (arg0.slice_size as u64));
        let v2 = arg0.slice_idx;
        while (v2 > arg1 / (arg0.slice_size as u64) && v2 > 0) {
            let v3 = &mut arg0.id;
            let v4 = 0x1::vector::remove<T0>(&mut borrow_slice_mut_<T0>(v3, v2).vector, 0);
            let v5 = &mut arg0.id;
            0x1::vector::push_back<T0>(&mut borrow_slice_mut_<T0>(v5, v2 - 1).vector, v4);
            v2 = v2 - 1;
        };
        trim_slice<T0>(arg0);
        arg0.length = arg0.length - 1;
        v1
    }

    public fun swap_remove<T0: store>(arg0: &mut BigVector, arg1: u64) : T0 {
        let v0 = pop_back<T0>(arg0);
        if (arg1 == length(arg0)) {
            v0
        } else {
            let v2 = &mut arg0.id;
            let v3 = borrow_slice_mut_<T0>(v2, arg1 / (arg0.slice_size as u64));
            0x1::vector::push_back<T0>(&mut v3.vector, v0);
            0x1::vector::swap_remove<T0>(&mut v3.vector, arg1 % (arg0.slice_size as u64))
        }
    }

    public fun new<T0: store>(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : BigVector {
        assert!(arg0 > 0 && arg0 <= 262144, 0);
        BigVector{
            id           : 0x2::object::new(arg1),
            element_type : 0x1::type_name::get<T0>(),
            slice_idx    : 0,
            slice_size   : arg0,
            length       : 0,
        }
    }

    public fun borrow_from_slice<T0: store>(arg0: &Slice<T0>, arg1: u64) : &T0 {
        assert!(arg1 < 0x1::vector::length<T0>(&arg0.vector), 3);
        0x1::vector::borrow<T0>(&arg0.vector, arg1)
    }

    public fun borrow_from_slice_mut<T0: store>(arg0: &mut Slice<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 < 0x1::vector::length<T0>(&arg0.vector), 3);
        0x1::vector::borrow_mut<T0>(&mut arg0.vector, arg1)
    }

    public fun borrow_slice<T0: store>(arg0: &BigVector, arg1: u64) : &Slice<T0> {
        assert!(arg1 <= arg0.slice_idx, 3);
        assert!(!is_empty(arg0), 2);
        borrow_slice_<T0>(&arg0.id, arg1)
    }

    fun borrow_slice_<T0: store>(arg0: &0x2::object::UID, arg1: u64) : &Slice<T0> {
        0x2::dynamic_field::borrow<u64, Slice<T0>>(arg0, arg1)
    }

    public fun borrow_slice_mut<T0: store>(arg0: &mut BigVector, arg1: u64) : &mut Slice<T0> {
        assert!(arg1 <= arg0.slice_idx, 3);
        assert!(!is_empty(arg0), 2);
        let v0 = &mut arg0.id;
        borrow_slice_mut_<T0>(v0, arg1)
    }

    fun borrow_slice_mut_<T0: store>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut Slice<T0> {
        0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(arg0, arg1)
    }

    public fun drop<T0: drop + store>(arg0: BigVector) {
        let BigVector {
            id           : v0,
            element_type : _,
            slice_idx    : v2,
            slice_size   : _,
            length       : _,
        } = arg0;
        let v5 = v2;
        let v6 = v0;
        while (v5 > 0) {
            0x2::dynamic_field::remove<u64, Slice<T0>>(&mut v6, v5);
            v5 = v5 - 1;
        };
        0x2::dynamic_field::remove<u64, Slice<T0>>(&mut v6, v5);
        0x2::object::delete(v6);
    }

    public fun get_slice_idx<T0>(arg0: &Slice<T0>) : u64 {
        arg0.idx
    }

    public fun get_slice_length<T0>(arg0: &Slice<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.vector)
    }

    public fun slice_idx(arg0: &BigVector) : u64 {
        arg0.slice_idx
    }

    public fun slice_size(arg0: &BigVector) : u32 {
        arg0.slice_size
    }

    fun trim_slice<T0: store>(arg0: &mut BigVector) {
        if (0x1::vector::is_empty<T0>(&borrow_slice_<T0>(&arg0.id, arg0.slice_idx).vector)) {
            let Slice {
                idx    : _,
                vector : v1,
            } = 0x2::dynamic_field::remove<u64, Slice<T0>>(&mut arg0.id, arg0.slice_idx);
            0x1::vector::destroy_empty<T0>(v1);
            if (arg0.slice_idx > 0) {
                arg0.slice_idx = arg0.slice_idx - 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

