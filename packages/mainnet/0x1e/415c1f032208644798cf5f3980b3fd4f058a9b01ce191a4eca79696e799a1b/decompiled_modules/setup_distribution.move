module 0x1e415c1f032208644798cf5f3980b3fd4f058a9b01ce191a4eca79696e799a1b::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig, arg5: &mut 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voter::create(arg1, 0x2::object::id<0x13ee70242d830af3a16756a875f7333fa023382d48be503b2ad9b7358ed2b7ee::config::GlobalConfig>(arg4), 0x2::object::id<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::create<T0>(arg2, arg10, arg11);
        let v9 = v7;
        0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::set_distribute_cap<T0>(&mut v3, &v2, v5);
        0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, 0x2::object::id<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::RebaseDistributor<T0>>(&v9), v8);
        0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::set_team_wallet<T0>(&mut v3, &v2, arg6);
        0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::RebaseDistributor<T0>>(v9);
        0x2::transfer::public_share_object<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voting_escrow::VotingEscrow<T0>>(0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voting_escrow::create<T0>(arg3, 0x2::object::id<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voter::Voter>(&v6), arg10, arg11));
        0x2::transfer::public_share_object<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voter::Voter>(v6);
        0x2::transfer::public_share_object<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

