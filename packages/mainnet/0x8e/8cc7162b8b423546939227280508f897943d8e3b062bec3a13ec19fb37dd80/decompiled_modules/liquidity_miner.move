module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::liquidity_miner {
    struct LiquidityMiner<phantom T0> has store, key {
        id: 0x2::object::UID,
        deposit: 0x2::table::Table<0x1::type_name::TypeName, 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::liquidity_mining_reward_manager::PoolRewardManager>,
        borrow: 0x2::table::Table<0x1::type_name::TypeName, 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::liquidity_mining_reward_manager::PoolRewardManager>,
    }

    // decompiled from Move bytecode v6
}

