module 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::gate {
    public fun can_liquidate_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: vector<address>, arg5: u256) : (vector<u256>, vector<bool>, vector<bool>, vector<vector<u8>>, vector<vector<u8>>, vector<u256>, vector<u256>) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor_batch(arg0, arg1, arg2, arg4);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&arg4)) {
            let v8 = *0x1::vector::borrow<address>(&arg4, v7);
            let v9 = *0x1::vector::borrow<u256>(&v0, v7);
            let (v10, v11) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, v8);
            let v12 = v9 <= 1000000000000000000000000000 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, v8);
            let v13 = if (v12) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_loan_value(arg0, arg1, arg2, v8)
            } else {
                0
            };
            let v14 = if (v12) {
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_collateral_value(arg0, arg1, arg2, v8)
            } else {
                0
            };
            0x1::vector::push_back<bool>(&mut v1, v9 <= arg5);
            0x1::vector::push_back<bool>(&mut v2, v12);
            0x1::vector::push_back<vector<u8>>(&mut v3, v10);
            0x1::vector::push_back<vector<u8>>(&mut v4, v11);
            0x1::vector::push_back<u256>(&mut v5, v13);
            0x1::vector::push_back<u256>(&mut v6, v14);
            v7 = v7 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6)
    }

    // decompiled from Move bytecode v7
}

