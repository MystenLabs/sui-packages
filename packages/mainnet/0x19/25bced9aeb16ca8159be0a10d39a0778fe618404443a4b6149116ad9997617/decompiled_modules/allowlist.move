module 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::allowlist {
    public fun allows_addr(arg0: &vector<address>, arg1: address) : bool {
        0x1::vector::is_empty<address>(arg0) || 0x1::vector::contains<address>(arg0, &arg1)
    }

    public fun allows_bytes(arg0: &vector<vector<u8>>, arg1: &vector<u8>) : bool {
        0x1::vector::is_empty<vector<u8>>(arg0) || 0x1::vector::contains<vector<u8>>(arg0, arg1)
    }

    public fun insert_addr(arg0: &mut vector<address>, arg1: address) : bool {
        if (0x1::vector::contains<address>(arg0, &arg1)) {
            return false
        };
        0x1::vector::push_back<address>(arg0, arg1);
        true
    }

    public fun insert_bytes(arg0: &mut vector<vector<u8>>, arg1: vector<u8>) : bool {
        if (0x1::vector::contains<vector<u8>>(arg0, &arg1)) {
            return false
        };
        0x1::vector::push_back<vector<u8>>(arg0, arg1);
        true
    }

    public fun remove_addr(arg0: &mut vector<address>, arg1: address) : bool {
        let (v0, v1) = 0x1::vector::index_of<address>(arg0, &arg1);
        if (v0) {
            0x1::vector::swap_remove<address>(arg0, v1);
            true
        } else {
            false
        }
    }

    public fun remove_bytes(arg0: &mut vector<vector<u8>>, arg1: &vector<u8>) : bool {
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(arg0, arg1);
        if (v0) {
            0x1::vector::swap_remove<vector<u8>>(arg0, v1);
            true
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

