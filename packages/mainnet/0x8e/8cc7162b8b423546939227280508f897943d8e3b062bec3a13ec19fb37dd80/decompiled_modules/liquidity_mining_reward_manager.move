module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::liquidity_mining_reward_manager {
    struct PoolRewardManager has store, key {
        id: 0x2::object::UID,
        total_shares: u64,
        pool_rewards: vector<0x1::option::Option<PoolReward>>,
        last_update_time_ms: u64,
        obligation_reward_managers: 0x2::table::Table<0x2::object::ID, ObligationRewardManager>,
    }

    struct PoolReward has store, key {
        id: 0x2::object::UID,
        pool_reward_manager_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        start_time_ms: u64,
        end_time_ms: u64,
        total_rewards: u64,
        allocated_rewards: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        cumulative_rewards_per_share: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        num_obligation_reward_managers: u64,
        additional_fields: 0x2::bag::Bag,
    }

    struct ObligationRewardManager has store {
        share: u64,
        rewards: vector<0x1::option::Option<ObligationReward>>,
        last_update_time_ms: u64,
    }

    struct ObligationReward has store {
        pool_reward_id: 0x2::object::ID,
        earned_rewards: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        cumulative_rewards_per_share: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    // decompiled from Move bytecode v6
}

