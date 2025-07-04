module 0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg5: &mut 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voter::create(arg1, 0x2::object::id<0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig>(arg4), 0x2::object::id<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::create<T0>(arg2, arg10, arg11);
        0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::set_distribute_cap<T0>(&mut v3, &v2, v5);
        0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v8);
        0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::set_team_wallet<T0>(&mut v3, &v2, arg6);
        0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::RewardDistributor<T0>>(v7);
        0x2::transfer::public_share_object<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voting_escrow::VotingEscrow<T0>>(0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voting_escrow::create<T0>(arg3, 0x2::object::id<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voter::Voter>(&v6), arg10, arg11));
        0x2::transfer::public_share_object<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voter::Voter>(v6);
        0x2::transfer::public_share_object<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

