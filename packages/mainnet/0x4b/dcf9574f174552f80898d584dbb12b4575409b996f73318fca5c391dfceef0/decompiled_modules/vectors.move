module 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::vectors {
    public fun check_valid_outcomes(arg0: vector<0x1::string::String>, arg1: u64) : bool {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        if (v0 == 0) {
            return false
        };
        let v1 = 0x2::vec_set::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(&arg0, v2);
            let v4 = 0x1::string::length(v3);
            if (v4 == 0 || v4 > arg1) {
                return false
            };
            if (0x2::vec_set::contains<0x1::string::String>(&v1, v3)) {
                return false
            };
            0x2::vec_set::insert<0x1::string::String>(&mut v1, *v3);
            v2 = v2 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

