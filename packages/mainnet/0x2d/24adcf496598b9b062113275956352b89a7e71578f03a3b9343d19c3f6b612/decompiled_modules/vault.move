module 0x2d24adcf496598b9b062113275956352b89a7e71578f03a3b9343d19c3f6b612::vault {
    struct SavingsData has store, key {
        id: 0x2::object::UID,
        reward_len: u8,
        coin_types: 0x2::table::Table<u8, vector<0x1::ascii::String>>,
        rule_ids: 0x2::table::Table<u8, vector<address>>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SavingsData{
            id         : 0x2::object::new(arg0),
            reward_len : 0,
            coin_types : 0x2::table::new<u8, vector<0x1::ascii::String>>(arg0),
            rule_ids   : 0x2::table::new<u8, vector<address>>(arg0),
        };
        0x2::transfer::public_share_object<SavingsData>(v0);
    }

    public entry fun init_rewards_type(arg0: &mut SavingsData, arg1: address, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg4, arg2, arg3, arg1));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        arg0.reward_len = 0;
        while (!0x1::vector::is_empty<u256>(&v7)) {
            let v10 = 0x1::vector::empty<0x1::ascii::String>();
            0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
            0x1::vector::pop_back<u256>(&mut v6);
            if (0x1::vector::pop_back<u256>(&mut v7) > 0) {
                arg0.reward_len = arg0.reward_len + 1;
                0x1::vector::push_back<0x1::ascii::String>(&mut v10, 0x1::vector::pop_back<0x1::ascii::String>(&mut v9));
                0x2::table::add<u8, vector<0x1::ascii::String>>(&mut arg0.coin_types, arg0.reward_len, v10);
                0x2::table::add<u8, vector<address>>(&mut arg0.rule_ids, arg0.reward_len, 0x1::vector::pop_back<vector<address>>(&mut v5));
            };
        };
    }

    // decompiled from Move bytecode v6
}

