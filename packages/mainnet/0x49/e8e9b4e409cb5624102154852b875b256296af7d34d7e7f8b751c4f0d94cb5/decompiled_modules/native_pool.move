module 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::native_pool {
    struct MinDepositUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct StakingPercentUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct PlatformFeePercentUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct UnbondingPeriodUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct VoteCooldownUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct SnapshotCooldownUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct TreasuryAddressUpdatedEvent has copy, drop {
        prev_address: address,
        new_address: address,
    }

    struct ProtocolStatusUpdatedEvent has copy, drop {
        is_active: bool,
    }

    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
    }

    struct ValidatorAddedEvent has copy, drop {
        validator: address,
    }

    struct SnapshotUpdatedEvent has copy, drop {
        snapshot_timestamp_ms: u64,
    }

    struct RewardsUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
    }

    struct CompoundEvent has copy, drop {
        timestamp_ms: u64,
        compound_amount: u64,
        fee_amount: u64,
    }

    struct ReserveStakedEvent has copy, drop {
        stake_pool_id: 0x2::object::ID,
        validator_pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct LiquidityAddedEvent has copy, drop {
        amount_a: u64,
        amount_b: u64,
    }

    struct DepositEvent has copy, drop {
        user_address: address,
        sui_amount: u64,
        jwlsui_amount: u64,
    }

    struct RedeemEvent has copy, drop {
        user_address: address,
        redeem_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        user_address: address,
        amount: u64,
    }

    struct ProtocolRewardsClaimedEvent has copy, drop {
        claim_amount: u64,
    }

    struct StakeEvent has copy, drop {
        user_address: address,
        jwl_sui_amount: u64,
        sjwl_sui_amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        user_address: address,
        sjwl_sui_amount: u64,
        jwl_sui_amount: u64,
    }

    struct VoteEvent has copy, drop {
        user_address: address,
        target_validator: address,
        vote_percentage: u64,
        vote_weight: u64,
    }

    struct NativePool has key {
        id: 0x2::object::UID,
        version: u64,
        is_active: bool,
        min_deposit_amount: u64,
        staking_percent: u64,
        platform_fee_percent: u64,
        unbonding_period_ms: u64,
        vote_cooldown_ms: u64,
        snapshot_cooldown_ms: u64,
        total_staked_amount: u64,
        total_sui_to_stake: u64,
        total_sui_to_add_liquidity: u64,
        sui_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        jwlsui_vault: 0x2::balance::Balance<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>,
        jwlsui_reserved: u64,
        sjwlsui_reserved: u64,
        validator_set: 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::ValidatorSet,
        user_info: 0x2::table::Table<address, UserInfo>,
        user_to_validator: 0x2::table::Table<address, UserToValidators>,
        total_rewards: u64,
        total_protocol_rewards: u64,
        protocol_rewards: u64,
        rewards_threshold: u64,
        rewards_update_ms: u64,
        treasury_address: address,
        last_epoch_checked_rewards: u64,
        total_sui_to_claim: u64,
        total_sui_earned: u64,
    }

    struct UserInfo has copy, drop, store {
        sjwlsui_amount: u64,
        voted_sjwlsui_amount: u64,
        reserved_redeem_amount: u64,
        last_redeem_reserved_at: u64,
    }

    struct UserToValidators has copy, drop, store {
        validators: 0x2::vec_map::VecMap<address, UserToValidator>,
    }

    struct UserToValidator has copy, drop, store {
        voting_point: u64,
        last_voted_at: u64,
    }

    public entry fun add_liquidity(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OperatorCap, arg1: &mut NativePool, arg2: &mut 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JwlSuiMetadata<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg1.total_sui_to_add_liquidity >= arg7, 112);
        let v0 = if (arg8) {
            arg6
        } else {
            arg7
        };
        0x2::coin::put<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&mut arg1.jwlsui_vault, 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::mint(arg2, arg6, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::split<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&mut arg1.jwlsui_vault, arg6), 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_vault, arg7), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI, 0x2::sui::SUI>(arg3, arg4, arg5, v0, arg8, arg9));
        arg1.total_sui_to_add_liquidity = arg1.total_sui_to_add_liquidity - arg7;
        let v1 = LiquidityAddedEvent{
            amount_a : arg6,
            amount_b : arg7,
        };
        0x2::event::emit<LiquidityAddedEvent>(v1);
    }

    public entry fun add_validator(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: address) {
        assert_active(arg1);
        assert_version(arg1);
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::add_validator(&mut arg1.validator_set, arg2);
        let v0 = ValidatorAddedEvent{validator: arg2};
        0x2::event::emit<ValidatorAddedEvent>(v0);
    }

    public entry fun add_whitelist(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::flash_mint::create(arg2, arg3);
    }

    fun assert_active(arg0: &NativePool) {
        assert!(arg0.is_active, 100);
    }

    fun assert_version(arg0: &NativePool) {
        assert!(arg0.version == 1, 1);
    }

    fun check_user_info(arg0: &mut 0x2::table::Table<address, UserInfo>, arg1: address) {
        if (!0x2::table::contains<address, UserInfo>(arg0, arg1)) {
            let v0 = UserInfo{
                sjwlsui_amount          : 0,
                voted_sjwlsui_amount    : 0,
                reserved_redeem_amount  : 0,
                last_redeem_reserved_at : 0,
            };
            0x2::table::add<address, UserInfo>(arg0, arg1, v0);
        };
    }

    fun check_user_to_validator(arg0: &mut 0x2::table::Table<address, UserToValidators>, arg1: address, arg2: &mut 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::ValidatorSet) {
        if (!0x2::table::contains<address, UserToValidators>(arg0, arg1)) {
            let v0 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_validators(arg2);
            let v1 = 0x1::vector::length<address>(&v0);
            assert!(v1 > 0, 114);
            let v2 = 0x2::vec_map::empty<address, UserToValidator>();
            let v3 = 0;
            while (v3 < v1) {
                let v4 = UserToValidator{
                    voting_point  : 0,
                    last_voted_at : 0,
                };
                0x2::vec_map::insert<address, UserToValidator>(&mut v2, *0x1::vector::borrow<address>(&v0, v3), v4);
                v3 = v3 + 1;
            };
            let v5 = UserToValidators{validators: v2};
            0x2::table::add<address, UserToValidators>(arg0, arg1, v5);
        } else {
            let v6 = 0x2::table::borrow<address, UserToValidators>(arg0, arg1).validators;
            let v7 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_validators(arg2);
            let v8 = 0x1::vector::length<address>(&v7);
            assert!(v8 > 0, 114);
            let v9 = 0;
            while (v9 < v8) {
                let v10 = *0x1::vector::borrow<address>(&v7, v9);
                if (!0x2::vec_map::contains<address, UserToValidator>(&v6, &v10)) {
                    let v11 = UserToValidator{
                        voting_point  : 0,
                        last_voted_at : 0,
                    };
                    0x2::vec_map::insert<address, UserToValidator>(&mut v6, v10, v11);
                };
                v9 = v9 + 1;
            };
            let v12 = UserToValidators{validators: v6};
            *0x2::table::borrow_mut<address, UserToValidators>(arg0, arg1) = v12;
        };
    }

    public entry fun claim_protocol_rewards(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg1.protocol_rewards >= arg2, 111);
        assert!(arg1.total_sui_to_stake >= arg2, 111);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_vault) >= arg2, 113);
        arg1.protocol_rewards = arg1.protocol_rewards - arg2;
        arg1.total_sui_to_stake = arg1.total_sui_to_stake - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_vault, arg2, arg3), arg1.treasury_address);
        let v0 = ProtocolRewardsClaimedEvent{claim_amount: arg2};
        0x2::event::emit<ProtocolRewardsClaimedEvent>(v0);
    }

    public entry fun compound(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OperatorCap, arg1: &mut NativePool, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JwlSuiMetadata<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg3 > arg1.total_rewards, 116);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg1.rewards_update_ms > 43200000, 117);
        arg1.rewards_update_ms = v0;
        assert!(arg3 <= arg1.total_rewards + 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(arg1.total_staked_amount + arg1.total_sui_to_stake, arg1.rewards_threshold, 10000), 118);
        let v1 = arg3 - arg1.total_rewards;
        let v2 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(v1, arg1.platform_fee_percent, 10000);
        arg1.total_protocol_rewards = arg1.total_protocol_rewards + v2;
        arg1.protocol_rewards = arg1.protocol_rewards + v2;
        let v3 = v1 - v2;
        0x2::coin::put<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&mut arg1.jwlsui_vault, 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::mint(arg4, v3, arg5));
        arg1.jwlsui_reserved = arg1.jwlsui_reserved + v3;
        set_rewards_unsafe(arg1, arg3);
        let v4 = CompoundEvent{
            timestamp_ms    : v0,
            compound_amount : v3,
            fee_amount      : v2,
        };
        0x2::event::emit<CompoundEvent>(v4);
    }

    public entry fun deposit(arg0: &mut NativePool, arg1: &mut 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JwlSuiMetadata<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = do_deposit(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun do_deposit(arg0: &mut NativePool, arg1: &mut 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JwlSuiMetadata<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg0.min_deposit_amount, 103);
        let v1 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(v0, arg0.staking_percent, 10000);
        arg0.total_sui_to_stake = arg0.total_sui_to_stake + v1;
        arg0.total_sui_to_add_liquidity = arg0.total_sui_to_add_liquidity + v0 - v1;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_vault, arg2);
        let v2 = DepositEvent{
            user_address  : 0x2::tx_context::sender(arg3),
            sui_amount    : v0,
            jwlsui_amount : v0,
        };
        0x2::event::emit<DepositEvent>(v2);
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::mint(arg1, v0, arg3)
    }

    public fun get_user_info(arg0: &NativePool, arg1: address) : UserInfo {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg1)) {
            UserInfo{sjwlsui_amount: 0, voted_sjwlsui_amount: 0, reserved_redeem_amount: 0, last_redeem_reserved_at: 0}
        } else {
            *0x2::table::borrow<address, UserInfo>(&arg0.user_info, arg1)
        }
    }

    public fun get_user_to_validator(arg0: &NativePool, arg1: address, arg2: address) : UserToValidator {
        let v0 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_validators(&arg0.validator_set);
        assert!(0x1::vector::length<address>(&v0) > 0, 110);
        if (!0x2::table::contains<address, UserToValidators>(&arg0.user_to_validator, arg1)) {
            UserToValidator{voting_point: 0, last_voted_at: 0}
        } else {
            let v2 = 0x2::table::borrow<address, UserToValidators>(&arg0.user_to_validator, arg1).validators;
            if (!0x2::vec_map::contains<address, UserToValidator>(&v2, &arg2)) {
                UserToValidator{voting_point: 0, last_voted_at: 0}
            } else {
                *0x2::vec_map::get<address, UserToValidator>(&v2, &arg2)
            }
        }
    }

    public entry fun initialize_native_pool(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = NativePool{
            id                         : 0x2::object::new(arg8),
            version                    : 1,
            is_active                  : true,
            min_deposit_amount         : arg1,
            staking_percent            : arg2,
            platform_fee_percent       : arg3,
            unbonding_period_ms        : arg4,
            vote_cooldown_ms           : arg5,
            snapshot_cooldown_ms       : arg6,
            total_staked_amount        : 0,
            total_sui_to_stake         : 0,
            total_sui_to_add_liquidity : 0,
            sui_vault                  : 0x2::balance::zero<0x2::sui::SUI>(),
            jwlsui_vault               : 0x2::balance::zero<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(),
            jwlsui_reserved            : 0,
            sjwlsui_reserved           : 0,
            validator_set              : 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::new(arg8),
            user_info                  : 0x2::table::new<address, UserInfo>(arg8),
            user_to_validator          : 0x2::table::new<address, UserToValidators>(arg8),
            total_rewards              : 0,
            total_protocol_rewards     : 0,
            protocol_rewards           : 0,
            rewards_threshold          : 100,
            rewards_update_ms          : 0,
            treasury_address           : arg7,
            last_epoch_checked_rewards : 0,
            total_sui_to_claim         : 0,
            total_sui_earned           : 0,
        };
        0x2::transfer::share_object<NativePool>(v0);
    }

    public entry fun migrate(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool) {
        assert_active(arg1);
        assert!(arg1.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg1.version,
            new_version  : 1,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg1.version = 1;
    }

    public entry fun redeem(arg0: &mut NativePool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = &mut arg0.user_info;
        check_user_info(v0, 0x2::tx_context::sender(arg3));
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg3));
        let v2 = 0x2::coin::value<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&arg2);
        0x2::coin::put<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&mut arg0.jwlsui_vault, arg2);
        v1.reserved_redeem_amount = v1.reserved_redeem_amount + v2;
        v1.last_redeem_reserved_at = 0x2::clock::timestamp_ms(arg1);
        let v3 = RedeemEvent{
            user_address  : 0x2::tx_context::sender(arg3),
            redeem_amount : v2,
        };
        0x2::event::emit<RedeemEvent>(v3);
    }

    fun set_rewards_unsafe(arg0: &mut NativePool, arg1: u64) {
        let v0 = RewardsUpdatedEvent{
            prev_value : arg0.total_rewards,
            new_value  : arg1,
        };
        0x2::event::emit<RewardsUpdatedEvent>(v0);
        arg0.total_rewards = arg1;
    }

    public entry fun snapshot(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OperatorCap, arg1: &mut NativePool, arg2: &0x2::clock::Clock) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.snapshot_cooldown_ms + 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_last_snapshot_update_ms(&arg1.validator_set), 121);
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::snapshot(&mut arg1.validator_set, v0);
        let v1 = SnapshotUpdatedEvent{snapshot_timestamp_ms: v0};
        0x2::event::emit<SnapshotUpdatedEvent>(v1);
    }

    public entry fun sort_validators(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OperatorCap, arg1: &mut NativePool) {
        assert_active(arg1);
        assert_version(arg1);
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::sort_validators(&mut arg1.validator_set);
    }

    public entry fun stake(arg0: &mut NativePool, arg1: 0x2::coin::Coin<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = &mut arg0.user_info;
        check_user_info(v0, 0x2::tx_context::sender(arg2));
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg2));
        let v2 = 0x2::coin::value<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&arg1);
        let v3 = if (arg0.sjwlsui_reserved == 0) {
            v2
        } else {
            0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(v2, arg0.sjwlsui_reserved, arg0.jwlsui_reserved)
        };
        0x2::coin::put<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&mut arg0.jwlsui_vault, arg1);
        arg0.jwlsui_reserved = arg0.jwlsui_reserved + v2;
        arg0.sjwlsui_reserved = arg0.sjwlsui_reserved + v3;
        v1.sjwlsui_amount = v1.sjwlsui_amount + v3;
        let v4 = StakeEvent{
            user_address    : 0x2::tx_context::sender(arg2),
            jwl_sui_amount  : v2,
            sjwl_sui_amount : v3,
        };
        0x2::event::emit<StakeEvent>(v4);
    }

    public entry fun stake_reserve_to_validator(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OperatorCap, arg1: &mut NativePool, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_vault, arg4, arg5), arg3, arg5);
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::add_stake(&mut arg1.validator_set, arg3, v0, arg5);
        arg1.total_staked_amount = arg1.total_staked_amount + arg4;
        arg1.total_sui_to_stake = arg1.total_sui_to_stake - arg4;
        let v1 = ReserveStakedEvent{
            stake_pool_id     : 0x2::object::id<NativePool>(arg1),
            validator_pool_id : 0x3::staking_pool::pool_id(&v0),
            amount            : arg4,
        };
        0x2::event::emit<ReserveStakedEvent>(v1);
    }

    public entry fun stake_reserve_to_validators(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OperatorCap, arg1: &mut NativePool, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_validators(&arg1.validator_set);
        assert!(0x1::vector::length<address>(&v0) > 0, 110);
        let v1 = arg1.total_sui_to_stake;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_vault) >= v1, 113);
        let v2 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_total_score(&arg1.validator_set);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v0)) {
            let v4 = *0x1::vector::borrow<address>(&v0, v3);
            let v5 = v1 / 0x1::vector::length<address>(&v0);
            if (v2 > 0) {
                v5 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(v1, 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_validator_score(&arg1.validator_set, v4), v2);
            };
            if (v5 >= 1000000000) {
                stake_reserve_to_validator(arg0, arg1, arg2, v4, v5, arg3);
            };
            v3 = v3 + 1;
        };
    }

    public entry fun unstake(arg0: &mut NativePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = &mut arg0.user_info;
        check_user_info(v0, 0x2::tx_context::sender(arg2));
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg2));
        assert!(v1.sjwlsui_amount >= arg1, 107);
        let v2 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(arg1, arg0.jwlsui_reserved, arg0.sjwlsui_reserved);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>>(0x2::coin::take<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&mut arg0.jwlsui_vault, v2, arg2), 0x2::tx_context::sender(arg2));
        arg0.jwlsui_reserved = arg0.jwlsui_reserved - v2;
        arg0.sjwlsui_reserved = arg0.sjwlsui_reserved - arg1;
        let v3 = v1.sjwlsui_amount - v1.voted_sjwlsui_amount;
        v1.sjwlsui_amount = v1.sjwlsui_amount - arg1;
        if (arg1 > v3) {
            let v4 = arg1 - v3;
            let v5 = 0x2::table::borrow<address, UserToValidators>(&arg0.user_to_validator, 0x2::tx_context::sender(arg2)).validators;
            let v6 = 0;
            let v7 = 0;
            while (v7 < 0x2::vec_map::size<address, UserToValidator>(&v5)) {
                let (v8, v9) = 0x2::vec_map::get_entry_by_idx_mut<address, UserToValidator>(&mut v5, v7);
                let v10 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(v4, v9.voting_point, v1.voted_sjwlsui_amount);
                let v11 = v9.voting_point;
                let v12 = v11 - v10;
                v9.voting_point = v12;
                0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::vote_validator(&mut arg0.validator_set, *v8, v11, v12);
                v6 = v6 + v10;
                v7 = v7 + 1;
            };
            if (v4 > v6) {
                let v13 = v4 - v6;
                let v14 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_validators(&arg0.validator_set);
                let v15 = 0;
                while (v15 < 0x1::vector::length<address>(&v14)) {
                    let v16 = 0x1::vector::borrow<address>(&v14, v15);
                    let v17 = 0x2::vec_map::get_mut<address, UserToValidator>(&mut v5, v16);
                    if (v17.voting_point > v13) {
                        let v18 = v17.voting_point;
                        let v19 = v18 - v13;
                        v17.voting_point = v19;
                        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::vote_validator(&mut arg0.validator_set, *v16, v18, v19);
                        v6 = v6 + v13;
                        break
                    };
                    v15 = v15 + 1;
                };
            };
            assert!(v4 == v6, 150);
            v1.voted_sjwlsui_amount = v1.voted_sjwlsui_amount - v4;
            let v20 = UserToValidators{validators: v5};
            *0x2::table::borrow_mut<address, UserToValidators>(&mut arg0.user_to_validator, 0x2::tx_context::sender(arg2)) = v20;
        };
        let v21 = UnstakeEvent{
            user_address    : 0x2::tx_context::sender(arg2),
            sjwl_sui_amount : arg1,
            jwl_sui_amount  : v2,
        };
        0x2::event::emit<UnstakeEvent>(v21);
    }

    fun unstake_sui_from_validators(arg0: &mut 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::ValidatorSet, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64, u64, u64) {
        let v0 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::get_validators(arg0);
        assert!(0x1::vector::length<address>(&v0) > 0, 110);
        let v1 = 0x1::vector::length<address>(&v0) - 1;
        let v2 = 0;
        let v3 = 0x2::balance::zero<0x2::sui::SUI>();
        let v4 = 0;
        let v5 = 0;
        while (v2 < arg3) {
            let (v6, v7, v8) = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::remove_stakes(arg0, arg2, *0x1::vector::borrow<address>(&v0, v1), arg3 - v2, arg4);
            v4 = v4 + v8;
            v5 = v5 + v7;
            0x2::balance::join<0x2::sui::SUI>(&mut v3, v6);
            v2 = 0x2::balance::value<0x2::sui::SUI>(&v3);
            if (v1 == 0) {
                break
            };
            v1 = v1 - 1;
        };
        let v9 = 0;
        if (v2 > arg3) {
            let v10 = v2 - arg3;
            v9 = v10;
            0x2::coin::put<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v10), arg4));
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), v9, v5, v4)
    }

    public entry fun update_active_status(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: bool) {
        assert_version(arg1);
        arg1.is_active = arg2;
        let v0 = ProtocolStatusUpdatedEvent{is_active: arg2};
        0x2::event::emit<ProtocolStatusUpdatedEvent>(v0);
    }

    public entry fun update_min_deposit_amount(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2 > 1000, 101);
        let v0 = MinDepositUpdatedEvent{
            prev_value : arg1.min_deposit_amount,
            new_value  : arg2,
        };
        0x2::event::emit<MinDepositUpdatedEvent>(v0);
        arg1.min_deposit_amount = arg2;
    }

    public entry fun update_platform_fee_percent(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2 > 0, 101);
        assert!(arg2 < 10000, 102);
        let v0 = PlatformFeePercentUpdatedEvent{
            prev_value : arg1.platform_fee_percent,
            new_value  : arg2,
        };
        0x2::event::emit<PlatformFeePercentUpdatedEvent>(v0);
        arg1.platform_fee_percent = arg2;
    }

    public entry fun update_snapshot_cooldown_ms(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2 > 0, 101);
        let v0 = SnapshotCooldownUpdatedEvent{
            prev_value : arg1.snapshot_cooldown_ms,
            new_value  : arg2,
        };
        0x2::event::emit<SnapshotCooldownUpdatedEvent>(v0);
        arg1.snapshot_cooldown_ms = arg2;
    }

    public entry fun update_staking_percent(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2 > 0, 101);
        assert!(arg2 <= 10000, 102);
        let v0 = StakingPercentUpdatedEvent{
            prev_value : arg1.staking_percent,
            new_value  : arg2,
        };
        0x2::event::emit<StakingPercentUpdatedEvent>(v0);
        arg1.staking_percent = arg2;
    }

    public entry fun update_treasury_address(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: address) {
        assert_active(arg1);
        assert_version(arg1);
        let v0 = TreasuryAddressUpdatedEvent{
            prev_address : arg1.treasury_address,
            new_address  : arg2,
        };
        0x2::event::emit<TreasuryAddressUpdatedEvent>(v0);
        arg1.treasury_address = arg2;
    }

    public entry fun update_unbonding_period_ms(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2 > 0, 101);
        let v0 = UnbondingPeriodUpdatedEvent{
            prev_value : arg1.unbonding_period_ms,
            new_value  : arg2,
        };
        0x2::event::emit<UnbondingPeriodUpdatedEvent>(v0);
        arg1.unbonding_period_ms = arg2;
    }

    public entry fun update_vote_cooldown_ms(arg0: &0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::ownership::OwnerCap, arg1: &mut NativePool, arg2: u64) {
        assert_active(arg1);
        assert_version(arg1);
        assert!(arg2 > 0, 101);
        let v0 = VoteCooldownUpdatedEvent{
            prev_value : arg1.vote_cooldown_ms,
            new_value  : arg2,
        };
        0x2::event::emit<VoteCooldownUpdatedEvent>(v0);
        arg1.vote_cooldown_ms = arg2;
    }

    public entry fun vote_validator(arg0: &mut NativePool, arg1: &0x2::clock::Clock, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        assert!(arg3 >= 0 && arg3 <= 10000, 106);
        let v0 = &mut arg0.user_info;
        check_user_info(v0, 0x2::tx_context::sender(arg4));
        let v1 = &mut arg0.user_to_validator;
        let v2 = &mut arg0.validator_set;
        check_user_to_validator(v1, 0x2::tx_context::sender(arg4), v2);
        let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg4));
        assert!(v3.sjwlsui_amount > 0 && arg0.sjwlsui_reserved > 0, 104);
        let v4 = 0x2::table::borrow<address, UserToValidators>(&arg0.user_to_validator, 0x2::tx_context::sender(arg4)).validators;
        assert!(0x2::vec_map::contains<address, UserToValidator>(&v4, &arg2), 115);
        let v5 = 0x2::vec_map::get_mut<address, UserToValidator>(&mut v4, &arg2);
        let v6 = 0x2::clock::timestamp_ms(arg1);
        assert!(v6 > v5.last_voted_at + arg0.vote_cooldown_ms, 105);
        let v7 = 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::math::mul_div(v3.sjwlsui_amount, arg3, 10000);
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::validator_set::vote_validator(&mut arg0.validator_set, arg2, v5.voting_point, v7);
        v3.voted_sjwlsui_amount = v3.voted_sjwlsui_amount - v5.voting_point + v7;
        assert!(v3.voted_sjwlsui_amount <= v3.sjwlsui_amount, 107);
        v5.last_voted_at = v6;
        v5.voting_point = v7;
        let v8 = UserToValidators{validators: v4};
        *0x2::table::borrow_mut<address, UserToValidators>(&mut arg0.user_to_validator, 0x2::tx_context::sender(arg4)) = v8;
        let v9 = VoteEvent{
            user_address     : 0x2::tx_context::sender(arg4),
            target_validator : arg2,
            vote_percentage  : arg3,
            vote_weight      : v7,
        };
        0x2::event::emit<VoteEvent>(v9);
    }

    public entry fun withdraw(arg0: &mut NativePool, arg1: &mut 0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JwlSuiMetadata<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_version(arg0);
        let v0 = &mut arg0.user_info;
        check_user_info(v0, 0x2::tx_context::sender(arg4));
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg4));
        let v2 = v1.reserved_redeem_amount;
        assert!(v2 > 0, 108);
        assert!(0x2::clock::timestamp_ms(arg3) > v1.last_redeem_reserved_at + arg0.unbonding_period_ms, 109);
        if (arg0.total_sui_to_stake >= v2) {
            arg0.total_sui_to_stake = arg0.total_sui_to_stake - v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_vault, v2, arg4), 0x2::tx_context::sender(arg4));
        } else {
            let v3 = v2 - arg0.total_sui_to_stake;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_vault, arg0.total_sui_to_stake, arg4), 0x2::tx_context::sender(arg4));
            arg0.total_sui_to_stake = 0;
            let v4 = &mut arg0.validator_set;
            let v5 = &mut arg0.sui_vault;
            let (v6, v7, v8, v9) = unstake_sui_from_validators(v4, v5, arg2, v3, arg4);
            let v10 = v6;
            if (v7 > 0) {
                arg0.total_sui_to_stake = arg0.total_sui_to_stake + v7;
            };
            assert!(arg0.total_rewards >= v9, 119);
            let v11 = arg0.total_rewards;
            arg0.total_rewards = v11 - v9;
            let v12 = RewardsUpdatedEvent{
                prev_value : v11,
                new_value  : arg0.total_rewards,
            };
            0x2::event::emit<RewardsUpdatedEvent>(v12);
            assert!(0x2::coin::value<0x2::sui::SUI>(&v10) == v3, 120);
            arg0.total_staked_amount = arg0.total_staked_amount - v8;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, 0x2::tx_context::sender(arg4));
            if (arg0.protocol_rewards > 0 && arg0.total_sui_to_stake > 0) {
                if (arg0.total_sui_to_stake >= arg0.protocol_rewards) {
                    if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault) >= arg0.protocol_rewards) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_vault, arg0.protocol_rewards, arg4), arg0.treasury_address);
                        let v13 = ProtocolRewardsClaimedEvent{claim_amount: arg0.protocol_rewards};
                        0x2::event::emit<ProtocolRewardsClaimedEvent>(v13);
                        arg0.total_sui_to_stake = arg0.total_sui_to_stake - arg0.protocol_rewards;
                        arg0.protocol_rewards = 0;
                    };
                } else {
                    let v14 = arg0.total_sui_to_stake;
                    if (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault) >= v14) {
                        arg0.total_sui_to_stake = 0;
                        arg0.protocol_rewards = arg0.protocol_rewards - v14;
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_vault, v14, arg4), arg0.treasury_address);
                        let v15 = ProtocolRewardsClaimedEvent{claim_amount: v14};
                        0x2::event::emit<ProtocolRewardsClaimedEvent>(v15);
                    };
                };
            };
        };
        v1.reserved_redeem_amount = 0;
        0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::burn_balance(arg1, 0x2::balance::split<0x2921ca2fe6ee99698b095f046bc9759ce7a764d2e91ab0ad182c143649c3df79::jwlsui::JWLSUI>(&mut arg0.jwlsui_vault, v2));
        let v16 = WithdrawEvent{
            user_address : 0x2::tx_context::sender(arg4),
            amount       : v2,
        };
        0x2::event::emit<WithdrawEvent>(v16);
    }

    // decompiled from Move bytecode v6
}

