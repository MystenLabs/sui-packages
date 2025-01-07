module 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::big_vector {
    struct BigVector<phantom T0> has store, key {
        id: 0x2::object::UID,
        slice_count: u64,
        slice_size: u64,
        length: u64,
    }

    public fun length<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.length
    }

    public fun borrow<T0: store>(arg0: &BigVector<T0>, arg1: u64) : &T0 {
        0x1::vector::borrow<T0>(0x2::dynamic_field::borrow<u64, vector<T0>>(&arg0.id, arg1 / arg0.slice_size + 1), arg1 % arg0.slice_size)
    }

    public fun push_back<T0: store>(arg0: &mut BigVector<T0>, arg1: T0) {
        if (length<T0>(arg0) / arg0.slice_size == arg0.slice_count) {
            arg0.slice_count = arg0.slice_count + 1;
            0x2::dynamic_field::add<u64, vector<T0>>(&mut arg0.id, arg0.slice_count, 0x1::vector::singleton<T0>(arg1));
        } else {
            0x1::vector::push_back<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg0.slice_count), arg1);
        };
        arg0.length = arg0.length + 1;
    }

    public fun borrow_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : &mut T0 {
        0x1::vector::borrow_mut<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg1 / arg0.slice_size + 1), arg1 % arg0.slice_size)
    }

    public fun pop_back<T0: store>(arg0: &mut BigVector<T0>) : T0 {
        let v0 = 0x1::vector::pop_back<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg0.slice_count));
        trim_slice<T0>(arg0);
        arg0.length = arg0.length - 1;
        v0
    }

    public fun destroy_empty<T0: store>(arg0: BigVector<T0>) {
        assert!(arg0.slice_count == 1, 0);
        0x1::vector::destroy_empty<T0>(0x2::dynamic_field::remove<u64, vector<T0>>(&mut arg0.id, 1));
        let BigVector {
            id          : v0,
            slice_count : _,
            slice_size  : _,
            length      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : T0 {
        let v0 = 0x1::vector::remove<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg1 / arg0.slice_size + 1), arg1 % arg0.slice_size);
        let v1 = arg0.slice_count;
        while (v1 > arg1 / arg0.slice_size + 1 && v1 > 1) {
            0x1::vector::push_back<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v1 - 1), 0x1::vector::remove<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v1), 0));
            v1 = v1 - 1;
        };
        trim_slice<T0>(arg0);
        arg0.length = arg0.length - 1;
        v0
    }

    public fun swap_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : T0 {
        let v0 = pop_back<T0>(arg0);
        if (arg1 == length<T0>(arg0)) {
            v0
        } else {
            let v2 = 0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg1 / arg0.slice_size + 1);
            0x1::vector::push_back<T0>(v2, v0);
            0x1::vector::swap_remove<T0>(v2, arg1 % arg0.slice_size)
        }
    }

    public fun new<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BigVector<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = 1;
        0x2::dynamic_field::add<u64, vector<T0>>(&mut v0, v1, 0x1::vector::empty<T0>());
        BigVector<T0>{
            id          : v0,
            slice_count : v1,
            slice_size  : arg0,
            length      : 0,
        }
    }

    public fun borrow_slice<T0: store>(arg0: &BigVector<T0>, arg1: u64) : &vector<T0> {
        0x2::dynamic_field::borrow<u64, vector<T0>>(&arg0.id, arg1)
    }

    public fun borrow_slice_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : &mut vector<T0> {
        0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg1)
    }

    public fun is_empty<T0: store>(arg0: &BigVector<T0>) : bool {
        arg0.length == 0
    }

    public fun slice_count<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.slice_count
    }

    public fun slice_id<T0: store>(arg0: &BigVector<T0>, arg1: u64) : u64 {
        arg1 / arg0.slice_size + 1
    }

    public fun slice_size<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.slice_size
    }

    fun trim_slice<T0: store>(arg0: &mut BigVector<T0>) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg0.slice_count);
        if (arg0.slice_count > 1 && 0x1::vector::length<T0>(v0) == 0) {
            0x1::vector::destroy_empty<T0>(0x2::dynamic_field::remove<u64, vector<T0>>(&mut arg0.id, arg0.slice_count));
            arg0.slice_count = arg0.slice_count - 1;
        };
    }

    // decompiled from Move bytecode v6
}

