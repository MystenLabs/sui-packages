module 0xeb26658e6eaacea1b65346b5e81a3e0cf4f5f20a999b1ae5a7cdd9657305b697::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg5: &mut 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::voter::create(arg1, 0x2::object::id<0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig>(arg4), 0x2::object::id<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_distributor::create<T0>(arg2, arg10, arg11);
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::set_distribute_cap<T0>(&mut v3, &v2, v5);
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v8);
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::set_team_wallet<T0>(&mut v3, &v2, arg6);
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_distributor::RewardDistributor<T0>>(v7);
        0x2::transfer::public_share_object<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::voting_escrow::VotingEscrow<T0>>(0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::voting_escrow::create<T0>(arg3, 0x2::object::id<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::voter::Voter>(&v6), arg10, arg11));
        0x2::transfer::public_share_object<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::voter::Voter>(v6);
        0x2::transfer::public_share_object<0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

