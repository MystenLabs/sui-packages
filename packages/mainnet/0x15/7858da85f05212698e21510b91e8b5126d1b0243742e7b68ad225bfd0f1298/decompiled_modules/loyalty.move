module 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::loyalty {
    struct LOYALTY has drop {
        dummy_field: bool,
    }

    struct BonusEvent has copy, drop, store {
        from_epoch: u64,
        until_epoch: u64,
        multiplier_bps: u64,
    }

    struct LoyaltyConfig has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<LOYALTY>,
        policy_cap: 0x2::token::TokenPolicyCap<LOYALTY>,
        points_per_gb_storage: u64,
        points_per_epoch_extension: u64,
        min_redemption_gb: u64,
        active_bonus: 0x1::option::Option<BonusEvent>,
        paused: bool,
        admin_minted_epoch: u64,
        admin_minted_this_epoch: u64,
    }

    struct PointsEarned has copy, drop {
        user: address,
        amount: u64,
        reason: vector<u8>,
        base_points_per_gb: u64,
        plan_multiplier: u64,
        bonus_multiplier_bps: u64,
        bytes: u64,
        epoch: u64,
    }

    struct PointsRedeemed has copy, drop {
        user: address,
        amount_burned: u64,
        redemption_kind: vector<u8>,
        units_granted: u64,
        epoch: u64,
    }

    struct BonusEventSet has copy, drop {
        from_epoch: u64,
        until_epoch: u64,
        multiplier_bps: u64,
        set_by: address,
        epoch: u64,
    }

    struct BonusEventCleared has copy, drop {
        cleared_by: address,
        epoch: u64,
    }

    struct RatesUpdated has copy, drop {
        points_per_gb_storage: u64,
        points_per_epoch_extension: u64,
        min_redemption_gb: u64,
        updated_by: address,
        epoch: u64,
    }

    struct LoyaltyPaused has copy, drop {
        paused_by: address,
        epoch: u64,
    }

    struct LoyaltyUnpaused has copy, drop {
        unpaused_by: address,
        epoch: u64,
    }

    public fun admin_award_points(arg0: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::AdminCap, arg1: &mut LoyaltyConfig, arg2: &mut 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::UserAccount, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 500);
        assert!(arg3 > 0, 506);
        let v0 = 0x2::tx_context::epoch(arg5);
        if (arg1.admin_minted_epoch != v0) {
            arg1.admin_minted_epoch = v0;
            arg1.admin_minted_this_epoch = 0;
        };
        let v1 = arg1.admin_minted_this_epoch + arg3;
        assert!(v1 <= 10000000, 509);
        arg1.admin_minted_this_epoch = v1;
        let v2 = 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::account_owner(arg2);
        mint_and_transfer(arg1, v2, arg3, arg5);
        0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::add_lifetime_points(arg2, arg3);
        let v3 = PointsEarned{
            user                 : v2,
            amount               : arg3,
            reason               : arg4,
            base_points_per_gb   : 0,
            plan_multiplier      : 0,
            bonus_multiplier_bps : 0,
            bytes                : 0,
            epoch                : v0,
        };
        0x2::event::emit<PointsEarned>(v3);
    }

    public fun admin_mint_headroom(arg0: &LoyaltyConfig, arg1: u64) : u64 {
        if (arg0.admin_minted_epoch != arg1) {
            return 10000000
        };
        if (arg0.admin_minted_this_epoch >= 10000000) {
            0
        } else {
            10000000 - arg0.admin_minted_this_epoch
        }
    }

    public(friend) fun award_upload_points(arg0: &mut LoyaltyConfig, arg1: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::GlobalConfig, arg2: &mut 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::UserAccount, arg3: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::Subscription, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.paused) {
            return
        };
        if (arg4 == 0) {
            return
        };
        if (arg5 == 0) {
            return
        };
        if (!0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::is_active(arg3, 0x2::tx_context::epoch(arg6))) {
            return
        };
        let v0 = 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::points_per_gb(arg1);
        let v1 = current_bonus_multiplier_bps(arg0, 0x2::tx_context::epoch(arg6));
        let v2 = (arg5 as u128) * (v0 as u128) * (arg4 as u128) * (v1 as u128) / (1073741824 as u128) * (10000 as u128);
        if (v2 == 0) {
            return
        };
        let v3 = (v2 as u64);
        let v4 = 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::account_owner(arg2);
        mint_and_transfer(arg0, v4, v3, arg6);
        0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::add_lifetime_points(arg2, v3);
        let v5 = PointsEarned{
            user                 : v4,
            amount               : v3,
            reason               : b"upload",
            base_points_per_gb   : v0,
            plan_multiplier      : arg4,
            bonus_multiplier_bps : v1,
            bytes                : arg5,
            epoch                : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<PointsEarned>(v5);
    }

    public fun base_multiplier_bps() : u64 {
        10000
    }

    public fun bonus_multiplier_now(arg0: &LoyaltyConfig, arg1: u64) : u64 {
        current_bonus_multiplier_bps(arg0, arg1)
    }

    public fun clear_bonus_event(arg0: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::AdminCap, arg1: &mut LoyaltyConfig, arg2: &0x2::tx_context::TxContext) {
        arg1.active_bonus = 0x1::option::none<BonusEvent>();
        let v0 = BonusEventCleared{
            cleared_by : 0x2::tx_context::sender(arg2),
            epoch      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<BonusEventCleared>(v0);
    }

    fun current_bonus_multiplier_bps(arg0: &LoyaltyConfig, arg1: u64) : u64 {
        if (0x1::option::is_none<BonusEvent>(&arg0.active_bonus)) {
            return 10000
        };
        let v0 = 0x1::option::borrow<BonusEvent>(&arg0.active_bonus);
        if (arg1 >= v0.from_epoch && arg1 < v0.until_epoch) {
            v0.multiplier_bps
        } else {
            10000
        }
    }

    public fun has_active_bonus(arg0: &LoyaltyConfig) : bool {
        0x1::option::is_some<BonusEvent>(&arg0.active_bonus)
    }

    fun init(arg0: LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LOYALTY>(arg0, 0, 0x1::string::utf8(b"WPT"), 0x1::string::utf8(b"Waldrop Points"), 0x1::string::utf8(b"Loyalty points earned by using Waldrop. Non-transferable; redeemable for storage or subscription extension."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        0x2::coin_registry::finalize_and_delete_metadata_cap<LOYALTY>(v0, arg1);
        let (v3, v4) = 0x2::token::new_policy<LOYALTY>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<LOYALTY>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::share_policy<LOYALTY>(v6);
        let v7 = LoyaltyConfig{
            id                         : 0x2::object::new(arg1),
            treasury_cap               : v2,
            policy_cap                 : v5,
            points_per_gb_storage      : 25000,
            points_per_epoch_extension : 50000,
            min_redemption_gb          : 1,
            active_bonus               : 0x1::option::none<BonusEvent>(),
            paused                     : false,
            admin_minted_epoch         : 0,
            admin_minted_this_epoch    : 0,
        };
        0x2::transfer::share_object<LoyaltyConfig>(v7);
    }

    public fun is_paused(arg0: &LoyaltyConfig) : bool {
        arg0.paused
    }

    public fun max_admin_mint_per_epoch() : u64 {
        10000000
    }

    public fun min_redemption_gb(arg0: &LoyaltyConfig) : u64 {
        arg0.min_redemption_gb
    }

    fun mint_and_transfer(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<LOYALTY>(&mut arg0.treasury_cap, 0x2::token::transfer<LOYALTY>(0x2::token::mint<LOYALTY>(&mut arg0.treasury_cap, arg2, arg3), arg1, arg3), arg3);
    }

    public fun pause_loyalty(arg0: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::AdminCap, arg1: &mut LoyaltyConfig, arg2: &0x2::tx_context::TxContext) {
        arg1.paused = true;
        let v0 = LoyaltyPaused{
            paused_by : 0x2::tx_context::sender(arg2),
            epoch     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<LoyaltyPaused>(v0);
    }

    public fun points_per_epoch_extension(arg0: &LoyaltyConfig) : u64 {
        arg0.points_per_epoch_extension
    }

    public fun points_per_gb_storage(arg0: &LoyaltyConfig) : u64 {
        arg0.points_per_gb_storage
    }

    public fun redeem_for_extension(arg0: &mut LoyaltyConfig, arg1: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::UserAccount, arg2: &mut 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::Subscription, arg3: 0x2::token::Token<LOYALTY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<LOYALTY> {
        assert!(!arg0.paused, 500);
        assert!(arg4 > 0, 507);
        assert!(0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::account_owner(arg1) == 0x2::tx_context::sender(arg5), 508);
        assert!(0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::sub_owner(arg2) == 0x2::tx_context::sender(arg5), 508);
        let v0 = arg4 * arg0.points_per_epoch_extension;
        assert!(0x2::token::value<LOYALTY>(&arg3) >= v0, 501);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<LOYALTY>(&mut arg0.treasury_cap, 0x2::token::spend<LOYALTY>(0x2::token::split<LOYALTY>(&mut arg3, v0, arg5), arg5), arg5);
        0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::extend_expiry(arg2, arg4, arg5);
        let v5 = PointsRedeemed{
            user            : 0x2::tx_context::sender(arg5),
            amount_burned   : v0,
            redemption_kind : b"extension",
            units_granted   : arg4,
            epoch           : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<PointsRedeemed>(v5);
        arg3
    }

    public fun redeem_for_storage(arg0: &mut LoyaltyConfig, arg1: &mut 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::UserAccount, arg2: 0x2::token::Token<LOYALTY>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<LOYALTY> {
        assert!(!arg0.paused, 500);
        assert!(arg3 >= arg0.min_redemption_gb, 502);
        assert!(0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::account_owner(arg1) == 0x2::tx_context::sender(arg4), 508);
        let v0 = arg3 * arg0.points_per_gb_storage;
        assert!(0x2::token::value<LOYALTY>(&arg2) >= v0, 501);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<LOYALTY>(&mut arg0.treasury_cap, 0x2::token::spend<LOYALTY>(0x2::token::split<LOYALTY>(&mut arg2, v0, arg4), arg4), arg4);
        0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::subscription::add_bonus_storage(arg1, arg3 * 1073741824);
        let v5 = PointsRedeemed{
            user            : 0x2::tx_context::sender(arg4),
            amount_burned   : v0,
            redemption_kind : b"storage",
            units_granted   : arg3,
            epoch           : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<PointsRedeemed>(v5);
        arg2
    }

    public fun set_bonus_event(arg0: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::AdminCap, arg1: &mut LoyaltyConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2 < arg3, 505);
        assert!(arg4 >= 10000, 504);
        assert!(arg4 <= 20000, 511);
        let v0 = BonusEvent{
            from_epoch     : arg2,
            until_epoch    : arg3,
            multiplier_bps : arg4,
        };
        arg1.active_bonus = 0x1::option::some<BonusEvent>(v0);
        let v1 = BonusEventSet{
            from_epoch     : arg2,
            until_epoch    : arg3,
            multiplier_bps : arg4,
            set_by         : 0x2::tx_context::sender(arg5),
            epoch          : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<BonusEventSet>(v1);
    }

    public fun unpause_loyalty(arg0: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::AdminCap, arg1: &mut LoyaltyConfig, arg2: &0x2::tx_context::TxContext) {
        arg1.paused = false;
        let v0 = LoyaltyUnpaused{
            unpaused_by : 0x2::tx_context::sender(arg2),
            epoch       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<LoyaltyUnpaused>(v0);
    }

    public fun update_redemption_rates(arg0: &0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::AdminCap, arg1: &mut LoyaltyConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 503);
        assert!(arg2 > 0x157858da85f05212698e21510b91e8b5126d1b0243742e7b68ad225bfd0f1298::admin::max_base_points_per_gb() * 10 * 20000 / 10000, 510);
        arg1.points_per_gb_storage = arg2;
        arg1.points_per_epoch_extension = arg3;
        arg1.min_redemption_gb = arg4;
        let v1 = RatesUpdated{
            points_per_gb_storage      : arg2,
            points_per_epoch_extension : arg3,
            min_redemption_gb          : arg4,
            updated_by                 : 0x2::tx_context::sender(arg5),
            epoch                      : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<RatesUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

