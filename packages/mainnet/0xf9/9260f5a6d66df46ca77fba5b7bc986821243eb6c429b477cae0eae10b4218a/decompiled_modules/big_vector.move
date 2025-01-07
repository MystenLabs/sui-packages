module 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::big_vector {
    struct BigVector<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        end_index: u64,
        bucket_size: u64,
        length: u64,
    }

    public fun length<T0: store>(arg0: &BigVector<T0>) : u64 {
        arg0.end_index
    }

    public fun borrow<T0: store>(arg0: &BigVector<T0>, arg1: u64) : &T0 {
        assert!(arg1 < length<T0>(arg0), 1);
        0x1::vector::borrow<T0>(0x2::dynamic_field::borrow<u64, vector<T0>>(&arg0.id, arg1 / arg0.bucket_size), arg1 % arg0.bucket_size)
    }

    public fun push_back<T0: store>(arg0: &mut BigVector<T0>, arg1: T0) {
        let v0 = arg0.length;
        if (arg0.end_index == v0 * arg0.bucket_size) {
            let v1 = 0x1::vector::empty<T0>();
            0x1::vector::push_back<T0>(&mut v1, arg1);
            add<T0>(arg0, v0, v1);
        } else {
            0x1::vector::push_back<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v0 - 1), arg1);
        };
        arg0.end_index = arg0.end_index + 1;
    }

    public fun borrow_mut<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 < length<T0>(arg0), 1);
        0x1::vector::borrow_mut<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg1 / arg0.bucket_size), arg1 % arg0.bucket_size)
    }

    public fun pop_back<T0: store>(arg0: &mut BigVector<T0>) : T0 {
        assert!(!is_empty<T0>(arg0), 2);
        let v0 = arg0.length;
        let v1 = 0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v0 - 1);
        if (0x1::vector::is_empty<T0>(v1)) {
            let v2 = df_remove<T0>(arg0, v0 - 1);
            0x1::vector::destroy_empty<T0>(v2);
        };
        arg0.end_index = arg0.end_index - 1;
        0x1::vector::pop_back<T0>(v1)
    }

    public fun destroy_empty<T0: store>(arg0: BigVector<T0>) {
        assert!(is_empty<T0>(&arg0), 3);
        let BigVector {
            id          : v0,
            end_index   : _,
            bucket_size : _,
            length      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun swap<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: u64) {
        assert!(arg1 < length<T0>(arg0) && arg2 < length<T0>(arg0), 1);
        let v0 = arg1 / arg0.bucket_size;
        let v1 = arg2 / arg0.bucket_size;
        let v2 = arg1 % arg0.bucket_size;
        let v3 = arg2 % arg0.bucket_size;
        if (v0 == v1) {
            0x1::vector::swap<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v0), v2, v3);
            return
        };
        let v4 = df_remove<T0>(arg0, v0);
        let v5 = df_remove<T0>(arg0, v1);
        0x1::vector::push_back<T0>(&mut v4, 0x1::vector::swap_remove<T0>(&mut v5, v3));
        0x1::vector::push_back<T0>(&mut v5, 0x1::vector::swap_remove<T0>(&mut v4, v2));
        0x1::vector::swap<T0>(&mut v4, v2, 0x1::vector::length<T0>(&v4) - 1);
        0x1::vector::swap<T0>(&mut v5, v3, 0x1::vector::length<T0>(&v5) - 1);
        add<T0>(arg0, v0, v4);
        add<T0>(arg0, v1, v5);
    }

    public fun append<T0: store>(arg0: &mut BigVector<T0>, arg1: BigVector<T0>) {
        let v0 = length<T0>(&arg1);
        let v1 = 0;
        while (v1 < v0 / 2) {
            let v2 = &mut arg1;
            push_back<T0>(arg0, swap_remove<T0>(v2, v1));
            v1 = v1 + 1;
        };
        while (v1 < v0) {
            let v3 = &mut arg1;
            push_back<T0>(arg0, pop_back<T0>(v3));
            v1 = v1 + 1;
        };
        destroy_empty<T0>(arg1);
    }

    public fun index_of<T0: store>(arg0: &BigVector<T0>, arg1: &T0) : (bool, u64) {
        let v0 = 0;
        while (v0 < arg0.length) {
            let (v1, v2) = 0x1::vector::index_of<T0>(0x2::dynamic_field::borrow<u64, vector<T0>>(&arg0.id, v0), arg1);
            if (v1) {
                return (true, v0 * arg0.bucket_size + v2)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun is_empty<T0: store>(arg0: &BigVector<T0>) : bool {
        length<T0>(arg0) == 0
    }

    public fun remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : T0 {
        assert!(arg1 < length<T0>(arg0), 1);
        let v0 = arg0.length;
        let v1 = arg1 / arg0.bucket_size + 1;
        let v2 = 0x1::vector::remove<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v1 - 1), arg1 % arg0.bucket_size);
        arg0.end_index = arg0.end_index - 1;
        while (v1 < v0) {
            0x1::vector::push_back<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v1 - 1), 0x1::vector::remove<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v1), 0));
            v1 = v1 + 1;
        };
        if (0x1::vector::is_empty<T0>(0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, v0 - 1))) {
            0x1::vector::destroy_empty<T0>(df_remove<T0>(arg0, v0 - 1));
        };
        v2
    }

    public fun reverse<T0: store>(arg0: &mut BigVector<T0>) {
        let v0 = 0x1::vector::empty<vector<T0>>();
        let v1 = 0x1::vector::empty<T0>();
        let v2 = arg0.length;
        while (v2 > 0) {
            let v3 = df_remove<T0>(arg0, v2 - 1);
            let v4 = 0x1::vector::length<T0>(&v3);
            while (v4 > 0) {
                0x1::vector::push_back<T0>(&mut v1, 0x1::vector::pop_back<T0>(&mut v3));
                if (0x1::vector::length<T0>(&v1) == arg0.bucket_size) {
                    0x1::vector::push_back<vector<T0>>(&mut v0, v1);
                    v1 = 0x1::vector::empty<T0>();
                };
                v4 = v4 - 1;
            };
            0x1::vector::destroy_empty<T0>(v3);
            v2 = v2 - 1;
        };
        if (0x1::vector::length<T0>(&v1) > 0) {
            0x1::vector::push_back<vector<T0>>(&mut v0, v1);
        } else {
            0x1::vector::destroy_empty<T0>(v1);
        };
        0x1::vector::reverse<vector<T0>>(&mut v0);
        let v5 = 0;
        assert!(arg0.length == 0, 0);
        while (v5 < v2) {
            add<T0>(arg0, v5, 0x1::vector::pop_back<vector<T0>>(&mut v0));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<vector<T0>>(v0);
    }

    public fun swap_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : T0 {
        assert!(arg1 < length<T0>(arg0), 1);
        let v0 = pop_back<T0>(arg0);
        if (arg0.end_index == arg1) {
            return v0
        };
        let v1 = 0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.id, arg1 / arg0.bucket_size);
        0x1::vector::push_back<T0>(v1, v0);
        0x1::vector::swap<T0>(v1, arg1 % arg0.bucket_size, 0x1::vector::length<T0>(v1) - 1);
        0x1::vector::swap_remove<T0>(v1, arg1 % arg0.bucket_size)
    }

    fun add<T0: store>(arg0: &mut BigVector<T0>, arg1: u64, arg2: vector<T0>) {
        0x2::dynamic_field::add<u64, vector<T0>>(&mut arg0.id, arg1, arg2);
        arg0.length = arg0.length + 1;
    }

    public(friend) fun new<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BigVector<T0> {
        assert!(arg0 > 0, 4);
        BigVector<T0>{
            id          : 0x2::object::new(arg1),
            end_index   : 0,
            bucket_size : arg0,
            length      : 0,
        }
    }

    public fun contains<T0: store>(arg0: &BigVector<T0>, arg1: &T0) : bool {
        if (is_empty<T0>(arg0)) {
            return false
        };
        let (v0, _) = index_of<T0>(arg0, arg1);
        v0
    }

    public fun destroy<T0: drop + store>(arg0: BigVector<T0>) {
        let BigVector {
            id          : v0,
            end_index   : v1,
            bucket_size : _,
            length      : _,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0;
        while (v4 > 0) {
            let v7 = 0x2::dynamic_field::remove<u64, vector<T0>>(&mut v5, v6);
            v4 = v4 - 0x1::vector::length<T0>(&v7);
            v6 = v6 + 1;
        };
        0x2::object::delete(v5);
    }

    fun df_remove<T0: store>(arg0: &mut BigVector<T0>, arg1: u64) : vector<T0> {
        arg0.length = arg0.length - 1;
        0x2::dynamic_field::remove<u64, vector<T0>>(&mut arg0.id, arg1)
    }

    public(friend) fun singleton<T0: store>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BigVector<T0> {
        let v0 = new<T0>(arg1, arg2);
        let v1 = &mut v0;
        push_back<T0>(v1, arg0);
        v0
    }

    public fun to_vector<T0: copy + store>(arg0: &BigVector<T0>) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0;
        while (v1 < arg0.length) {
            0x1::vector::append<T0>(&mut v0, *0x2::dynamic_field::borrow<u64, vector<T0>>(&arg0.id, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

