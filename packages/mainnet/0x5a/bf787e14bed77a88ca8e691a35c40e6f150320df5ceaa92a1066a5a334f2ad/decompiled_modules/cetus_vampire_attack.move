module 0x5abf787e14bed77a88ca8e691a35c40e6f150320df5ceaa92a1066a5a334f2ad::cetus_vampire_attack {
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

