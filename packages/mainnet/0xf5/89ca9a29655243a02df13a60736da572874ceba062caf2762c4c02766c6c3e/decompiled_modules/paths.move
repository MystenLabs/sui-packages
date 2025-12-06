module 0xf589ca9a29655243a02df13a60736da572874ceba062caf2762c4c02766c6c3e::paths {
    struct PoolInfo has copy, drop, store {
        token_a: address,
        token_b: address,
        pool_id: address,
    }

    struct PathStats3 has copy, drop, store {
        start: address,
        count2: u64,
        count3: u64,
    }

    public fun calc3(arg0: &vector<PoolInfo>, arg1: address) : (u64, u64) {
        let v0 = 0x1::vector::length<PoolInfo>(arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<PoolInfo>(arg0, v3);
            if (connects(v4, arg1)) {
                let v5 = other_token(v4, arg1);
                let v6 = 0;
                while (v6 < v0) {
                    if (v6 != v3) {
                        if (connects_tokens(0x1::vector::borrow<PoolInfo>(arg0, v6), arg1, v5)) {
                            v1 = v1 + 1;
                        };
                    };
                    v6 = v6 + 1;
                };
                let v7 = 0;
                while (v7 < v0) {
                    if (v7 != v3) {
                        let v8 = 0x1::vector::borrow<PoolInfo>(arg0, v7);
                        if (connects(v8, v5)) {
                            let v9 = 0;
                            while (v9 < v0) {
                                if (v9 != v3 && v9 != v7) {
                                    if (connects_tokens(0x1::vector::borrow<PoolInfo>(arg0, v9), arg1, other_token(v8, v5))) {
                                        v2 = v2 + 1;
                                    };
                                };
                                v9 = v9 + 1;
                            };
                        };
                    };
                    v7 = v7 + 1;
                };
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    fun connects(arg0: &PoolInfo, arg1: address) : bool {
        arg0.token_a == arg1 || arg0.token_b == arg1
    }

    fun connects_tokens(arg0: &PoolInfo, arg1: address, arg2: address) : bool {
        arg0.token_a == arg1 && arg0.token_b == arg2 || arg0.token_a == arg2 && arg0.token_b == arg1
    }

    public entry fun count_paths_simple3(arg0: vector<address>, arg1: vector<address>, arg2: vector<address>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 == 0x1::vector::length<address>(&arg1), 1);
        assert!(v0 == 0x1::vector::length<address>(&arg2), 2);
        let v1 = 0x1::vector::empty<PoolInfo>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = PoolInfo{
                token_a : *0x1::vector::borrow<address>(&arg0, v2),
                token_b : *0x1::vector::borrow<address>(&arg1, v2),
                pool_id : *0x1::vector::borrow<address>(&arg2, v2),
            };
            0x1::vector::push_back<PoolInfo>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let (v4, v5) = calc3(&v1, arg3);
        let v6 = PathStats3{
            start  : arg3,
            count2 : v4,
            count3 : v5,
        };
        0x2::event::emit<PathStats3>(v6);
    }

    fun other_token(arg0: &PoolInfo, arg1: address) : address {
        if (arg0.token_a == arg1) {
            arg0.token_b
        } else {
            arg0.token_a
        }
    }

    // decompiled from Move bytecode v6
}

