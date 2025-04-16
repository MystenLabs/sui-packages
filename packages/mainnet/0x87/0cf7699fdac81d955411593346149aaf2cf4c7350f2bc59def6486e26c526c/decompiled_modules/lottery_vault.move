module 0x870cf7699fdac81d955411593346149aaf2cf4c7350f2bc59def6486e26c526c::lottery_vault {
    public(friend) fun claim_reward_entry<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg4: &address, arg5: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg2, arg1, 0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg5)));
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg0, arg1, arg2, arg3, v12, v13, arg5), arg6), *arg4);
    }

    public(friend) fun deposit<T0>(arg0: u8, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg3, arg4, arg0, arg2, arg5, arg6, arg1);
    }

    public(friend) fun get_reward_claimable_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg4: 0x2::object::ID, arg5: u64, arg6: 0x2::object::ID, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg2, arg1, 0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg3)));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v11 = &v10;
        let v12 = 0x1::vector::empty<0x1::ascii::String>();
        let v13 = 0x1::vector::empty<address>();
        let v14 = 0x1::vector::empty<u256>();
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x1::ascii::String>(&v9)) {
            let v16 = 0x1::vector::borrow<0x1::ascii::String>(&v9, v15);
            let v17 = 0x1::vector::borrow<0x1::ascii::String>(&v8, v15);
            let v18 = *0x1::vector::borrow<u256>(&v7, v15);
            let v19 = *0x1::vector::borrow<u256>(&v6, v15);
            let v20 = 0x1::vector::borrow<vector<address>>(&v5, v15);
            if (v18 > v19 && v17 == v11) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v12, *v16);
                0x1::vector::append<address>(&mut v13, *v20);
                0x1::vector::push_back<u256>(&mut v14, v18 - v19);
                0x870cf7699fdac81d955411593346149aaf2cf4c7350f2bc59def6486e26c526c::lottery_event::emit_win_ticket(arg4, arg5, v18, *v17, arg6, arg7);
            };
            v15 = v15 + 1;
        };
    }

    public fun withdraw<T0>(arg0: u8, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg8, arg3, arg4, arg0, arg2, arg5, arg6, arg1), arg9)
    }

    // decompiled from Move bytecode v6
}

