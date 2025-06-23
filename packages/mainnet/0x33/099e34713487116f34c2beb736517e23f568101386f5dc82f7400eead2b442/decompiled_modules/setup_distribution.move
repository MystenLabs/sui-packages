module 0x33099e34713487116f34c2beb736517e23f568101386f5dc82f7400eead2b442::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::config::GlobalConfig, arg2: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::distribution_config::DistributionConfig, arg3: address, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg4), arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::create<T0>(arg0, 0x2::object::id<0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::config::GlobalConfig>(arg1), 0x2::object::id<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::distribution_config::DistributionConfig>(arg2), v4, arg6);
        let v7 = v5;
        let (v8, v9) = 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::reward_distributor::create<T0>(arg0, arg5, arg6);
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::set_team_wallet<T0>(&mut v3, &v2, arg3);
        0x2::transfer::public_transfer<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::AdminCap>(v2, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>>(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::create<T0>(arg0, 0x2::object::id<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>>(&v7), arg5, arg6));
        0x2::transfer::public_share_object<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

