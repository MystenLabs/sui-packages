module 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::rewarder {
    struct RewarderManager has store {
        rewarders: vector<Rewarder>,
        points_released: u128,
        points_growth_global: u128,
        last_updated_time: u64,
    }

    struct Rewarder has copy, drop, store {
        reward_coin: 0x1::type_name::TypeName,
        emissions_per_second: u128,
        growth_global: u128,
    }

    // decompiled from Move bytecode v6
}

