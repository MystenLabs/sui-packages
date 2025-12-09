module 0x4307327d839e5a8f3e6ea6f069ef9b2112577219be25668875d97deb35ec0193::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg5: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::create(arg1, 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig>(arg4), 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::create<T0>(arg2, arg10, arg11);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::set_distribute_cap<T0>(&mut v3, &v2, arg5, v5);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::set_rebase_distributor_cap<T0>(&mut v3, &v2, arg5, v8);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::set_team_wallet<T0>(&mut v3, &v2, arg5, arg6);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>>(v7);
        let (v9, v10) = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::create<T0>(arg3, 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter>(&v6), arg10, arg11);
        0x2::transfer::public_share_object<0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>>(v9);
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::set_voting_escrow_cap(&mut v6, arg1, v10);
        0x2::transfer::public_share_object<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::voter::Voter>(v6);
        0x2::transfer::public_share_object<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

