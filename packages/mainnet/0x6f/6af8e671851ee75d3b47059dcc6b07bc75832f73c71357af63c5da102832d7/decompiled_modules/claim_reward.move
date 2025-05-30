module 0x6f6af8e671851ee75d3b47059dcc6b07bc75832f73c71357af63c5da102832d7::claim_reward {
    public entry fun claim_reward_entry<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg4: address, arg5: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = &v0;
        let (v2, v3, v4, v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg2, arg1, 0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg5)));
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = v2;
        let v12 = 0x1::vector::empty<0x1::ascii::String>();
        let v13 = 0x1::vector::empty<address>();
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x1::ascii::String>(&v11)) {
            let v15 = 0x1::vector::borrow<0x1::ascii::String>(&v11, v14);
            let v16 = 0x1::vector::borrow<0x1::ascii::String>(&v10, v14);
            let v17 = 0x1::vector::borrow<vector<address>>(&v7, v14);
            if (*0x1::vector::borrow<u256>(&v9, v14) > *0x1::vector::borrow<u256>(&v8, v14) && v16 == v1) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v12, *v15);
                0x1::vector::append<address>(&mut v13, *v17);
            };
            v14 = v14 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg0, arg1, arg2, arg3, v12, v13, arg5), arg6), arg4);
    }

    // decompiled from Move bytecode v6
}

