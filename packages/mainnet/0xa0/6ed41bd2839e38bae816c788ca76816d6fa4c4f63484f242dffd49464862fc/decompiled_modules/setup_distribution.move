module 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg2: &0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::distribution_config::DistributionConfig, arg3: address, arg4: 0x2::coin::TreasuryCap<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::create<T0>(arg0, 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg4), arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::create<T0>(arg0, 0x2::object::id<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig>(arg1), 0x2::object::id<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::distribution_config::DistributionConfig>(arg2), v4, arg6);
        let v7 = v5;
        let (v8, v9) = 0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::reward_distributor::create<T0>(arg0, arg5, arg6);
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::set_team_wallet<T0>(&mut v3, &v2, arg3);
        0x2::transfer::public_transfer<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::AdminCap>(v2, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::VotingEscrow<T0>>(0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voting_escrow::create<T0>(arg0, 0x2::object::id<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::Voter<T0>>(&v7), arg5, arg6));
        0x2::transfer::public_share_object<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0xd80ee37bf2520ef907756ba80327c6f546bf1bdbe9d1e3c149f961591d0e5ef9::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

