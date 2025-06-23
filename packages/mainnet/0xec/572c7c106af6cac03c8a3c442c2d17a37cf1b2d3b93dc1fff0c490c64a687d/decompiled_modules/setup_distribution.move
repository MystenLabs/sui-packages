module 0xec572c7c106af6cac03c8a3c442c2d17a37cf1b2d3b93dc1fff0c490c64a687d::setup_distribution {
    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::package::Publisher, arg2: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg3: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::create<T0>(arg0, 0x1::option::none<0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::MinterCap<T0>>(), arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::get<T0>());
        let (v5, v6) = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::create<T0>(arg0, arg1, 0x2::object::id<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig>(arg2), 0x2::object::id<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig>(arg3), v4, arg6);
        let v7 = v5;
        let (v8, v9) = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward_distributor::create<T0>(arg0, arg5, arg6);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::set_notify_reward_cap<T0>(&mut v3, &v2, v6);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::set_reward_distributor_cap<T0>(&mut v3, &v2, v9);
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::set_team_wallet<T0>(&mut v3, &v2, arg4);
        0x2::transfer::public_transfer<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::AdminCap>(v2, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::reward_distributor::RewardDistributor<T0>>(v8);
        0x2::transfer::public_share_object<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::VotingEscrow<T0>>(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voting_escrow::create<T0>(arg0, 0x2::object::id<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>>(&v7), arg5, arg6));
        0x2::transfer::public_share_object<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T0>>(v7);
        0x2::transfer::public_share_object<0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::minter::Minter<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

