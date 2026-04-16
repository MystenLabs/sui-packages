module 0xe54de64b815f2e7b696b4b1f7b5616c3e551091b094bccf8b3a2f3c2dde3124f::maker_incentives {
    struct MAKER_INCENTIVES has drop {
        dummy_field: bool,
    }

    struct FundOwnerCap has store, key {
        id: 0x2::object::UID,
        fund_id: 0x2::object::ID,
    }

    struct PendingFundParams has copy, drop, store {
        reward_per_epoch: u64,
        alpha_bps: u64,
        quality_p: u64,
    }

    struct IncentiveFund has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        treasury: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        reward_per_epoch: u64,
        alpha_bps: u64,
        quality_p: u64,
        is_active: bool,
        submitted_epochs: 0x2::table::Table<u64, bool>,
        created_at_ms: u64,
        pending_params: 0x1::option::Option<PendingFundParams>,
        params_effective_at_ms: u64,
    }

    struct EpochResults has copy, drop {
        pool_id: address,
        fund_id: address,
        epoch_start_ms: u64,
        epoch_end_ms: u64,
        maker_rewards: vector<MakerRewardEntry>,
        alpha_bps: u64,
        quality_p: u64,
    }

    struct MakerRewardEntry has copy, drop, store {
        balance_manager_id: address,
        score: u64,
    }

    struct EpochRecord has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        fund_id: address,
        epoch_start_ms: u64,
        epoch_end_ms: u64,
        total_allocation: u64,
        total_score: u64,
        rewards: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        maker_scores: vector<MakerRewardEntry>,
        claimed: vector<address>,
    }

    struct FundCreated has copy, drop {
        pool_id: address,
        fund_id: 0x2::object::ID,
        reward_per_epoch: u64,
        creator: address,
        created_at_ms: u64,
        alpha_bps: u64,
        quality_p: u64,
    }

    struct EpochResultsSubmitted has copy, drop {
        pool_id: address,
        fund_id: address,
        epoch_start_ms: u64,
        epoch_end_ms: u64,
        total_allocation: u64,
        num_makers: u64,
    }

    struct RewardClaimed has copy, drop {
        pool_id: address,
        fund_id: address,
        epoch_start_ms: u64,
        balance_manager_id: address,
        amount: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        pool_id: address,
        fund_id: address,
        owner: address,
        amount: u64,
        treasury_after: u64,
        locked_after: u64,
        withdrawable_after: u64,
        reward_per_epoch: u64,
    }

    struct FundParamsChangeScheduled has copy, drop {
        pool_id: address,
        fund_id: address,
        reward_per_epoch: u64,
        alpha_bps: u64,
        quality_p: u64,
        effective_at_ms: u64,
        scheduled_at_ms: u64,
    }

    struct FundParamsChangeApplied has copy, drop {
        pool_id: address,
        fund_id: address,
        reward_per_epoch: u64,
        alpha_bps: u64,
        quality_p: u64,
    }

    struct FundParamsChangeCancelled has copy, drop {
        pool_id: address,
        fund_id: address,
    }

    public fun cancel_scheduled_params_change(arg0: &FundOwnerCap, arg1: &mut IncentiveFund) {
        assert!(arg0.fund_id == 0x2::object::id<IncentiveFund>(arg1), 8);
        if (0x1::option::is_none<PendingFundParams>(&arg1.pending_params)) {
            return
        };
        arg1.pending_params = 0x1::option::none<PendingFundParams>();
        arg1.params_effective_at_ms = 0;
        let v0 = 0x2::object::id<IncentiveFund>(arg1);
        let v1 = FundParamsChangeCancelled{
            pool_id : arg1.pool_id,
            fund_id : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<FundParamsChangeCancelled>(v1);
    }

    public fun claim_reward(arg0: &mut EpochRecord, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(arg0.total_score > 0, 6);
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) == 0x2::tx_context::sender(arg2), 5);
        assert!(!0x1::vector::contains<address>(&arg0.claimed, &v1), 4);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<MakerRewardEntry>(&arg0.maker_scores)) {
            let v4 = 0x1::vector::borrow<MakerRewardEntry>(&arg0.maker_scores, v3);
            if (v4.balance_manager_id == v1) {
                v2 = v4.score;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 3);
        let v5 = (((arg0.total_allocation as u128) * (v2 as u128) / (arg0.total_score as u128)) as u64);
        0x1::vector::push_back<address>(&mut arg0.claimed, v1);
        let v6 = RewardClaimed{
            pool_id            : arg0.pool_id,
            fund_id            : arg0.fund_id,
            epoch_start_ms     : arg0.epoch_start_ms,
            balance_manager_id : v1,
            amount             : v5,
        };
        0x2::event::emit<RewardClaimed>(v6);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.rewards, v5), arg2)
    }

    public fun create_fund(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : FundOwnerCap {
        assert!(arg3 >= 1, 11);
        let v0 = if (arg4 == 0) {
            0x2::clock::timestamp_ms(arg5)
        } else {
            arg4
        };
        let v1 = IncentiveFund{
            id                     : 0x2::object::new(arg6),
            pool_id                : arg0,
            treasury               : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            reward_per_epoch       : arg1,
            alpha_bps              : arg2,
            quality_p              : arg3,
            is_active              : true,
            submitted_epochs       : 0x2::table::new<u64, bool>(arg6),
            created_at_ms          : v0,
            pending_params         : 0x1::option::none<PendingFundParams>(),
            params_effective_at_ms : 0,
        };
        let v2 = 0x2::object::id<IncentiveFund>(&v1);
        let v3 = FundCreated{
            pool_id          : arg0,
            fund_id          : v2,
            reward_per_epoch : arg1,
            creator          : 0x2::tx_context::sender(arg6),
            created_at_ms    : v0,
            alpha_bps        : arg2,
            quality_p        : arg3,
        };
        0x2::event::emit<FundCreated>(v3);
        0x2::transfer::share_object<IncentiveFund>(v1);
        FundOwnerCap{
            id      : 0x2::object::new(arg6),
            fund_id : v2,
        }
    }

    fun effective_alpha_bps(arg0: &IncentiveFund, arg1: u64) : u64 {
        if (0x1::option::is_some<PendingFundParams>(&arg0.pending_params) && arg1 >= arg0.params_effective_at_ms) {
            return 0x1::option::borrow<PendingFundParams>(&arg0.pending_params).alpha_bps
        };
        arg0.alpha_bps
    }

    fun effective_quality_p(arg0: &IncentiveFund, arg1: u64) : u64 {
        if (0x1::option::is_some<PendingFundParams>(&arg0.pending_params) && arg1 >= arg0.params_effective_at_ms) {
            return 0x1::option::borrow<PendingFundParams>(&arg0.pending_params).quality_p
        };
        arg0.quality_p
    }

    fun effective_reward_per_epoch(arg0: &IncentiveFund, arg1: u64) : u64 {
        if (0x1::option::is_some<PendingFundParams>(&arg0.pending_params) && arg1 >= arg0.params_effective_at_ms) {
            return 0x1::option::borrow<PendingFundParams>(&arg0.pending_params).reward_per_epoch
        };
        arg0.reward_per_epoch
    }

    public fun estimate_payout(arg0: &IncentiveFund, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury) >= arg0.reward_per_epoch) {
            arg0.reward_per_epoch
        } else {
            0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury)
        };
        (((v0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun finalize_pending_params(arg0: &mut IncentiveFund, arg1: &0x2::clock::Clock) {
        maybe_apply_pending_params(arg0, arg1);
    }

    public fun fund(arg0: &mut IncentiveFund, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.treasury, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun fund_alpha_bps(arg0: &IncentiveFund) : u64 {
        arg0.alpha_bps
    }

    public fun fund_created_at_ms(arg0: &IncentiveFund) : u64 {
        arg0.created_at_ms
    }

    public fun fund_effective_alpha_bps(arg0: &IncentiveFund, arg1: &0x2::clock::Clock) : u64 {
        effective_alpha_bps(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun fund_effective_quality_p(arg0: &IncentiveFund, arg1: &0x2::clock::Clock) : u64 {
        effective_quality_p(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun fund_effective_reward_per_epoch(arg0: &IncentiveFund, arg1: &0x2::clock::Clock) : u64 {
        effective_reward_per_epoch(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun fund_epoch_duration_ms(arg0: &IncentiveFund) : u64 {
        86400000
    }

    public fun fund_funded_epochs(arg0: &IncentiveFund) : u64 {
        if (arg0.reward_per_epoch == 0) {
            return 0
        };
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury) / arg0.reward_per_epoch
    }

    public fun fund_has_pending_params(arg0: &IncentiveFund) : bool {
        0x1::option::is_some<PendingFundParams>(&arg0.pending_params)
    }

    public fun fund_is_active(arg0: &IncentiveFund) : bool {
        arg0.is_active
    }

    public fun fund_locked_treasury(arg0: &IncentiveFund) : u64 {
        locked_treasury_amount(arg0)
    }

    public fun fund_params_effective_at_ms(arg0: &IncentiveFund) : u64 {
        arg0.params_effective_at_ms
    }

    public fun fund_pending_params_info(arg0: &IncentiveFund) : (bool, u64, u64, u64, u64) {
        if (0x1::option::is_none<PendingFundParams>(&arg0.pending_params)) {
            return (false, 0, 0, 0, 0)
        };
        let v0 = *0x1::option::borrow<PendingFundParams>(&arg0.pending_params);
        (true, v0.reward_per_epoch, v0.alpha_bps, v0.quality_p, arg0.params_effective_at_ms)
    }

    public fun fund_pool_id(arg0: &IncentiveFund) : address {
        arg0.pool_id
    }

    public fun fund_quality_p(arg0: &IncentiveFund) : u64 {
        arg0.quality_p
    }

    public fun fund_reward_per_epoch(arg0: &IncentiveFund) : u64 {
        arg0.reward_per_epoch
    }

    public fun fund_treasury_balance(arg0: &IncentiveFund) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury)
    }

    public fun fund_window_duration_ms(arg0: &IncentiveFund) : u64 {
        3600000
    }

    public fun fund_withdrawable_treasury(arg0: &IncentiveFund) : u64 {
        withdrawable_treasury_amount(arg0)
    }

    fun init(arg0: MAKER_INCENTIVES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe54de64b815f2e7b696b4b1f7b5616c3e551091b094bccf8b3a2f3c2dde3124f::enclave::new_cap<MAKER_INCENTIVES>(arg0, arg1);
        0xe54de64b815f2e7b696b4b1f7b5616c3e551091b094bccf8b3a2f3c2dde3124f::enclave::create_enclave_config<MAKER_INCENTIVES>(&v0, 0x1::string::utf8(b"DeepBook Maker Incentives"), x"377b6a16231d44a255d222a9932051847d3fbba53f2e8fc02efbc24f2b4f51797f7c9e951dcd8c45a2d3045323ef8c78", x"377b6a16231d44a255d222a9932051847d3fbba53f2e8fc02efbc24f2b4f51797f7c9e951dcd8c45a2d3045323ef8c78", x"21b9efbc184807662e966d34f390821309eeac6802309798826296bf3e8bec7c10edb30948c90ba67310f7b964fc500a", arg1);
        0x2::transfer::public_transfer<0xe54de64b815f2e7b696b4b1f7b5616c3e551091b094bccf8b3a2f3c2dde3124f::enclave::Cap<MAKER_INCENTIVES>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_epoch_submitted(arg0: &IncentiveFund, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.submitted_epochs, arg1)
    }

    fun locked_treasury_amount(arg0: &IncentiveFund) : u64 {
        let v0 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury);
        let v1 = two_epoch_lock_cap(arg0.reward_per_epoch);
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    fun maybe_apply_pending_params(arg0: &mut IncentiveFund, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_none<PendingFundParams>(&arg0.pending_params)) {
            return
        };
        if (0x2::clock::timestamp_ms(arg1) < arg0.params_effective_at_ms) {
            return
        };
        let v0 = *0x1::option::borrow<PendingFundParams>(&arg0.pending_params);
        arg0.pending_params = 0x1::option::none<PendingFundParams>();
        arg0.params_effective_at_ms = 0;
        arg0.reward_per_epoch = v0.reward_per_epoch;
        arg0.alpha_bps = v0.alpha_bps;
        arg0.quality_p = v0.quality_p;
        let v1 = 0x2::object::id<IncentiveFund>(arg0);
        let v2 = FundParamsChangeApplied{
            pool_id          : arg0.pool_id,
            fund_id          : 0x2::object::id_to_address(&v1),
            reward_per_epoch : v0.reward_per_epoch,
            alpha_bps        : v0.alpha_bps,
            quality_p        : v0.quality_p,
        };
        0x2::event::emit<FundParamsChangeApplied>(v2);
    }

    public fun new_maker_reward_entry(arg0: address, arg1: u64) : MakerRewardEntry {
        MakerRewardEntry{
            balance_manager_id : arg0,
            score              : arg1,
        }
    }

    public fun param_change_delay_epochs() : u64 {
        2
    }

    public fun record_fund_id(arg0: &EpochRecord) : address {
        arg0.fund_id
    }

    public fun record_maker_info(arg0: &EpochRecord, arg1: address) : (u64, bool) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<MakerRewardEntry>(&arg0.maker_scores)) {
            let v2 = 0x1::vector::borrow<MakerRewardEntry>(&arg0.maker_scores, v1);
            if (v2.balance_manager_id == arg1) {
                v0 = v2.score;
                break
            };
            v1 = v1 + 1;
        };
        (v0, 0x1::vector::contains<address>(&arg0.claimed, &arg1))
    }

    public fun record_remaining_rewards(arg0: &EpochRecord) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.rewards)
    }

    public fun record_total_allocation(arg0: &EpochRecord) : u64 {
        arg0.total_allocation
    }

    public fun record_total_score(arg0: &EpochRecord) : u64 {
        arg0.total_score
    }

    public fun schedule_params_change(arg0: &FundOwnerCap, arg1: &mut IncentiveFund, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg0.fund_id == 0x2::object::id<IncentiveFund>(arg1), 8);
        assert!(arg5 >= 1, 11);
        maybe_apply_pending_params(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = (v0 as u128) + (2 as u128) * (86400000 as u128);
        let v2 = if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        };
        let v3 = PendingFundParams{
            reward_per_epoch : arg3,
            alpha_bps        : arg4,
            quality_p        : arg5,
        };
        arg1.pending_params = 0x1::option::some<PendingFundParams>(v3);
        arg1.params_effective_at_ms = v2;
        let v4 = 0x2::object::id<IncentiveFund>(arg1);
        let v5 = FundParamsChangeScheduled{
            pool_id          : arg1.pool_id,
            fund_id          : 0x2::object::id_to_address(&v4),
            reward_per_epoch : arg3,
            alpha_bps        : arg4,
            quality_p        : arg5,
            effective_at_ms  : v2,
            scheduled_at_ms  : v0,
        };
        0x2::event::emit<FundParamsChangeScheduled>(v5);
    }

    public fun set_fund_active(arg0: &FundOwnerCap, arg1: &mut IncentiveFund, arg2: bool) {
        assert!(arg0.fund_id == 0x2::object::id<IncentiveFund>(arg1), 8);
        arg1.is_active = arg2;
    }

    public fun submit_epoch_results(arg0: &mut IncentiveFund, arg1: &0xe54de64b815f2e7b696b4b1f7b5616c3e551091b094bccf8b3a2f3c2dde3124f::enclave::Enclave<MAKER_INCENTIVES>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: vector<MakerRewardEntry>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        maybe_apply_pending_params(arg0, arg2);
        assert!(arg0.is_active, 1);
        assert!(arg4 > arg3, 2);
        assert!(arg4 - arg3 == 86400000, 10);
        assert!(arg3 >= arg0.created_at_ms, 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg4, 14);
        assert!(!0x2::table::contains<u64, bool>(&arg0.submitted_epochs, arg3), 7);
        assert!(0x1::vector::length<MakerRewardEntry>(&arg5) <= 500, 15);
        let v0 = 0x2::object::id<IncentiveFund>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = EpochResults{
            pool_id        : arg0.pool_id,
            fund_id        : v1,
            epoch_start_ms : arg3,
            epoch_end_ms   : arg4,
            maker_rewards  : arg5,
            alpha_bps      : arg0.alpha_bps,
            quality_p      : arg0.quality_p,
        };
        assert!(0xe54de64b815f2e7b696b4b1f7b5616c3e551091b094bccf8b3a2f3c2dde3124f::enclave::verify_signature<MAKER_INCENTIVES, EpochResults>(arg1, 1, arg6, v2, &arg7), 0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<MakerRewardEntry>(&v2.maker_rewards)) {
            v3 = v3 + 0x1::vector::borrow<MakerRewardEntry>(&v2.maker_rewards, v4).score;
            v4 = v4 + 1;
        };
        let v5 = if (v3 == 0) {
            0
        } else if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury) >= arg0.reward_per_epoch) {
            arg0.reward_per_epoch
        } else {
            0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury)
        };
        let v6 = EpochRecord{
            id               : 0x2::object::new(arg8),
            pool_id          : arg0.pool_id,
            fund_id          : v1,
            epoch_start_ms   : arg3,
            epoch_end_ms     : arg4,
            total_allocation : v5,
            total_score      : v3,
            rewards          : 0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.treasury, v5),
            maker_scores     : v2.maker_rewards,
            claimed          : 0x1::vector::empty<address>(),
        };
        let v7 = EpochResultsSubmitted{
            pool_id          : arg0.pool_id,
            fund_id          : v1,
            epoch_start_ms   : arg3,
            epoch_end_ms     : arg4,
            total_allocation : v5,
            num_makers       : 0x1::vector::length<MakerRewardEntry>(&v2.maker_rewards),
        };
        0x2::event::emit<EpochResultsSubmitted>(v7);
        0x2::table::add<u64, bool>(&mut arg0.submitted_epochs, arg3, true);
        0x2::transfer::share_object<EpochRecord>(v6);
    }

    fun two_epoch_lock_cap(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 as u128) * 2;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun withdraw_treasury(arg0: &FundOwnerCap, arg1: &mut IncentiveFund, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(arg0.fund_id == 0x2::object::id<IncentiveFund>(arg1), 8);
        maybe_apply_pending_params(arg1, arg2);
        assert!(arg3 > 0, 13);
        assert!(arg3 <= withdrawable_treasury_amount(arg1), 12);
        let v0 = 0x2::object::id<IncentiveFund>(arg1);
        let v1 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.treasury);
        let v2 = locked_treasury_amount(arg1);
        let v3 = TreasuryWithdrawn{
            pool_id            : arg1.pool_id,
            fund_id            : 0x2::object::id_to_address(&v0),
            owner              : 0x2::tx_context::sender(arg4),
            amount             : arg3,
            treasury_after     : v1,
            locked_after       : v2,
            withdrawable_after : v1 - v2,
            reward_per_epoch   : arg1.reward_per_epoch,
        };
        0x2::event::emit<TreasuryWithdrawn>(v3);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.treasury, arg3), arg4)
    }

    fun withdrawable_treasury_amount(arg0: &IncentiveFund) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.treasury) - locked_treasury_amount(arg0)
    }

    // decompiled from Move bytecode v6
}

