module 0x2::group_ops {
    struct Element<phantom T0> has copy, drop, store {
        bytes: vector<u8>,
    }

    public(friend) fun add<T0>(arg0: u8, arg1: &Element<T0>, arg2: &Element<T0>) : Element<T0> {
        Element<T0>{bytes: internal_add(arg0, &arg1.bytes, &arg2.bytes)}
    }

    public fun bytes<T0>(arg0: &Element<T0>) : &vector<u8> {
        &arg0.bytes
    }

    public(friend) fun convert<T0, T1>(arg0: u8, arg1: u8, arg2: &Element<T0>) : Element<T1> {
        Element<T1>{bytes: internal_convert(arg0, arg1, &arg2.bytes)}
    }

    public(friend) fun div<T0, T1>(arg0: u8, arg1: &Element<T0>, arg2: &Element<T1>) : Element<T1> {
        Element<T1>{bytes: internal_div(arg0, &arg1.bytes, &arg2.bytes)}
    }

    public fun equal<T0>(arg0: &Element<T0>, arg1: &Element<T0>) : bool {
        &arg0.bytes == &arg1.bytes
    }

    public(friend) fun from_bytes<T0>(arg0: u8, arg1: vector<u8>, arg2: bool) : Element<T0> {
        assert!(arg2 || internal_validate(arg0, &arg1), 1);
        Element<T0>{bytes: arg1}
    }

    public(friend) fun hash_to<T0>(arg0: u8, arg1: &vector<u8>) : Element<T0> {
        Element<T0>{bytes: internal_hash_to(arg0, arg1)}
    }

    native fun internal_add(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8>;
    native fun internal_convert(arg0: u8, arg1: u8, arg2: &vector<u8>) : vector<u8>;
    native fun internal_div(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8>;
    native fun internal_hash_to(arg0: u8, arg1: &vector<u8>) : vector<u8>;
    native fun internal_mul(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8>;
    native fun internal_multi_scalar_mul(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8>;
    native fun internal_pairing(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8>;
    native fun internal_sub(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8>;
    native fun internal_sum(arg0: u8, arg1: &vector<vector<u8>>) : vector<u8>;
    native fun internal_validate(arg0: u8, arg1: &vector<u8>) : bool;
    public(friend) fun mul<T0, T1>(arg0: u8, arg1: &Element<T0>, arg2: &Element<T1>) : Element<T1> {
        Element<T1>{bytes: internal_mul(arg0, &arg1.bytes, &arg2.bytes)}
    }

    public(friend) fun multi_scalar_multiplication<T0, T1>(arg0: u8, arg1: &vector<Element<T0>>, arg2: &vector<Element<T1>>) : Element<T1> {
        assert!(0x1::vector::length<Element<T0>>(arg1) > 0, 1);
        assert!(0x1::vector::length<Element<T0>>(arg1) == 0x1::vector::length<Element<T1>>(arg2), 1);
        let v0 = b"";
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<Element<T0>>(arg1)) {
            let v3 = *0x1::vector::borrow<Element<T0>>(arg1, v2);
            0x1::vector::append<u8>(&mut v0, v3.bytes);
            let v4 = *0x1::vector::borrow<Element<T1>>(arg2, v2);
            0x1::vector::append<u8>(&mut v1, v4.bytes);
            v2 = v2 + 1;
        };
        Element<T1>{bytes: internal_multi_scalar_mul(arg0, &v0, &v1)}
    }

    public(friend) fun pairing<T0, T1, T2>(arg0: u8, arg1: &Element<T0>, arg2: &Element<T1>) : Element<T2> {
        Element<T2>{bytes: internal_pairing(arg0, &arg1.bytes, &arg2.bytes)}
    }

    public(friend) fun set_as_prefix(arg0: u64, arg1: bool, arg2: &mut vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg2);
        assert!(v0 > 7, 3);
        let v1 = 0x2::bcs::to_bytes<u64>(&arg0);
        let v2 = 0;
        while (v2 < 8) {
            let v3 = if (arg1) {
                v0 - v2 - 1
            } else {
                v2
            };
            *0x1::vector::borrow_mut<u8>(arg2, v3) = *0x1::vector::borrow<u8>(&v1, v2);
            v2 = v2 + 1;
        };
    }

    public(friend) fun sub<T0>(arg0: u8, arg1: &Element<T0>, arg2: &Element<T0>) : Element<T0> {
        Element<T0>{bytes: internal_sub(arg0, &arg1.bytes, &arg2.bytes)}
    }

    public(friend) fun sum<T0>(arg0: u8, arg1: &vector<Element<T0>>) : Element<T0> {
        let v0 = vector[];
        let v1 = *arg1;
        0x1::vector::reverse<Element<T0>>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Element<T0>>(&v1)) {
            let v3 = 0x1::vector::pop_back<Element<T0>>(&mut v1);
            0x1::vector::push_back<vector<u8>>(&mut v0, v3.bytes);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Element<T0>>(v1);
        Element<T0>{bytes: internal_sum(arg0, &v0)}
    }

    // decompiled from Move bytecode v6
}

