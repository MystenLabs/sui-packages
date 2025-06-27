module 0x4d355503cc1413f93f1e6c860b68454c4f8ab1486f16bd992d929224cf515de4::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x932ffb185b8b9ffd194f21329e812b7fa29c2846c8612f337cb140e088af9dc4::config::GlobalConfig, arg2: &0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::distribution_config::DistributionConfig, arg3: address, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg4), arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::voter::create<T0>(arg0, 0x2::object::id<0x932ffb185b8b9ffd194f21329e812b7fa29c2846c8612f337cb140e088af9dc4::config::GlobalConfig>(arg1), 0x2::object::id<0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::distribution_config::DistributionConfig>(arg2), v4, arg6);
        let v7 = v5;
        let (v8, v9) = 0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::reward_distributor::create<T0>(arg0, arg5, arg6);
        0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::minter::set_team_wallet<T0>(&mut v3, &v2, arg3);
        0x2::transfer::public_transfer<0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::minter::AdminCap>(v2, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::voting_escrow::VotingEscrow<T0>>(0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::voting_escrow::create<T0>(arg0, 0x2::object::id<0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::voter::Voter<T0>>(&v7), arg5, arg6));
        0x2::transfer::public_share_object<0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0x4a9cc22eaf4e68115624de71d009f7375f156ab3d7cee17006ac44ae661e5b3c::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

