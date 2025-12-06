module 0xd0d2518cd6ee4b562483149816b25c86cdca5ae6533317e13bc8bc371f532022::paths {
    struct PoolInfo has copy, drop, store {
        token_a: address,
        token_b: address,
        pool_id: address,
    }

    struct PathStats has copy, drop, store {
        start: address,
        count2: u64,
        count3: u64,
        count4: u64,
    }

    public fun calc(arg0: &vector<PoolInfo>, arg1: address) : (u64, u64, u64) {
        let v0 = 0x1::vector::length<PoolInfo>(arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<PoolInfo>(arg0, v4);
            if (connects(v5, arg1)) {
                let v6 = other_token(v5, arg1);
                let v7 = 0;
                while (v7 < v0) {
                    if (v7 != v4) {
                        if (connects_tokens(0x1::vector::borrow<PoolInfo>(arg0, v7), arg1, v6)) {
                            v1 = v1 + 1;
                        };
                    };
                    v7 = v7 + 1;
                };
                v7 = 0;
                while (v7 < v0) {
                    if (v7 != v4) {
                        let v8 = 0x1::vector::borrow<PoolInfo>(arg0, v7);
                        if (connects(v8, v6)) {
                            let v9 = 0;
                            while (v9 < v0) {
                                if (v9 != v4 && v9 != v7) {
                                    if (connects_tokens(0x1::vector::borrow<PoolInfo>(arg0, v9), arg1, other_token(v8, v6))) {
                                        v2 = v2 + 1;
                                    };
                                };
                                v9 = v9 + 1;
                            };
                        };
                    };
                    v7 = v7 + 1;
                };
                v7 = 0;
                while (v7 < v0) {
                    if (v7 != v4) {
                        let v10 = 0x1::vector::borrow<PoolInfo>(arg0, v7);
                        if (connects(v10, v6)) {
                            let v11 = other_token(v10, v6);
                            let v12 = 0;
                            while (v12 < v0) {
                                if (v12 != v4 && v12 != v7) {
                                    let v13 = 0x1::vector::borrow<PoolInfo>(arg0, v12);
                                    if (connects(v13, v11)) {
                                        let v14 = 0;
                                        while (v14 < v0) {
                                            let v15 = if (v14 != v4) {
                                                if (v14 != v7) {
                                                    v14 != v12
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            };
                                            if (v15) {
                                                if (connects_tokens(0x1::vector::borrow<PoolInfo>(arg0, v14), arg1, other_token(v13, v11))) {
                                                    v3 = v3 + 1;
                                                };
                                            };
                                            v14 = v14 + 1;
                                        };
                                    };
                                };
                                v12 = v12 + 1;
                            };
                        };
                    };
                    v7 = v7 + 1;
                };
            };
            v4 = v4 + 1;
        };
        (v1, v2, v3)
    }

    fun connects(arg0: &PoolInfo, arg1: address) : bool {
        arg0.token_a == arg1 || arg0.token_b == arg1
    }

    fun connects_tokens(arg0: &PoolInfo, arg1: address, arg2: address) : bool {
        arg0.token_a == arg1 && arg0.token_b == arg2 || arg0.token_a == arg2 && arg0.token_b == arg1
    }

    public fun count_paths(arg0: vector<PoolInfo>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = calc(&arg0, arg1);
        let v3 = PathStats{
            start  : arg1,
            count2 : v0,
            count3 : v1,
            count4 : v2,
        };
        0x2::event::emit<PathStats>(v3);
    }

    public entry fun count_paths_simple(arg0: vector<address>, arg1: vector<address>, arg2: vector<address>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
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
        count_paths(v1, arg3, arg4);
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

