module 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator {
    struct Result has drop {
        inner: u8,
    }

    public fun compare<T0>(arg0: &T0, arg1: &T0) : Result {
        compare_u8_vector(0x1::bcs::to_bytes<T0>(arg0), 0x1::bcs::to_bytes<T0>(arg1))
    }

    fun compare_u8_vector(arg0: vector<u8>, arg1: vector<u8>) : Result {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg1, v2);
            if (v3 < v4) {
                return Result{inner: 1}
            };
            if (v3 > v4) {
                return Result{inner: 2}
            };
            v2 = v2 + 1;
        };
        if (v0 < v1) {
            Result{inner: 1}
        } else if (v0 > v1) {
            Result{inner: 2}
        } else {
            Result{inner: 0}
        }
    }

    public fun get_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"LP-");
        if (is_order<T0, T1>()) {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        } else {
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
            0x1::string::append_utf8(&mut v0, b"-");
            0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        };
        v0
    }

    public fun is_equal(arg0: &Result) : bool {
        arg0.inner == 0
    }

    public fun is_greater_than(arg0: &Result) : bool {
        arg0.inner == 2
    }

    public fun is_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = compare<0x1::type_name::TypeName>(&v0, &v1);
        assert!(!is_equal(&v2), 7);
        is_smaller_than(&v2)
    }

    public fun is_smaller_than(arg0: &Result) : bool {
        arg0.inner == 1
    }

    // decompiled from Move bytecode v6
}

