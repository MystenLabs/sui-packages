module 0x3e9e4b7b9d858f4e54aa1bb90c34cc561e510399401cea18a466a6e4ba29bafb::navi_reward {
    struct RewardClaimed has copy, drop {
        asset_coin_type: 0x1::ascii::String,
        reward_coin_type: 0x1::ascii::String,
        user_claimable_reward: u256,
        user_claimed_reward: u256,
    }

    public entry fun get_reward_claimable_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address) {
        let (v0, v1, v2, v3, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg2, arg1, arg3));
        let v5 = v3;
        let v6 = v2;
        let v7 = v1;
        let v8 = v0;
        0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::empty<address>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::ascii::String>(&v8)) {
            let v10 = RewardClaimed{
                asset_coin_type       : *0x1::vector::borrow<0x1::ascii::String>(&v8, v9),
                reward_coin_type      : *0x1::vector::borrow<0x1::ascii::String>(&v7, v9),
                user_claimable_reward : *0x1::vector::borrow<u256>(&v6, v9),
                user_claimed_reward   : *0x1::vector::borrow<u256>(&v5, v9),
            };
            0x2::event::emit<RewardClaimed>(v10);
            v9 = v9 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

