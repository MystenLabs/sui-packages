module 0x2370fb098c171f346ac60e5f980393efd2c3b6ee63ed680bd593cf0102d73c2::gate {
    public fun assert_profit(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 + arg2, 2);
    }

    public fun select(arg0: vector<u64>, arg1: vector<u64>, arg2: u64) : u64 {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 1);
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0)) {
            let v3 = *0x1::vector::borrow<u64>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg1, v2);
            if (v3 > 0 && v4 >= v3 + arg2) {
                if (!v1 || v4 - v3 > 0) {
                    v0 = v3;
                    v1 = true;
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

