module 0x5d02ae6f9234fb99c6ec2013546afb258268b62a4c35d9804ab44f536051e311::cetus_vampire_attack {
    struct CetusAttackConfig has store, key {
        id: 0x2::object::UID,
        init_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        min_lock_duration: u64,
        max_lock_duration: u64,
        weekly_multiplier: u64,
        weekly_divider: u64,
        max_positions_per_user: u8,
    }

    struct CetusPositionBreakdown has store {
        position_liquidity: u128,
        weighted_units: u128,
        x_withdrawn: u64,
        y_withdrawn: u64,
        fee_earned_x: u64,
        fee_earned_y: u64,
        cetus_earned: u64,
        sui_earned: u64,
    }

    struct UserCetusHivePosition has store, key {
        id: 0x2::object::UID,
        lockup_weeks: vector<u64>,
        lockup_receipts: 0x2::table::Table<u64, Receipt>,
        total_liquidity_locked: u128,
        total_weighted_units: u128,
    }

    struct Receipt has drop, store {
        weeks_locked_for: u64,
        unlock_timestamp: u64,
        position_liquidity: u128,
        weighted_units: u128,
    }

    struct PoolForVampireAttackOnCetusKrafted<phantom T0, phantom T1> has copy, drop, store {
        pool_addr: address,
        hive_incentives: u64,
    }

    struct HiveIncentivesAddedForPool<phantom T0, phantom T1> has copy, drop, store {
        pool_addr: address,
        hive_incentives_added: u64,
        total_incentives: u64,
    }

    struct CetusPositionLocked<phantom T0, phantom T1> has copy, drop {
        user_profile: address,
        username: 0x1::string::String,
        user_addr: address,
        lockup_weeks: u64,
        liquidity_locked: u128,
        unlock_timestamp: u64,
        increase_in_weighted_units: u128,
        total_liquidity_locked: u128,
        total_user_weighted_units: u128,
        expected_hive_rewards_increase: u64,
        total_user_exp_hive_rewards: u64,
    }

    struct CetusPositionDestroyed<phantom T0, phantom T1> has copy, drop, store {
        user_addr: address,
        lockup_weeks: u64,
        x_withdrawn: u64,
        y_withdrawn: u64,
        fee_earned_x: u64,
        fee_earned_y: u64,
        sui_earned: u64,
        cetus_earned: u64,
        position_liquidity: u128,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

