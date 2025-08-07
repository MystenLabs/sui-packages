module 0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg5: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::create(arg1, 0x2::object::id<0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig>(arg4), 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::rebase_distributor::create<T0>(arg2, arg10, arg11);
        let v9 = v7;
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::set_distribute_cap<T0>(&mut v3, &v2, v5);
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::rebase_distributor::RebaseDistributor<T0>>(&v9), v8);
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::set_team_wallet<T0>(&mut v3, &v2, arg6);
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::rebase_distributor::RebaseDistributor<T0>>(v9);
        0x2::transfer::public_share_object<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>>(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::create<T0>(arg3, 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter>(&v6), arg10, arg11));
        0x2::transfer::public_share_object<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter>(v6);
        0x2::transfer::public_share_object<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

