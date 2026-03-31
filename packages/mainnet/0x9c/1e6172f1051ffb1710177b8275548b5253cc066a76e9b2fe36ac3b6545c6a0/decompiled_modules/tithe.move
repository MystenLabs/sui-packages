module 0x4e1a5118d3072824a4439f0fcc6cc705019bb969f948a46cc17318addaaf8913::tithe {
    struct TitheTracker has key {
        id: 0x2::object::UID,
        total_prepaid_scrolls: u64,
        total_sui_received: u64,
    }

    struct TitheAccount has key {
        id: 0x2::object::UID,
        owner: address,
        scrolls_remaining: u64,
        scrolls_total: u64,
        tier: u8,
        sui_paid: u64,
        created_at: u64,
    }

    struct TithePaid has copy, drop {
        payer: address,
        sui_amount: u64,
        tier: u8,
        scrolls_total: u64,
        scrolls_bonus: u64,
        total_prepaid: u64,
    }

    struct ScrollsAllocated has copy, drop {
        owner: address,
        draw_round: u64,
        scrolls_allocated: u64,
        scrolls_remaining: u64,
    }

    public fun account_owner(arg0: &TitheAccount) : address {
        arg0.owner
    }

    public entry fun allocate_scrolls(arg0: &mut TitheAccount, arg1: &mut TitheTracker, arg2: &mut 0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::LotteryState, arg3: &0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::TitheCap, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 2);
        assert!(arg5 > 0 && arg5 <= arg0.scrolls_remaining, 3);
        assert!(arg4 >= 0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::get_round(arg2), 4);
        arg0.scrolls_remaining = arg0.scrolls_remaining - arg5;
        let v0 = if (arg1.total_prepaid_scrolls >= arg5) {
            arg1.total_prepaid_scrolls - arg5
        } else {
            0
        };
        arg1.total_prepaid_scrolls = v0;
        0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::add_paid_scrolls(arg2, arg3, arg0.owner, arg5, arg6);
        let v1 = ScrollsAllocated{
            owner             : arg0.owner,
            draw_round        : arg4,
            scrolls_allocated : arg5,
            scrolls_remaining : arg0.scrolls_remaining,
        };
        0x2::event::emit<ScrollsAllocated>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TitheTracker{
            id                    : 0x2::object::new(arg0),
            total_prepaid_scrolls : 0,
            total_sui_received    : 0,
        };
        0x2::transfer::share_object<TitheTracker>(v0);
    }

    public entry fun prepay(arg0: &mut TitheTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::LotteryState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 6, 0);
        let v0 = tier_price(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v0, 1);
        let v1 = tier_scrolls(arg2);
        let v2 = 0x2::tx_context::sender(arg4);
        0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::deposit_to_prize_pool(arg3, arg1, arg4);
        arg0.total_prepaid_scrolls = arg0.total_prepaid_scrolls + v1;
        arg0.total_sui_received = arg0.total_sui_received + v0;
        let v3 = TithePaid{
            payer         : v2,
            sui_amount    : v0,
            tier          : arg2,
            scrolls_total : v1,
            scrolls_bonus : tier_bonus(arg2),
            total_prepaid : arg0.total_prepaid_scrolls,
        };
        0x2::event::emit<TithePaid>(v3);
        let v4 = TitheAccount{
            id                : 0x2::object::new(arg4),
            owner             : v2,
            scrolls_remaining : v1,
            scrolls_total     : v1,
            tier              : arg2,
            sui_paid          : v0,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::transfer::transfer<TitheAccount>(v4, v2);
    }

    public entry fun prepay_custom(arg0: &mut TitheTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::LotteryState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 5000000000, 5);
        let v1 = v0 / 1000000000;
        let v2 = v1 / 5;
        let v3 = v1 + v2;
        let v4 = 0x2::tx_context::sender(arg3);
        0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::deposit_to_prize_pool(arg2, arg1, arg3);
        arg0.total_prepaid_scrolls = arg0.total_prepaid_scrolls + v3;
        arg0.total_sui_received = arg0.total_sui_received + v0;
        let v5 = TithePaid{
            payer         : v4,
            sui_amount    : v0,
            tier          : 0,
            scrolls_total : v3,
            scrolls_bonus : v2,
            total_prepaid : arg0.total_prepaid_scrolls,
        };
        0x2::event::emit<TithePaid>(v5);
        let v6 = TitheAccount{
            id                : 0x2::object::new(arg3),
            owner             : v4,
            scrolls_remaining : v3,
            scrolls_total     : v3,
            tier              : 0,
            sui_paid          : v0,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::transfer::transfer<TitheAccount>(v6, v4);
    }

    public fun scrolls_remaining(arg0: &TitheAccount) : u64 {
        arg0.scrolls_remaining
    }

    public fun scrolls_total(arg0: &TitheAccount) : u64 {
        arg0.scrolls_total
    }

    fun tier_bonus(arg0: u8) : u64 {
        if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            3
        } else if (arg0 == 3) {
            15
        } else if (arg0 == 4) {
            75
        } else if (arg0 == 5) {
            250
        } else {
            600
        }
    }

    fun tier_price(arg0: u8) : u64 {
        if (arg0 == 1) {
            5000000000
        } else if (arg0 == 2) {
            10000000000
        } else if (arg0 == 3) {
            30000000000
        } else if (arg0 == 4) {
            100000000000
        } else if (arg0 == 5) {
            250000000000
        } else {
            500000000000
        }
    }

    fun tier_scrolls(arg0: u8) : u64 {
        if (arg0 == 1) {
            6
        } else if (arg0 == 2) {
            13
        } else if (arg0 == 3) {
            45
        } else if (arg0 == 4) {
            175
        } else if (arg0 == 5) {
            500
        } else {
            1100
        }
    }

    public fun tracker_prepaid(arg0: &TitheTracker) : u64 {
        arg0.total_prepaid_scrolls
    }

    public fun tracker_sui_received(arg0: &TitheTracker) : u64 {
        arg0.total_sui_received
    }

    // decompiled from Move bytecode v6
}

