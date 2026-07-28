module 0x2433ab0d4a1a5ee53c65f34975320f11485141852f915a5559feaec1ed4a5eee::gate {
    public fun can_liquidate_batch(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: vector<address>, arg5: u256) : (vector<u256>, vector<bool>, vector<bool>, vector<vector<u8>>, vector<vector<u8>>) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor_batch(arg0, arg1, arg2, arg4);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&arg4)) {
            let v6 = *0x1::vector::borrow<address>(&arg4, v5);
            let v7 = *0x1::vector::borrow<u256>(&v0, v5);
            let (v8, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, v6);
            0x1::vector::push_back<bool>(&mut v1, v7 <= arg5);
            let v10 = v7 <= 1000000000000000000000000000 && 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::is_liquidatable(arg2, arg3, v6);
            0x1::vector::push_back<bool>(&mut v2, v10);
            0x1::vector::push_back<vector<u8>>(&mut v3, v8);
            0x1::vector::push_back<vector<u8>>(&mut v4, v9);
            v5 = v5 + 1;
        };
        (v0, v1, v2, v3, v4)
    }

    // decompiled from Move bytecode v7
}

