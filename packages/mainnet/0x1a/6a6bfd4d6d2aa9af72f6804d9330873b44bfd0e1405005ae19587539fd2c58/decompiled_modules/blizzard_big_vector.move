module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector {
    struct BigVector<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        slice_idx: u64,
        slice_size: u32,
        length: u64,
    }

    struct Slice<T0: store> has drop, store {
        idx: u64,
        vector: vector<T0>,
    }

    public fun length<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.length
    }

    public fun borrow<T0: store>(arg0: &BigVector<T0>, arg1: u64) : &T0 {
        assert!(arg1 < arg0.length, 11);
        assert!(!is_empty<T0>(arg0), 10);
        0x1::vector::borrow<T0>(&borrow_slice_<T0>(&arg0.id, arg1 / (arg0.slice_size as u64)).vector, arg1 % (arg0.slice_size as u64))
    }

    public(friend) fun push_back<T0: store>(arg0: &mut BigVector<T0>, arg1: T0) {
        if (is_empty<T0>(arg0) || arg0.length % (arg0.slice_size as u64) == 0) {
            arg0.slice_idx = arg0.length / (arg0.slice_size as u64);
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

    public(friend) fun borrow_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 < arg0.length, 11);
        assert!(!is_empty<T0>(arg0), 10);
        let v0 = &mut arg0.id;
        0x1::vector::borrow_mut<T0>(&mut borrow_slice_mut_<T0>(v0, arg1 / (arg0.slice_size as u64)).vector, arg1 % (arg0.slice_size as u64))
    }

    public(friend) fun pop_back<T0: store>(arg0: &mut BigVector<T0>) : T0 {
        assert!(!is_empty<T0>(arg0), 10);
        let v0 = &mut arg0.id;
        let v1 = 0x1::vector::pop_back<T0>(&mut borrow_slice_mut_<T0>(v0, arg0.slice_idx).vector);
        trim_slice<T0>(arg0);
        arg0.length = arg0.length - 1;
        v1
    }

    public(friend) fun destroy_empty<T0: store>(arg0: BigVector<T0>) {
        let BigVector {
            id         : v0,
            slice_idx  : _,
            slice_size : _,
            length     : v3,
        } = arg0;
        assert!(v3 == 0, 9);
        0x2::object::delete(v0);
    }

    public fun is_empty<T0: store>(arg0: &BigVector<T0>) : bool {
        arg0.length == 0
    }

    public(friend) fun remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : T0 {
        assert!(arg1 < length<T0>(arg0), 11);
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

    public(friend) fun swap_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : T0 {
        let v0 = pop_back<T0>(arg0);
        if (arg1 == length<T0>(arg0)) {
            v0
        } else {
            let v2 = &mut arg0.id;
            let v3 = borrow_slice_mut_<T0>(v2, arg1 / (arg0.slice_size as u64));
            0x1::vector::push_back<T0>(&mut v3.vector, v0);
            0x1::vector::swap_remove<T0>(&mut v3.vector, arg1 % (arg0.slice_size as u64))
        }
    }

    public(friend) fun new<T0: store>(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) : BigVector<T0> {
        BigVector<T0>{
            id         : 0x2::object::new(arg1),
            slice_idx  : 0,
            slice_size : arg0,
            length     : 0,
        }
    }

    public fun borrow_from_slice<T0: store>(arg0: &Slice<T0>, arg1: u64) : &T0 {
        assert!(arg1 < 0x1::vector::length<T0>(&arg0.vector), 11);
        0x1::vector::borrow<T0>(&arg0.vector, arg1)
    }

    public(friend) fun borrow_from_slice_mut<T0: store>(arg0: &mut Slice<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 < 0x1::vector::length<T0>(&arg0.vector), 11);
        0x1::vector::borrow_mut<T0>(&mut arg0.vector, arg1)
    }

    public fun borrow_slice<T0: store>(arg0: &BigVector<T0>, arg1: u64) : &Slice<T0> {
        assert!(arg1 <= arg0.slice_idx, 11);
        assert!(!is_empty<T0>(arg0), 10);
        borrow_slice_<T0>(&arg0.id, arg1)
    }

    fun borrow_slice_<T0: store>(arg0: &0x2::object::UID, arg1: u64) : &Slice<T0> {
        0x2::dynamic_field::borrow<u64, Slice<T0>>(arg0, arg1)
    }

    public(friend) fun borrow_slice_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : &mut Slice<T0> {
        assert!(arg1 <= arg0.slice_idx, 11);
        assert!(!is_empty<T0>(arg0), 10);
        let v0 = &mut arg0.id;
        borrow_slice_mut_<T0>(v0, arg1)
    }

    fun borrow_slice_mut_<T0: store>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut Slice<T0> {
        0x2::dynamic_field::borrow_mut<u64, Slice<T0>>(arg0, arg1)
    }

    public(friend) fun drop<T0: drop + store>(arg0: BigVector<T0>) {
        let BigVector {
            id         : v0,
            slice_idx  : v1,
            slice_size : _,
            length     : _,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        while (v4 > 0) {
            0x2::dynamic_field::remove<u64, Slice<T0>>(&mut v5, v4);
            v4 = v4 - 1;
        };
        0x2::dynamic_field::remove<u64, Slice<T0>>(&mut v5, v4);
        0x2::object::delete(v5);
    }

    public fun get_slice_idx<T0: store>(arg0: &Slice<T0>) : u64 {
        arg0.idx
    }

    public fun get_slice_length<T0: store>(arg0: &Slice<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.vector)
    }

    public fun slice_idx<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.slice_idx
    }

    public fun slice_size<T0: store>(arg0: &BigVector<T0>) : u32 {
        arg0.slice_size
    }

    fun trim_slice<T0: store>(arg0: &mut BigVector<T0>) {
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

