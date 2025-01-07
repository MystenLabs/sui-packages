module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util {
    public fun contains_any(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<u8>(arg1)) {
                if (0x1::vector::borrow<u8>(arg0, v0) == 0x1::vector::borrow<u8>(arg1, v1)) {
                    return true
                };
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun index_of(arg0: &vector<u8>, arg1: &vector<u8>) : (bool, u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v0 < v1) {
            return (false, 0)
        };
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0;
            while (v3 < v1) {
                let v4 = v2 + v3;
                if (v4 >= v0) {
                    break
                };
                if (0x1::vector::borrow<u8>(arg0, v4) != 0x1::vector::borrow<u8>(arg1, v3)) {
                    break
                };
                v3 = v3 + 1;
            };
            if (v3 == v1) {
                return (true, v2)
            };
            v2 = v2 + 1;
        };
        (false, 0)
    }

    public fun is_lowercase(arg0: u8) : bool {
        arg0 >= 97 && arg0 <= 122
    }

    public fun is_uppercase(arg0: u8) : bool {
        arg0 >= 65 && arg0 <= 90
    }

    public fun last_index_of(arg0: &vector<u8>, arg1: &vector<u8>) : (bool, u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v0 < v1) {
            return (false, 0)
        };
        let v2 = v0 - v1;
        while (v2 >= 0) {
            let v3 = 0;
            while (v3 < v1) {
                let v4 = v2 + v3;
                if (v4 >= v0) {
                    break
                };
                if (0x1::vector::borrow<u8>(arg0, v4) != 0x1::vector::borrow<u8>(arg1, v3)) {
                    break
                };
                v3 = v3 + 1;
            };
            if (v3 == v1) {
                return (true, v2)
            };
            if (v2 == 0) {
                break
            };
            v2 = v2 - 1;
        };
        (false, 0)
    }

    public fun starts_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (0x1::vector::length<u8>(arg0) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::borrow<u8>(arg0, v1) != 0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun substring(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (arg1 >= v0) {
            return 0x1::vector::empty<u8>()
        };
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        let v2 = 0x1::vector::empty<u8>();
        while (arg1 < v1) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v2
    }

    public fun to_lowercase(arg0: &mut vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<u8>(arg0, v0);
            if (is_uppercase(*v1)) {
                *v1 = *v1 + 32;
            };
            v0 = v0 + 1;
        };
    }

    public fun to_uppercase(arg0: &mut vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<u8>(arg0, v0);
            if (is_lowercase(*v1)) {
                *v1 = *v1 - 32;
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

