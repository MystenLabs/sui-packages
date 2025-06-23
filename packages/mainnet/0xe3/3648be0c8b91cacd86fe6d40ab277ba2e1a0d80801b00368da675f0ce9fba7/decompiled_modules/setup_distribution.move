module 0xe33648be0c8b91cacd86fe6d40ab277ba2e1a0d80801b00368da675f0ce9fba7::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig, arg2: &0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::distribution_config::DistributionConfig, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::create<T0>(arg0, 0x1::option::none<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::sail_token::MinterCap<T0>>(), arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::create<T0>(arg0, 0x2::object::id<0x1d23eaf3854cb685e28b469691c60dad6b20d574038da97349e154514b8351a::config::GlobalConfig>(arg1), 0x2::object::id<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::distribution_config::DistributionConfig>(arg2), v4, arg5);
        let v7 = v5;
        let (v8, v9) = 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::reward_distributor::create<T0>(arg0, arg4, arg5);
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::set_team_wallet<T0>(&mut v3, &v2, arg3);
        0x2::transfer::public_transfer<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::AdminCap>(v2, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::VotingEscrow<T0>>(0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voting_escrow::create<T0>(arg0, 0x2::object::id<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::Voter<T0>>(&v7), arg4, arg5));
        0x2::transfer::public_share_object<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

