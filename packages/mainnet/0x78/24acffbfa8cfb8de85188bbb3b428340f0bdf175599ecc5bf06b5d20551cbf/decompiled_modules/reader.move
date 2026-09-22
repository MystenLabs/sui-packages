module 0x7824acffbfa8cfb8de85188bbb3b428340f0bdf175599ecc5bf06b5d20551cbf::reader {
    struct Asset has copy, drop, store {
        asset_id: u8,
        scaled_supply: u256,
        scaled_borrow: u256,
        collateral: u256,
        debt: u256,
    }

    struct Account has copy, drop, store {
        user: address,
        collateral_asset_ids: vector<u8>,
        debt_asset_ids: vector<u8>,
        assets: vector<Asset>,
    }

    public fun account_states(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: vector<address>) : vector<Account> {
        assert!(0x1::vector::length<address>(&arg1) <= 64, 1);
        let v0 = 0x1::vector::empty<Account>();
        0x1::vector::reverse<address>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg1);
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg0, v2);
            let v5 = v4;
            let v6 = v3;
            let v7 = 0x1::vector::empty<Asset>();
            let v8 = asset_union(&v6, &v5);
            0x1::vector::reverse<u8>(&mut v8);
            let v9 = 0;
            while (v9 < 0x1::vector::length<u8>(&v8)) {
                let v10 = 0x1::vector::pop_back<u8>(&mut v8);
                let (v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, v10, v2);
                let v13 = Asset{
                    asset_id      : v10,
                    scaled_supply : v11,
                    scaled_borrow : v12,
                    collateral    : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, v10, v2),
                    debt          : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, v10, v2),
                };
                0x1::vector::push_back<Asset>(&mut v7, v13);
                v9 = v9 + 1;
            };
            0x1::vector::destroy_empty<u8>(v8);
            let v14 = Account{
                user                 : v2,
                collateral_asset_ids : v6,
                debt_asset_ids       : v5,
                assets               : v7,
            };
            0x1::vector::push_back<Account>(&mut v0, v14);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
        v0
    }

    fun asset_union(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0x1::vector::borrow<u8>(arg0, v1);
            if (!0x1::vector::contains<u8>(&v0, v2)) {
                0x1::vector::push_back<u8>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(arg1)) {
            let v4 = 0x1::vector::borrow<u8>(arg1, v3);
            if (!0x1::vector::contains<u8>(&v0, v4)) {
                0x1::vector::push_back<u8>(&mut v0, *v4);
            };
            v3 = v3 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

