module 0x7e06bb8aff8fa0e4a52406424441cffb99f5b054ec13b2f8a6747f84385cd1f3::cetus_vampire_attack {
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

    // decompiled from Move bytecode v6
}

