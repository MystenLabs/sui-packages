module 0xf878ed14b96c9ac261820ebadcfb6b15488563a386c34c967ff884355c2be5ba::gauge {
    struct EventStakedIDs has copy, drop {
        ids: vector<0x2::object::ID>,
    }

    struct EventPositionInfo has copy, drop {
        info: 0x1::option::Option<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::PositionInfo>,
        earned: u64,
        pool_id: 0x2::object::ID,
        name: 0x1::option::Option<0x1::string::String>,
    }

    struct EventPositionInfos has copy, drop {
        infos: vector<EventPositionInfo>,
    }

    struct EventMagmaDistributionGrowthInside has copy, drop, store {
        growth_inside: u128,
    }

    public entry fun deposit_position<T0, T1, T2>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::config::GlobalConfig, arg1: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::distribution_config::DistributionConfig, arg2: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>, arg3: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg4: 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::deposit_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun position_info<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T2>, arg1: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>, arg2: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::borrow_position_info<T0, T1>(arg2, arg3);
        let v1 = if (0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::has_staked_positions<T0, T1, T2>(arg1, arg3)) {
            EventPositionInfo{info: 0x1::option::some<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::PositionInfo>(*v0), earned: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, arg3, arg4), pool_id: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::pool_id<T0, T1, T2>(arg1), name: 0x1::option::some<0x1::string::String>(0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::name(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::position_info<T0, T1, T2>(arg1, arg3)))}
        } else {
            EventPositionInfo{info: 0x1::option::none<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::PositionInfo>(), earned: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, arg3, arg4), pool_id: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::pool_id<T0, T1, T2>(arg1), name: 0x1::option::none<0x1::string::String>()}
        };
        0x2::event::emit<EventPositionInfo>(v1);
    }

    public entry fun withdraw_position<T0, T1, T2>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::withdraw_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun get_pool_magma_distribution_growth_inside<T0, T1>(arg0: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u128) {
        let v0 = EventMagmaDistributionGrowthInside{growth_inside: 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::get_magma_distribution_growth_inside<T0, T1>(arg0, 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::from_u32(arg1), 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::from_u32(arg2), arg3)};
        0x2::event::emit<EventMagmaDistributionGrowthInside>(v0);
    }

    public entry fun get_reward_by_position<T0, T1, T2>(arg0: &mut 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>, arg1: &mut 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::get_position_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun staked_ids<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>, arg1: address) {
        let v0 = EventStakedIDs{ids: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::stakes<T0, T1, T2>(arg0, arg1)};
        0x2::event::emit<EventStakedIDs>(v0);
    }

    public entry fun user_staked_position_infos<T0, T1, T2>(arg0: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::voter::Voter<T2>, arg1: &0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::Gauge<T0, T1, T2>, arg2: &0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        let v0 = 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::stakes<T0, T1, T2>(arg1, arg3);
        let v1 = 0;
        let v2 = EventPositionInfos{infos: 0x1::vector::empty<EventPositionInfo>()};
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = 0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::pool::borrow_position_info<T0, T1>(arg2, *0x1::vector::borrow<0x2::object::ID>(&v0, v1));
            let v4 = if (0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::has_staked_positions<T0, T1, T2>(arg1, *0x1::vector::borrow<0x2::object::ID>(&v0, v1))) {
                EventPositionInfo{info: 0x1::option::some<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::PositionInfo>(*v3), earned: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&v0, v1), arg4), pool_id: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::pool_id<T0, T1, T2>(arg1), name: 0x1::option::some<0x1::string::String>(0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::name(0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::position_info<T0, T1, T2>(arg1, *0x1::vector::borrow<0x2::object::ID>(&v0, v1))))}
            } else {
                EventPositionInfo{info: 0x1::option::none<0xbb1e485664a4d5099154f9c8f10a54d49e2e7dc02c8e358253f0cd5c14eaa1bd::position::PositionInfo>(), earned: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::earned_by_position<T0, T1, T2>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&v0, v1), arg4), pool_id: 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::gauge::pool_id<T0, T1, T2>(arg1), name: 0x1::option::none<0x1::string::String>()}
            };
            0x1::vector::push_back<EventPositionInfo>(&mut v2.infos, v4);
            v1 = v1 + 1;
        };
        0x2::event::emit<EventPositionInfos>(v2);
    }

    // decompiled from Move bytecode v6
}

