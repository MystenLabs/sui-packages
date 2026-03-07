module 0x5ff3d5e2a3aea285bf7a0a1e0c7bb647cf3c46c5aff778ce13f2c53ff5e5263::void_access {
    struct AccessConfig has store, key {
        id: 0x2::object::UID,
        pumpkin_threshold: u64,
        void_threshold: u64,
        admin: address,
    }

    struct AccessGranted has copy, drop {
        wallet: address,
        tier: u8,
        timestamp: u64,
    }

    public fun check_access_tier(arg0: &AccessConfig, arg1: u64, arg2: u64) : u8 {
        if (arg1 >= arg0.pumpkin_threshold && arg2 >= arg0.void_threshold) {
            2
        } else if (arg1 >= arg0.pumpkin_threshold) {
            1
        } else {
            0
        }
    }

    public fun check_and_emit_access(arg0: &AccessConfig, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = check_access_tier(arg0, arg1, arg2);
        if (v0 > 0) {
            let v1 = AccessGranted{
                wallet    : 0x2::tx_context::sender(arg4),
                tier      : v0,
                timestamp : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<AccessGranted>(v1);
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessConfig{
            id                : 0x2::object::new(arg0),
            pumpkin_threshold : 1000000000,
            void_threshold    : 1000000000,
            admin             : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<AccessConfig>(v0);
    }

    public fun pumpkin_threshold(arg0: &AccessConfig) : u64 {
        arg0.pumpkin_threshold
    }

    public fun tier_basic() : u8 {
        1
    }

    public fun tier_none() : u8 {
        0
    }

    public fun tier_premium() : u8 {
        2
    }

    public fun update_thresholds(arg0: &mut AccessConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.pumpkin_threshold = arg1;
        arg0.void_threshold = arg2;
    }

    public fun void_threshold(arg0: &AccessConfig) : u64 {
        arg0.void_threshold
    }

    // decompiled from Move bytecode v6
}

