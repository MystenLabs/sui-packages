module 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::skelsui_staking {
    struct SKELSUI_STAKING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LockTier has copy, drop, store {
        tier_id: u8,
        label: 0x1::string::String,
        duration_ms: u64,
        multiplier_bps: u64,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_weighted_stake: u64,
        base_bones_rate_per_day: u64,
        reward_denominator: u64,
        stake_decimals: u8,
        paused: bool,
        season_id: u64,
        next_crypt_nonce: u64,
        stake_vault: 0x2::balance::Balance<T0>,
        lock_tiers: vector<LockTier>,
    }

    struct StakePosition<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        staked_amount: u64,
        weighted_amount: u64,
        unclaimed_bones: u64,
        lock_tier_id: u8,
        lock_multiplier_bps: u64,
        lock_start_ms: u64,
        lock_end_ms: u64,
        last_accrual_ms: u64,
        accrual_numerator_remainder: u128,
    }

    struct RewardInventory has store, key {
        id: 0x2::object::UID,
        reward_key: 0x1::string::String,
        label: 0x1::string::String,
        cost_bones: u64,
        max_supply: u64,
        redeemed_supply: u64,
        active: bool,
        redemption_mode: u8,
        external_package_id: 0x1::option::Option<0x2::object::ID>,
        external_collection_key: 0x1::string::String,
    }

    struct CRYPT has key {
        id: 0x2::object::UID,
        owner: address,
        reward_key: 0x1::string::String,
        external_collection_key: 0x1::string::String,
        issued_at_ms: u64,
        expiry_ms: u64,
        nonce: u64,
        season_id: u64,
    }

    struct RedemptionRecord has key {
        id: 0x2::object::UID,
        owner: address,
        reward_key: 0x1::string::String,
        bones_spent: u64,
        created_at_ms: u64,
        fulfilled: bool,
        fulfillment_ref: 0x1::option::Option<0x1::string::String>,
    }

    fun accrual_denominator<T0>(arg0: &StakingPool<T0>) : u128 {
        (86400000 as u128) * reward_denominator_atomic<T0>(arg0)
    }

    fun accrue_position<T0>(arg0: &StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: u64) : u64 {
        if (arg2 <= arg1.last_accrual_ms) {
            return 0
        };
        let (v0, v1) = pending_bones<T0>(arg0, arg1, arg2 - arg1.last_accrual_ms);
        arg1.unclaimed_bones = arg1.unclaimed_bones + v0;
        arg1.accrual_numerator_remainder = v1;
        arg1.last_accrual_ms = arg2;
        v0
    }

    fun assert_active_pool<T0>(arg0: &StakingPool<T0>) {
        assert!(!arg0.paused, 0);
    }

    fun assert_position_owner<T0>(arg0: &StakePosition<T0>, arg1: address) {
        assert!(arg0.owner == arg1, 8);
    }

    public fun base_bones_rate_per_day<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.base_bones_rate_per_day
    }

    fun borrow_lock_tier(arg0: &vector<LockTier>, arg1: u8) : LockTier {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LockTier>(arg0)) {
            let v1 = 0x1::vector::borrow<LockTier>(arg0, v0);
            if (v1.tier_id == arg1) {
                return *v1
            };
            v0 = v0 + 1;
        };
        abort 1
    }

    public fun claim_bones<T0>(arg0: &StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_position_owner<T0>(arg1, 0x2::tx_context::sender(arg4));
        0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::mint_to_recipient(arg2, claimable_bones_internal<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg3)), 0x2::tx_context::sender(arg4), arg4);
    }

    fun claimable_bones_internal<T0>(arg0: &StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: u64) : u64 {
        accrue_position<T0>(arg0, arg1, arg2);
        arg1.unclaimed_bones = 0;
        arg1.unclaimed_bones
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakingPool<T0>>(new_pool<T0>(arg1, arg2, arg3, arg4));
    }

    public fun create_reward_inventory(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u8, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RewardInventory>(new_reward_inventory(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun crypt_external_collection_key(arg0: &CRYPT) : 0x1::string::String {
        arg0.external_collection_key
    }

    public fun crypt_nonce(arg0: &CRYPT) : u64 {
        arg0.nonce
    }

    public fun crypt_reward_key(arg0: &CRYPT) : 0x1::string::String {
        arg0.reward_key
    }

    fun default_lock_tiers() : vector<LockTier> {
        let v0 = 0x1::vector::empty<LockTier>();
        let v1 = LockTier{
            tier_id        : 0,
            label          : 0x1::string::utf8(b"Flexible"),
            duration_ms    : 0,
            multiplier_bps : 10000,
        };
        0x1::vector::push_back<LockTier>(&mut v0, v1);
        let v2 = LockTier{
            tier_id        : 1,
            label          : 0x1::string::utf8(b"30 days"),
            duration_ms    : 30 * 86400000,
            multiplier_bps : 20000,
        };
        0x1::vector::push_back<LockTier>(&mut v0, v2);
        let v3 = LockTier{
            tier_id        : 2,
            label          : 0x1::string::utf8(b"90 days"),
            duration_ms    : 90 * 86400000,
            multiplier_bps : 26000,
        };
        0x1::vector::push_back<LockTier>(&mut v0, v3);
        let v4 = LockTier{
            tier_id        : 3,
            label          : 0x1::string::utf8(b"180 days"),
            duration_ms    : 180 * 86400000,
            multiplier_bps : 36000,
        };
        0x1::vector::push_back<LockTier>(&mut v0, v4);
        v0
    }

    fun init(arg0: SKELSUI_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun is_valid_redemption_mode(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    public fun lock_end_ms<T0>(arg0: &StakePosition<T0>) : u64 {
        arg0.lock_end_ms
    }

    public fun lock_tier_count<T0>(arg0: &StakingPool<T0>) : u64 {
        0x1::vector::length<LockTier>(&arg0.lock_tiers)
    }

    public fun mark_redemption_fulfilled(arg0: &AdminCap, arg1: &mut RedemptionRecord, arg2: 0x1::string::String) {
        arg1.fulfilled = true;
        arg1.fulfillment_ref = 0x1::option::some<0x1::string::String>(arg2);
    }

    fun new_pool<T0>(arg0: u64, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : StakingPool<T0> {
        assert!(arg1 > 0, 2);
        assert!(arg2 <= 18, 9);
        StakingPool<T0>{
            id                      : 0x2::object::new(arg3),
            total_staked            : 0,
            total_weighted_stake    : 0,
            base_bones_rate_per_day : arg0,
            reward_denominator      : arg1,
            stake_decimals          : arg2,
            paused                  : false,
            season_id               : 1,
            next_crypt_nonce        : 0,
            stake_vault             : 0x2::balance::zero<T0>(),
            lock_tiers              : default_lock_tiers(),
        }
    }

    fun new_reward_inventory(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u8, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : RewardInventory {
        assert!(arg2 > 0, 2);
        assert!(is_valid_redemption_mode(arg4), 10);
        RewardInventory{
            id                      : 0x2::object::new(arg7),
            reward_key              : arg0,
            label                   : arg1,
            cost_bones              : arg2,
            max_supply              : arg3,
            redeemed_supply         : 0,
            active                  : true,
            redemption_mode         : arg4,
            external_package_id     : arg5,
            external_collection_key : arg6,
        }
    }

    public fun paused<T0>(arg0: &StakingPool<T0>) : bool {
        arg0.paused
    }

    fun pending_bones<T0>(arg0: &StakingPool<T0>, arg1: &StakePosition<T0>, arg2: u64) : (u64, u128) {
        let v0 = if (arg1.weighted_amount == 0) {
            true
        } else if (arg0.base_bones_rate_per_day == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, arg1.accrual_numerator_remainder)
        };
        let v1 = arg1.accrual_numerator_remainder + (arg1.weighted_amount as u128) * (arg2 as u128) * (arg0.base_bones_rate_per_day as u128);
        let v2 = accrual_denominator<T0>(arg0);
        (((v1 / v2) as u64), v1 % v2)
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < (arg0 as u64)) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun redeem_bones_for_crypt<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg3: &mut RewardInventory, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_bones_for_crypt_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<CRYPT>(v0, 0x2::tx_context::sender(arg6));
    }

    fun redeem_bones_for_crypt_internal<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg3: &mut RewardInventory, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : CRYPT {
        assert!(arg3.redemption_mode == 1, 10);
        assert!(!0x1::string::is_empty(&arg3.external_collection_key), 11);
        let v0 = spend_bones_for_reward(arg1, arg2, arg3, arg5, arg6);
        let v1 = if (arg4 >= v0) {
            arg4
        } else {
            v0
        };
        let v2 = arg0.next_crypt_nonce;
        arg0.next_crypt_nonce = v2 + 1;
        CRYPT{
            id                      : 0x2::object::new(arg6),
            owner                   : 0x2::tx_context::sender(arg6),
            reward_key              : arg3.reward_key,
            external_collection_key : arg3.external_collection_key,
            issued_at_ms            : v0,
            expiry_ms               : v1,
            nonce                   : v2,
            season_id               : arg0.season_id,
        }
    }

    public fun redeem_bones_manual<T0>(arg0: &StakingPool<T0>, arg1: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg2: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg3: &mut RewardInventory, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_bones_manual_internal(arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<RedemptionRecord>(v0, 0x2::tx_context::sender(arg5));
    }

    fun redeem_bones_manual_internal(arg0: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg1: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg2: &mut RewardInventory, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : RedemptionRecord {
        assert!(arg2.redemption_mode == 2, 10);
        let v0 = spend_bones_for_reward(arg0, arg1, arg2, arg3, arg4);
        RedemptionRecord{
            id              : 0x2::object::new(arg4),
            owner           : 0x2::tx_context::sender(arg4),
            reward_key      : arg2.reward_key,
            bones_spent     : arg2.cost_bones,
            created_at_ms   : v0,
            fulfilled       : false,
            fulfillment_ref : 0x1::option::none<0x1::string::String>(),
        }
    }

    public fun redeemed_supply(arg0: &RewardInventory) : u64 {
        arg0.redeemed_supply
    }

    public fun redemption_fulfilled(arg0: &RedemptionRecord) : bool {
        arg0.fulfilled
    }

    public fun reward_cost_bones(arg0: &RewardInventory) : u64 {
        arg0.cost_bones
    }

    public fun reward_denominator<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.reward_denominator
    }

    fun reward_denominator_atomic<T0>(arg0: &StakingPool<T0>) : u128 {
        (arg0.reward_denominator as u128) * (pow10(arg0.stake_decimals) as u128)
    }

    fun scaled_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun season_id<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.season_id
    }

    public fun set_bones_rate<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64, arg3: u64) {
        assert!(arg1.total_staked == 0, 12);
        assert!(arg3 > 0, 2);
        arg1.base_bones_rate_per_day = arg2;
        arg1.reward_denominator = arg3;
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_reward_active(arg0: &AdminCap, arg1: &mut RewardInventory, arg2: bool) {
        arg1.active = arg2;
    }

    public fun set_season_id<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.season_id = arg2;
    }

    fun spend_bones_for_reward(arg0: &mut 0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BonesTreasury, arg1: 0x2::token::Token<0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::BONES>, arg2: &mut RewardInventory, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2.active, 6);
        assert!(arg2.max_supply == 0 || arg2.redeemed_supply < arg2.max_supply, 7);
        0x1c35d45f8ba03a6f8de2fb2cab17e897811ac1259956b09405d1ccf50fc7349d::bones::spend_exact(arg0, arg1, arg2.cost_bones, arg4);
        arg2.redeemed_supply = arg2.redeemed_supply + 1;
        0x2::clock::timestamp_ms(arg3)
    }

    public fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = stake_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<StakePosition<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun stake_decimals<T0>(arg0: &StakingPool<T0>) : u8 {
        arg0.stake_decimals
    }

    fun stake_internal<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakePosition<T0> {
        assert_active_pool<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = borrow_lock_tier(&arg0.lock_tiers, arg2);
        let v2 = scaled_amount(v0, v1.multiplier_bps);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = if (v1.duration_ms == 0) {
            0
        } else {
            v3 + v1.duration_ms
        };
        0x2::balance::join<T0>(&mut arg0.stake_vault, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_staked = arg0.total_staked + v0;
        arg0.total_weighted_stake = arg0.total_weighted_stake + v2;
        StakePosition<T0>{
            id                          : 0x2::object::new(arg4),
            owner                       : 0x2::tx_context::sender(arg4),
            staked_amount               : v0,
            weighted_amount             : v2,
            unclaimed_bones             : 0,
            lock_tier_id                : arg2,
            lock_multiplier_bps         : v1.multiplier_bps,
            lock_start_ms               : v3,
            lock_end_ms                 : v4,
            last_accrual_ms             : v3,
            accrual_numerator_remainder : 0,
        }
    }

    public fun staked_amount<T0>(arg0: &StakePosition<T0>) : u64 {
        arg0.staked_amount
    }

    public fun total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_staked
    }

    public fun total_weighted_stake<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_weighted_stake
    }

    public fun unclaimed_bones<T0>(arg0: &StakePosition<T0>) : u64 {
        arg0.unclaimed_bones
    }

    public fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = unstake_internal<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun unstake_internal<T0>(arg0: &mut StakingPool<T0>, arg1: &mut StakePosition<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_position_owner<T0>(arg1, 0x2::tx_context::sender(arg4));
        assert!(arg2 > 0 && arg2 <= arg1.staked_amount, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.lock_end_ms > 0) {
            assert!(v0 >= arg1.lock_end_ms, 3);
        };
        accrue_position<T0>(arg0, arg1, v0);
        let v1 = scaled_amount(arg2, arg1.lock_multiplier_bps);
        arg1.staked_amount = arg1.staked_amount - arg2;
        arg1.weighted_amount = arg1.weighted_amount - v1;
        arg0.total_staked = arg0.total_staked - arg2;
        arg0.total_weighted_stake = arg0.total_weighted_stake - v1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.stake_vault, arg2), arg4)
    }

    public fun update_reward_inventory(arg0: &AdminCap, arg1: &mut RewardInventory, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: bool, arg6: u8, arg7: 0x1::option::Option<0x2::object::ID>, arg8: 0x1::string::String) {
        assert!(arg3 > 0, 2);
        assert!(is_valid_redemption_mode(arg6), 10);
        arg1.label = arg2;
        arg1.cost_bones = arg3;
        arg1.max_supply = arg4;
        arg1.active = arg5;
        arg1.redemption_mode = arg6;
        arg1.external_package_id = arg7;
        arg1.external_collection_key = arg8;
    }

    public fun upsert_lock_tier<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u8, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        assert!(arg1.total_staked == 0, 12);
        assert!(arg5 > 0, 2);
        upsert_lock_tier_internal<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    fun upsert_lock_tier_internal<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LockTier>(&arg0.lock_tiers)) {
            let v1 = 0x1::vector::borrow_mut<LockTier>(&mut arg0.lock_tiers, v0);
            if (v1.tier_id == arg1) {
                v1.label = arg2;
                v1.duration_ms = arg3;
                v1.multiplier_bps = arg4;
                return
            };
            v0 = v0 + 1;
        };
        let v2 = LockTier{
            tier_id        : arg1,
            label          : arg2,
            duration_ms    : arg3,
            multiplier_bps : arg4,
        };
        0x1::vector::push_back<LockTier>(&mut arg0.lock_tiers, v2);
    }

    public fun weighted_amount<T0>(arg0: &StakePosition<T0>) : u64 {
        arg0.weighted_amount
    }

    // decompiled from Move bytecode v7
}

