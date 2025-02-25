module 0xfb99585b3118aa0fdc5382745995654e3b62909e97b481c6604be2855f023b89::test_navi {
    struct Check has key {
        id: 0x2::object::UID,
        deposit_asset: vector<0x1::ascii::String>,
        reward_asset: vector<0x1::ascii::String>,
        total_rewards: vector<u256>,
        claimed_rewards: vector<u256>,
        rules: vector<vector<address>>,
    }

    public entry fun new(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg1, arg2, arg3));
        let v5 = Check{
            id              : 0x2::object::new(arg4),
            deposit_asset   : v0,
            reward_asset    : v1,
            total_rewards   : v2,
            claimed_rewards : v3,
            rules           : v4,
        };
        0x2::transfer::transfer<Check>(v5, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

