module 0xd50a32ae860628d7f941e2b00dcb993661b2b2c87c2e4c3c0141422bc358528e::navi_checker {
    public(friend) fun check_any_asset(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address) : u8 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, arg1);
        let v2 = v0;
        if (0x1::vector::length<u8>(&v2) > 0) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<u8>(&v2)) {
                let (v4, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, *0x1::vector::borrow<u8>(&v2, v3), arg1);
                if (v4 > 0) {
                    return 1
                };
                v3 = v3 + 1;
            };
        };
        0
    }

    fun check_asset(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address) : u8 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        if (v0 > 0) {
            1
        } else {
            0
        }
    }

    public(friend) fun check_usdc(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address) : u8 {
        check_asset(arg0, 10, arg1)
    }

    // decompiled from Move bytecode v6
}

