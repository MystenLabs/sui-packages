module 0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0x2::package::Publisher, arg3: &0x2::package::Publisher, arg4: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig, arg5: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg6: address, arg7: 0x2::coin::TreasuryCap<T0>, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg7), 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg5), arg10);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::create(arg1, 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig>(arg4), 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig>(arg5), arg10);
        let v6 = v4;
        let (v7, v8) = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::create<T0>(arg2, arg9, arg10);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::set_distribute_cap<T0>(&mut v3, &v2, v5);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v8);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::set_team_wallet<T0>(&mut v3, &v2, arg6);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::set_o_sail_price_aggregator<T0>(&mut v3, &v2, arg5, arg8);
        0x2::transfer::public_transfer<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::AdminCap>(v2, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_share_object<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::RewardDistributor<T0>>(v7);
        0x2::transfer::public_share_object<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>>(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::create<T0>(arg3, 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter>(&v6), arg9, arg10));
        0x2::transfer::public_share_object<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter>(v6);
        0x2::transfer::public_share_object<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

