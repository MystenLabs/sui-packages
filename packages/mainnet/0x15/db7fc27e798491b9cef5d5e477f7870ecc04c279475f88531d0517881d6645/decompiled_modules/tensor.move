module 0x15db7fc27e798491b9cef5d5e477f7870ecc04c279475f88531d0517881d6645::tensor {
    struct Tensor has drop {
        shape: vector<u64>,
        data: vector<u64>,
    }

    struct SignedFixedTensor has copy, drop, store {
        shape: vector<u64>,
        magnitude: vector<u64>,
        sign: vector<u64>,
        scale: u64,
    }

    public fun add(arg0: &SignedFixedTensor, arg1: &SignedFixedTensor) : SignedFixedTensor {
        assert!(arg0.scale == arg1.scale, 1001);
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 == 0x1::vector::length<u64>(&arg1.magnitude), 1002);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = signed_add_element(*0x1::vector::borrow<u64>(&arg0.sign, v3), *0x1::vector::borrow<u64>(&arg0.magnitude, v3), *0x1::vector::borrow<u64>(&arg1.sign, v3), *0x1::vector::borrow<u64>(&arg1.magnitude, v3));
            0x1::vector::push_back<u64>(&mut v2, v4);
            0x1::vector::push_back<u64>(&mut v1, v5);
            v3 = v3 + 1;
        };
        create_signed_fixed(arg0.shape, v1, v2, arg0.scale)
    }

    fun append_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun argmax(arg0: &SignedFixedTensor) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 > 0, 2101);
        let v1 = *0x1::vector::borrow<u64>(&arg0.sign, 0);
        let v2 = *0x1::vector::borrow<u64>(&arg0.magnitude, 0);
        let v3 = 1;
        while (v3 < v0) {
            v1 = *0x1::vector::borrow<u64>(&arg0.sign, v3);
            v2 = *0x1::vector::borrow<u64>(&arg0.magnitude, v3);
            if (is_a_greater_than_b(v1, v2, v1, v2)) {
            };
            v3 = v3 + 1;
        };
        0
    }

    public fun create(arg0: vector<u64>, arg1: vector<u64>) : Tensor {
        assert!(0x1::vector::length<u64>(&arg0) > 0, 1);
        Tensor{
            shape : arg0,
            data  : arg1,
        }
    }

    public fun create_signed_fixed(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: u64) : SignedFixedTensor {
        num_elements(&arg0);
        SignedFixedTensor{
            shape     : arg0,
            magnitude : arg1,
            sign      : arg2,
            scale     : arg3,
        }
    }

    public fun debug_print_tensor(arg0: &SignedFixedTensor) {
        let v0 = 0x1::string::utf8(to_string(arg0));
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public fun divide(arg0: &SignedFixedTensor, arg1: &SignedFixedTensor) : SignedFixedTensor {
        assert!(arg0.scale == arg1.scale, 1301);
        let v0 = arg0.scale;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg0.magnitude)) {
            let v4 = *0x1::vector::borrow<u64>(&arg1.magnitude, v3);
            let v5 = if (*0x1::vector::borrow<u64>(&arg0.sign, v3) == *0x1::vector::borrow<u64>(&arg1.sign, v3)) {
                0
            } else {
                1
            };
            assert!(v4 != 0, 9999);
            0x1::vector::push_back<u64>(&mut v2, v5);
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg0.magnitude, v3) * scale_up(1, v0) / v4);
            v3 = v3 + 1;
        };
        create_signed_fixed(arg0.shape, v1, v2, v0)
    }

    public fun from_input(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>, arg3: u64) : SignedFixedTensor {
        create_signed_fixed(arg0, arg1, arg2, arg3)
    }

    public fun get_data(arg0: &Tensor) : vector<u64> {
        arg0.data
    }

    public fun get_magnitude(arg0: &SignedFixedTensor) : vector<u64> {
        arg0.magnitude
    }

    public fun get_scale(arg0: &SignedFixedTensor) : u64 {
        arg0.scale
    }

    public fun get_shape(arg0: &SignedFixedTensor) : vector<u64> {
        arg0.shape
    }

    public fun get_sign(arg0: &SignedFixedTensor) : vector<u64> {
        arg0.sign
    }

    fun is_a_greater_than_b(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0 == 0 && arg2 == 1) {
            return true
        };
        if (arg0 == 1 && arg2 == 0) {
            return false
        };
        if (arg0 == 0 && arg2 == 0) {
            return arg1 > arg3
        };
        arg1 < arg3
    }

    public fun max_value(arg0: &SignedFixedTensor) : SignedFixedTensor {
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 > 0, 2001);
        let v1 = *0x1::vector::borrow<u64>(&arg0.sign, 0);
        let v2 = *0x1::vector::borrow<u64>(&arg0.magnitude, 0);
        let v3 = 1;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg0.sign, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg0.magnitude, v3);
            if (is_a_greater_than_b(v4, v5, v1, v2)) {
                v1 = v4;
                v2 = v5;
            };
            v3 = v3 + 1;
        };
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, 1);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v7, v2);
        0x1::vector::push_back<u64>(&mut v8, v1);
        create_signed_fixed(v6, v7, v8, arg0.scale)
    }

    public fun multiply(arg0: &SignedFixedTensor, arg1: &SignedFixedTensor) : SignedFixedTensor {
        assert!(arg0.scale == arg1.scale, 1201);
        let v0 = 0x1::vector::length<u64>(&arg0.magnitude);
        assert!(v0 == 0x1::vector::length<u64>(&arg1.magnitude), 1202);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (*0x1::vector::borrow<u64>(&arg0.sign, v3) == *0x1::vector::borrow<u64>(&arg1.sign, v3)) {
                0
            } else {
                1
            };
            0x1::vector::push_back<u64>(&mut v2, v4);
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg0.magnitude, v3) * *0x1::vector::borrow<u64>(&arg1.magnitude, v3));
            v3 = v3 + 1;
        };
        create_signed_fixed(arg0.shape, v1, v2, arg0.scale * 2)
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

    public fun scale_up(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun signed_add_element(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg0 == arg2) {
            (arg0, arg1 + arg3)
        } else if (arg1 >= arg3) {
            (arg0, arg1 - arg3)
        } else {
            (arg2, arg3 - arg1)
        }
    }

    public fun subtract(arg0: &SignedFixedTensor, arg1: &SignedFixedTensor) : SignedFixedTensor {
        assert!(arg0.scale == arg1.scale, 1101);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1.sign)) {
            let v2 = if (*0x1::vector::borrow<u64>(&arg1.sign, v1) == 0) {
                1
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = create_signed_fixed(arg1.shape, arg1.magnitude, v0, arg1.scale);
        add(arg0, &v3)
    }

    public fun to_input(arg0: &SignedFixedTensor) : (vector<u64>, vector<u64>) {
        (arg0.magnitude, arg0.sign)
    }

    public fun to_string(arg0: &SignedFixedTensor) : vector<u8> {
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
            let v8 = scale_up(1, arg0.scale);
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

    // decompiled from Move bytecode v6
}

