module 0x10388615012961110b6e44621969c21d107c64ce4493080bd611549464bb4d8::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg5: &mut 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voter::create(arg1, 0x2::object::id<0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig>(arg4), 0x2::object::id<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::create<T0>(arg2, arg10, arg11);
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::set_distribute_cap<T0>(&mut v3, &v2, v5);
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v8);
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::set_team_wallet<T0>(&mut v3, &v2, arg6);
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::RewardDistributor<T0>>(v7);
        0x2::transfer::public_share_object<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::VotingEscrow<T0>>(0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::create<T0>(arg3, 0x2::object::id<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voter::Voter>(&v6), arg10, arg11));
        0x2::transfer::public_share_object<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voter::Voter>(v6);
        0x2::transfer::public_share_object<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

