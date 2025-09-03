module 0xb21fd30f9115df4551e68eb56406ce390e53ef5044b115c02982ecec944d5f64::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg5: &mut 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), arg8, 0x2::object::id<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::distribution_config::DistributionConfig>(arg5), arg11);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::voter::create(arg1, 0x2::object::id<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig>(arg4), 0x2::object::id<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::distribution_config::DistributionConfig>(arg5), arg11);
        let v6 = v4;
        let (v7, v8) = 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::create<T0>(arg2, arg10, arg11);
        0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::set_distribute_cap<T0>(&mut v3, &v2, arg5, v5);
        0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::set_rebase_distributor_cap<T0>(&mut v3, &v2, arg5, v8);
        0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::set_team_wallet<T0>(&mut v3, &v2, arg5, arg6);
        0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::set_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg9);
        0x2::transfer::public_transfer<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::AdminCap>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_share_object<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::RebaseDistributor<T0>>(v7);
        let (v9, v10) = 0x2469959951798462ecba5efc3b93276560472be279494561331d384baeedab4c::voting_escrow::create<T0>(arg3, 0x2::object::id<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::voter::Voter>(&v6), arg10, arg11);
        0x2::transfer::public_share_object<0x2469959951798462ecba5efc3b93276560472be279494561331d384baeedab4c::voting_escrow::VotingEscrow<T0>>(v9);
        0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::voter::set_voting_escrow_cap(&mut v6, arg1, v10);
        0x2::transfer::public_share_object<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::voter::Voter>(v6);
        0x2::transfer::public_share_object<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

