module 0xe9c807d16de49321832873a8e07c8ead2ff795bd1704f8f936978aeb63be3be7::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig, arg2: &0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::create<T0>(arg0, 0x1::option::none<0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::MinterCap<T0>>(), arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::create<T0>(arg0, 0x2::object::id<0xb739751c5704a3e0262c63f058b1a9e9ea894988ff57e3caec1e73e097388035::config::GlobalConfig>(arg1), 0x2::object::id<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::distribution_config::DistributionConfig>(arg2), v4, arg5);
        let v7 = v5;
        let (v8, v9) = 0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_distributor::create<T0>(arg0, arg4, arg5);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::set_team_wallet<T0>(&mut v3, &v2, arg3);
        0x2::transfer::public_transfer<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::AdminCap>(v2, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::VotingEscrow<T0>>(0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voting_escrow::create<T0>(arg0, 0x2::object::id<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>>(&v7), arg4, arg5));
        0x2::transfer::public_share_object<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0xb007f13d64561c02d65d697d7b6f4edfb959652d330d3461789d810067f878fa::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

