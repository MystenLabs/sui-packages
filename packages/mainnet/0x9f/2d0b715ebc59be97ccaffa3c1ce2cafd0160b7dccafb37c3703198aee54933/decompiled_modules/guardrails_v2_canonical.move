module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2_canonical {
    public(friend) fun bytes_before(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public(friend) fun is_canonical_chain_id(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0 || v0 > 32) {
            return false
        };
        if (!is_lower_alpha(*0x1::vector::borrow<u8>(arg0, 0))) {
            return false
        };
        let v1 = 1;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = if (!is_lower_alpha(v2)) {
                if (!is_digit(v2)) {
                    if (v2 != 45) {
                        v2 != 95
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public(friend) fun is_canonical_opportunity_id(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 15) {
            return false
        };
        let v0 = if (*0x1::vector::borrow<u8>(arg0, 0) != 100) {
            true
        } else if (*0x1::vector::borrow<u8>(arg0, 1) != 97) {
            true
        } else if (*0x1::vector::borrow<u8>(arg0, 2) != 121) {
            true
        } else if (*0x1::vector::borrow<u8>(arg0, 3) != 111) {
            true
        } else {
            *0x1::vector::borrow<u8>(arg0, 4) != 112
        };
        if (v0) {
            return false
        };
        let v1 = 5;
        while (v1 < 15) {
            if (!is_lower_hex(*0x1::vector::borrow<u8>(arg0, v1))) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun is_digit(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57
    }

    fun is_lower_alpha(arg0: u8) : bool {
        arg0 >= 97 && arg0 <= 122
    }

    fun is_lower_hex(arg0: u8) : bool {
        is_digit(arg0) || arg0 >= 97 && arg0 <= 102
    }

    fun sort_bytes(arg0: &mut vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                v2 = v2 + 1;
            };
            if (v1 != v1) {
                0x1::vector::swap<vector<u8>>(arg0, v1, v1);
            };
            v1 = v1 + 1;
        };
    }

    fun sort_type_names(arg0: &mut vector<0x1::type_name::TypeName>) {
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                v2 = v2 + 1;
            };
            if (v1 != v1) {
                0x1::vector::swap<0x1::type_name::TypeName>(arg0, v1, v1);
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun sorted_asset_types(arg0: &0x2::vec_set::VecSet<0x1::type_name::TypeName>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        let v0 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(*arg0);
        let v1 = &mut v0;
        sort_type_names(v1);
        0x2::vec_set::from_keys<0x1::type_name::TypeName>(v0)
    }

    public(friend) fun sorted_byte_values(arg0: &0x2::vec_set::VecSet<vector<u8>>) : 0x2::vec_set::VecSet<vector<u8>> {
        let v0 = 0x2::vec_set::into_keys<vector<u8>>(*arg0);
        let v1 = &mut v0;
        sort_bytes(v1);
        0x2::vec_set::from_keys<vector<u8>>(v0)
    }

    // decompiled from Move bytecode v7
}

