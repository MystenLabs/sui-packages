module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms {
    struct TermField has copy, drop, store {
        key: 0x1::string::String,
        is_string: bool,
        text: 0x1::string::String,
    }

    public fun amount_text_fits(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        let v2 = 0;
        while (v2 < v1 && is_digit(*0x1::vector::borrow<u8>(v0, v2))) {
            v2 = v2 + 1;
        };
        if (v2 == 0) {
            return false
        };
        if (v2 < v1 && *0x1::vector::borrow<u8>(v0, v2) == 46) {
            v2 = v2 + 1;
            while (v2 < v1 && is_digit(*0x1::vector::borrow<u8>(v0, v2))) {
                v2 = v2 + 1;
            };
            if (v2 == v2) {
                return false
            };
        };
        if (v2 >= v1 || *0x1::vector::borrow<u8>(v0, v2) != 32) {
            return false
        };
        let v3 = v2 + 1;
        v2 = v3;
        if (v1 != v3 + 3) {
            return false
        };
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(v0, v2) < 65 || *0x1::vector::borrow<u8>(v0, v2) > 90) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun exact_keys(arg0: &vector<TermField>, arg1: vector<vector<u8>>) : bool {
        if (0x1::vector::length<TermField>(arg0) != 0x1::vector::length<vector<u8>>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = false;
            let v2 = 0;
            while (v2 < 0x1::vector::length<TermField>(arg0)) {
                if (0x1::string::as_bytes(term_key(0x1::vector::borrow<TermField>(arg0, v2))) == 0x1::vector::borrow<vector<u8>>(&arg1, v0)) {
                    v1 = true;
                };
                v2 = v2 + 1;
            };
            if (!v1) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun field(arg0: &vector<TermField>, arg1: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TermField>(arg0)) {
            if (0x1::string::as_bytes(term_key(0x1::vector::borrow<TermField>(arg0, v0))) == &arg1) {
                if (!term_is_string(0x1::vector::borrow<TermField>(arg0, v0))) {
                    return 0x1::option::none<0x1::string::String>()
                };
                return 0x1::option::some<0x1::string::String>(*term_text(0x1::vector::borrow<TermField>(arg0, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x1::string::String>()
    }

    fun is_digit(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57
    }

    public fun norms_text_fits(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 2 || *0x1::vector::borrow<u8>(v0, 0) != 91) {
            return false
        };
        let v2 = 1;
        let v3 = 0;
        let v4;
        loop {
            if (v2 >= v1 || *0x1::vector::borrow<u8>(v0, v2) != 123) {
                return false
            };
            v2 = v2 + 1;
            let v5 = false;
            let v6 = false;
            let v7 = false;
            let v8;
            loop {
                let v9 = scan_string(v0, v2);
                if (0x1::option::is_none<u64>(&v9)) {
                    return false
                };
                let v10 = 0x1::option::destroy_some<u64>(v9);
                if (slice_eq(v0, v2 + 1, v10 - 1, b"statement")) {
                    if (v5) {
                        return false
                    };
                    v5 = true;
                } else if (slice_eq(v0, v2 + 1, v10 - 1, b"procedure_ref")) {
                    if (v6) {
                        return false
                    };
                    v6 = true;
                } else if (slice_eq(v0, v2 + 1, v10 - 1, b"at")) {
                    if (v7) {
                        return false
                    };
                    v7 = true;
                } else {
                    return false
                };
                if (v10 >= v1 || *0x1::vector::borrow<u8>(v0, v10) != 58) {
                    return false
                };
                let v11 = scan_string(v0, v10 + 1);
                if (0x1::option::is_none<u64>(&v11)) {
                    return false
                };
                v8 = 0x1::option::destroy_some<u64>(v11);
                if (v8 >= v1) {
                    return false
                };
                if (*0x1::vector::borrow<u8>(v0, v8) == 44) {
                    v2 = v8 + 1;
                } else {
                    break
                };
            };
            if (*0x1::vector::borrow<u8>(v0, v8) == 125) {
                v4 = v8 + 1;
                let v12 = if (v5) {
                    if (v6) {
                        v7
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (!v12) {
                    return false
                };
                v3 = v3 + 1;
                if (v4 >= v1) {
                    return false
                };
                if (*0x1::vector::borrow<u8>(v0, v4) == 44) {
                    v2 = v4 + 1;
                    continue
                } else {
                    break
                };
            };
            return false
        };
        if (*0x1::vector::borrow<u8>(v0, v4) == 93) {
            return v3 >= 1 && v4 + 1 == v1
        };
        false
    }

    public fun raw_field(arg0: &vector<TermField>, arg1: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TermField>(arg0)) {
            if (0x1::string::as_bytes(term_key(0x1::vector::borrow<TermField>(arg0, v0))) == &arg1) {
                if (term_is_string(0x1::vector::borrow<TermField>(arg0, v0))) {
                    return 0x1::option::none<0x1::string::String>()
                };
                return 0x1::option::some<0x1::string::String>(*term_text(0x1::vector::borrow<TermField>(arg0, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x1::string::String>()
    }

    fun scan_string(arg0: &vector<u8>, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (arg1 >= v0 || *0x1::vector::borrow<u8>(arg0, arg1) != 34) {
            return 0x1::option::none<u64>()
        };
        let v1 = arg1 + 1;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 == 92) {
                v1 = v1 + 2;
                continue
            };
            if (v2 == 34) {
                return 0x1::option::some<u64>(v1 + 1)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<u64>()
    }

    fun slice_eq(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: vector<u8>) : bool {
        if (arg2 < arg1 || arg2 - arg1 != 0x1::vector::length<u8>(&arg3)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg3)) {
            if (*0x1::vector::borrow<u8>(arg0, arg1 + v0) != *0x1::vector::borrow<u8>(&arg3, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun term(arg0: 0x1::string::String, arg1: bool, arg2: 0x1::string::String) : TermField {
        TermField{
            key       : arg0,
            is_string : arg1,
            text      : arg2,
        }
    }

    public fun term_is_string(arg0: &TermField) : bool {
        arg0.is_string
    }

    public fun term_key(arg0: &TermField) : &0x1::string::String {
        &arg0.key
    }

    public fun term_text(arg0: &TermField) : &0x1::string::String {
        &arg0.text
    }

    // decompiled from Move bytecode v7
}

