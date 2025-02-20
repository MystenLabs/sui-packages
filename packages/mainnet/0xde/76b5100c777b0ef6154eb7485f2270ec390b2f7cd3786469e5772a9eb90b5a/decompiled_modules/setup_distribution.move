module 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::create<T0>(arg0, 0x1::option::none<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fullsail_token::MinterCap<T0>>(), arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::create<T0>(arg0, v4, arg3);
        let v7 = v5;
        let (v8, v9) = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::create<T0>(arg0, arg2, arg3);
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::set_team_wallet<T0>(&mut v3, &v2, arg1);
        0x2::transfer::public_transfer<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::AdminCap>(v2, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_share_object<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>>(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::create<T0>(arg0, 0x2::object::id<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>>(&v7), arg2, arg3));
        0x2::transfer::public_share_object<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

