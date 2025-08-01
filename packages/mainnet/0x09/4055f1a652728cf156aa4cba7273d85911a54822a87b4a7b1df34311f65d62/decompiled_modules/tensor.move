module 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::tensor {
    struct Tensor has copy, drop, store {
        shape: vector<u64>,
        magnitude: vector<u64>,
        sign: vector<u64>,
        scale: u64,
    }

    public fun add(arg0: &Tensor, arg1: &Tensor) : Tensor {
        assert!(arg0.scale == arg1.scale, 1001);
        assert!(arg0.shape == arg1.shape, 1002);
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 == 0x1::vector::length<u64>(&arg1.magnitude), 1002);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::add(*0x1::vector::borrow<u64>(&arg0.sign, v3), *0x1::vector::borrow<u64>(&arg0.magnitude, v3), *0x1::vector::borrow<u64>(&arg1.sign, v3), *0x1::vector::borrow<u64>(&arg1.magnitude, v3));
            0x1::vector::push_back<u64>(&mut v2, v4);
            0x1::vector::push_back<u64>(&mut v1, v5);
            v3 = v3 + 1;
        };
        Tensor{
            shape     : arg0.shape,
            magnitude : v1,
            sign      : v2,
            scale     : arg0.scale,
        }
    }

    public fun multiply(arg0: &Tensor, arg1: &Tensor) : Tensor {
        assert!(arg0.scale == arg1.scale, 1201);
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 == 0x1::vector::length<u64>(&arg1.magnitude), 1202);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::multiply(*0x1::vector::borrow<u64>(&arg0.sign, v3), *0x1::vector::borrow<u64>(&arg0.magnitude, v3), *0x1::vector::borrow<u64>(&arg1.sign, v3), *0x1::vector::borrow<u64>(&arg1.magnitude, v3), arg0.scale);
            0x1::vector::push_back<u64>(&mut v2, v4);
            0x1::vector::push_back<u64>(&mut v1, v5);
            v3 = v3 + 1;
        };
        Tensor{
            shape     : arg0.shape,
            magnitude : v1,
            sign      : v2,
            scale     : arg0.scale,
        }
    }

    fun append_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun argmax(arg0: &Tensor) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 > 0, 2101);
        let v1 = *0x1::vector::borrow<u64>(&arg0.sign, 0);
        let v2 = *0x1::vector::borrow<u64>(&arg0.magnitude, 0);
        let v3 = 1;
        while (v3 < v0) {
            v1 = *0x1::vector::borrow<u64>(&arg0.sign, v3);
            v2 = *0x1::vector::borrow<u64>(&arg0.magnitude, v3);
            if (0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::compare(v1, v2, v1, v2)) {
            };
            v3 = v3 + 1;
        };
        0
    }

    public fun debug_print_tensor(arg0: &Tensor) {
        let v0 = 0x1::string::utf8(to_string(arg0));
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public fun get_magnitude(arg0: &Tensor) : vector<u64> {
        arg0.magnitude
    }

    public fun get_scale(arg0: &Tensor) : u64 {
        arg0.scale
    }

    public fun get_shape(arg0: &Tensor) : vector<u64> {
        arg0.shape
    }

    public fun get_sign(arg0: &Tensor) : vector<u64> {
        arg0.sign
    }

    fun init_zero_vector(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun max_value(arg0: &Tensor) : (u64, u64) {
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 > 0, 2001);
        let v1 = *0x1::vector::borrow<u64>(&arg0.sign, 0);
        let v2 = *0x1::vector::borrow<u64>(&arg0.magnitude, 0);
        let v3 = 1;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg0.sign, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg0.magnitude, v3);
            if (0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::compare(v4, v5, v1, v2)) {
                v1 = v4;
                v2 = v5;
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun new_tensor(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: u64) : Tensor {
        let v0 = num_elements(&arg0);
        let v1 = if (0x1::vector::is_empty<u64>(&arg1)) {
            init_zero_vector(v0)
        } else {
            arg1
        };
        let v2 = if (0x1::vector::is_empty<u64>(&arg2)) {
            init_zero_vector(v0)
        } else {
            arg2
        };
        Tensor{
            shape     : arg0,
            magnitude : v1,
            sign      : v2,
            scale     : arg3,
        }
    }

    public fun num_elements(arg0: &vector<u64>) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 * *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun reverse_bytes(arg0: &mut vector<u8>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        if (v1 == 0) {
            return
        };
        let v2 = v1 - 1;
        while (v0 < v2) {
            *0x1::vector::borrow_mut<u8>(arg0, v0) = *0x1::vector::borrow<u8>(arg0, v2);
            *0x1::vector::borrow_mut<u8>(arg0, v2) = *0x1::vector::borrow<u8>(arg0, v0);
            v0 = v0 + 1;
            v2 = v2 - 1;
        };
    }

    fun safe_to_u8(arg0: u64) : u8 {
        assert!(arg0 >= 48 && arg0 <= 57, 9999);
        if (arg0 == 48) {
            return 48
        };
        if (arg0 == 49) {
            return 49
        };
        if (arg0 == 50) {
            return 50
        };
        if (arg0 == 51) {
            return 51
        };
        if (arg0 == 52) {
            return 52
        };
        if (arg0 == 53) {
            return 53
        };
        if (arg0 == 54) {
            return 54
        };
        if (arg0 == 55) {
            return 55
        };
        if (arg0 == 56) {
            return 56
        };
        assert!(arg0 == 57, 9999);
        57
    }

    public fun to_string(arg0: &Tensor) : vector<u8> {
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        let v3 = b"[";
        append_bytes(v2, &v3);
        let v4 = 0;
        while (v4 < v0) {
            if (*0x1::vector::borrow<u64>(&arg0.sign, v4) == 1) {
                let v5 = &mut v1;
                let v6 = b"-";
                append_bytes(v5, &v6);
            };
            let v7 = *0x1::vector::borrow<u64>(&arg0.magnitude, v4);
            let v8 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::scale_up(1, arg0.scale);
            let v9 = u64_to_bytes(v7 / v8);
            let v10 = &mut v1;
            append_bytes(v10, &v9);
            let v11 = &mut v1;
            let v12 = b".";
            append_bytes(v11, &v12);
            let v13 = u64_to_bytes(v7 % v8);
            let v14 = &mut v1;
            append_bytes(v14, &v13);
            if (v4 < v0 - 1) {
                let v15 = &mut v1;
                let v16 = b", ";
                append_bytes(v15, &v16);
            };
            v4 = v4 + 1;
        };
        let v17 = &mut v1;
        let v18 = b"]";
        append_bytes(v17, &v18);
        v1
    }

    public fun to_string_optimized(arg0: &Tensor) : vector<u8> {
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        let v3 = b"[";
        append_bytes(v2, &v3);
        let v4 = 0;
        while (v4 < v0) {
            if (*0x1::vector::borrow<u64>(&arg0.sign, v4) == 1) {
                let v5 = &mut v1;
                let v6 = b"-";
                append_bytes(v5, &v6);
            };
            let v7 = *0x1::vector::borrow<u64>(&arg0.magnitude, v4);
            let v8 = 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::math::scale_up(1, arg0.scale);
            let v9 = u64_to_bytes(v7 / v8);
            let v10 = &mut v1;
            append_bytes(v10, &v9);
            let v11 = &mut v1;
            let v12 = b".";
            append_bytes(v11, &v12);
            let v13 = u64_to_bytes(v7 % v8);
            let v14 = &mut v1;
            append_bytes(v14, &v13);
            if (v4 < v0 - 1) {
                let v15 = &mut v1;
                let v16 = b", ";
                append_bytes(v15, &v16);
            };
            v4 = v4 + 1;
        };
        let v17 = &mut v1;
        let v18 = b"]";
        append_bytes(v17, &v18);
        v1
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            let v0 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v0, 48);
            return v0
        };
        let v1 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v1, safe_to_u8(48 + arg0 % 10));
            arg0 = arg0 / 10;
        };
        let v2 = &mut v1;
        reverse_bytes(v2);
        v1
    }

    public fun update_values(arg0: &mut Tensor, arg1: u64, arg2: vector<u64>, arg3: vector<u64>) {
        let v0 = num_elements(&arg0.shape);
        let v1 = 0x1::vector::length<u64>(&arg2);
        let v2 = 0x1::vector::length<u64>(&arg0.magnitude);
        let v3 = 0x1::vector::length<u64>(&arg0.sign);
        assert!(v2 == v0, 2004);
        assert!(v3 == v0, 2005);
        assert!(arg1 < v0, 2001);
        assert!(arg1 + v1 <= v0, 2002);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 2003);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = arg1 + v4;
            assert!(v5 < v2, 2006);
            assert!(v5 < v3, 2007);
            *0x1::vector::borrow_mut<u64>(&mut arg0.magnitude, v5) = *0x1::vector::borrow<u64>(&arg2, v4);
            *0x1::vector::borrow_mut<u64>(&mut arg0.sign, v5) = *0x1::vector::borrow<u64>(&arg3, v4);
            v4 = v4 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

