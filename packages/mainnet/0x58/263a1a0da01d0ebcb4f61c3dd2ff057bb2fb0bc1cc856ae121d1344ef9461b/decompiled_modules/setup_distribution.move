module 0x58263a1a0da01d0ebcb4f61c3dd2ff057bb2fb0bc1cc856ae121d1344ef9461b::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg5: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::create(arg1, 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig>(arg4), 0x2::object::id<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::create<T0>(arg2, arg10, arg11);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::set_distribute_cap<T0>(&mut v3, &v2, arg5, v5);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::set_rebase_distributor_cap<T0>(&mut v3, &v2, arg5, v8);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::set_team_wallet<T0>(&mut v3, &v2, arg5, arg6);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::RebaseDistributor<T0>>(v7);
        let (v9, v10) = 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::create<T0>(arg3, 0x2::object::id<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter>(&v6), arg10, arg11);
        0x2::transfer::public_share_object<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>>(v9);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::set_voting_escrow_cap(&mut v6, arg1, v10);
        0x2::transfer::public_share_object<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter>(v6);
        0x2::transfer::public_share_object<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

