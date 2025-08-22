module 0x62717e7025e96bd834f5bee177d35b9a9fd71a4986ee028c2ce5c1226d2d279e::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg5: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::create(arg1, 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig>(arg4), 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::create<T0>(arg2, arg10, arg11);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::set_distribute_cap<T0>(&mut v3, &v2, v5);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::set_rebase_distributor_cap<T0>(&mut v3, &v2, v8);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::set_team_wallet<T0>(&mut v3, &v2, arg6);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::RebaseDistributor<T0>>(v7);
        let (v9, v10) = 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::create<T0>(arg3, 0x2::object::id<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter>(&v6), arg10, arg11);
        0x2::transfer::public_share_object<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>>(v9);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::set_voting_escrow_cap(&mut v6, arg1, v10);
        0x2::transfer::public_share_object<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter>(v6);
        0x2::transfer::public_share_object<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

