module 0x9bd605b120279f58d76b2b3658800511d11085812cf21111c5581a2ceca37110::incentive_v3_reward_claim_util {
    public fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg2, arg1, 0x2::tx_context::sender(arg4)));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v11 = &v10;
        let v12 = 0x1::vector::empty<0x1::ascii::String>();
        let v13 = 0x1::vector::empty<address>();
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x1::ascii::String>(&v9)) {
            let v15 = 0x1::vector::borrow<0x1::ascii::String>(&v9, v14);
            let v16 = 0x1::vector::borrow<0x1::ascii::String>(&v8, v14);
            let v17 = 0x1::vector::borrow<vector<address>>(&v5, v14);
            if (*0x1::vector::borrow<u256>(&v7, v14) > *0x1::vector::borrow<u256>(&v6, v14) && v16 == v11) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v12, *v15);
                0x1::vector::append<address>(&mut v13, *v17);
            };
            v14 = v14 + 1;
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward<T0>(arg0, arg1, arg2, arg3, v12, v13, arg4)
    }

    // decompiled from Move bytecode v6
}

