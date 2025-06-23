module 0x5b9428ad212672a6ef8404569ae79de723610993579996e0fc2ae7e1665fd1f5::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::config::GlobalConfig, arg2: &0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::distribution_config::DistributionConfig, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::create<T0>(arg0, 0x1::option::none<0x5df88eb4e78f647daf4a5326ea529fe6d94612062effed4a6804d7511d268261::magma::MinterCap<T0>>(), arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voter::create<T0>(arg0, 0x2::object::id<0x11d6b074eedf8e2d6d0a21f119e2edd8c9e6738acf06740d7c5107e9e5551adb::config::GlobalConfig>(arg1), 0x2::object::id<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::distribution_config::DistributionConfig>(arg2), v4, arg5);
        let v7 = v5;
        let (v8, v9) = 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::create<T0>(arg0, arg4, arg5);
        0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::set_team_wallet<T0>(&mut v3, &v2, arg3);
        0x2::transfer::public_transfer<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::AdminCap>(v2, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::VotingEscrow<T0>>(0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::create<T0>(arg0, 0x2::object::id<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voter::Voter<T0>>(&v7), arg4, arg5));
        0x2::transfer::public_share_object<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

