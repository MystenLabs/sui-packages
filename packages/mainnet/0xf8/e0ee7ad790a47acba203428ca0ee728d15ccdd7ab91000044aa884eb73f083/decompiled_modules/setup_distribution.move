module 0xf8e0ee7ad790a47acba203428ca0ee728d15ccdd7ab91000044aa884eb73f083::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg2: &0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::distribution_config::DistributionConfig, arg3: address, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg4), arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::voter::create<T0>(arg0, 0x2::object::id<0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig>(arg1), 0x2::object::id<0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::distribution_config::DistributionConfig>(arg2), v4, arg6);
        let v7 = v5;
        let (v8, v9) = 0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::reward_distributor::create<T0>(arg0, arg5, arg6);
        0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::minter::set_team_wallet<T0>(&mut v3, &v2, arg3);
        0x2::transfer::public_transfer<0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::minter::AdminCap>(v2, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::voting_escrow::VotingEscrow<T0>>(0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::voting_escrow::create<T0>(arg0, 0x2::object::id<0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::voter::Voter<T0>>(&v7), arg5, arg6));
        0x2::transfer::public_share_object<0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

