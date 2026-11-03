module 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events {
    struct ProtocolDestinationCancelled has copy, drop {
        destination: address,
    }

    struct ProtocolDestinationScheduled has copy, drop {
        destination: address,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct DefaultSharesCancelled has copy, drop {
        meme_bps: u64,
        quote_bps: u64,
    }

    struct DefaultSharesScheduled has copy, drop {
        meme_bps: u64,
        quote_bps: u64,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct CoinSharesCancelled has copy, drop {
        meme: 0x1::type_name::TypeName,
        meme_bps: 0x1::option::Option<u64>,
        quote_bps: 0x1::option::Option<u64>,
    }

    struct CoinSharesScheduled has copy, drop {
        meme: 0x1::type_name::TypeName,
        meme_bps: 0x1::option::Option<u64>,
        quote_bps: 0x1::option::Option<u64>,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct UpgradeActionCancelled has copy, drop {
        digest: 0x1::option::Option<vector<u8>>,
    }

    struct UpgradeActionScheduled has copy, drop {
        digest: 0x1::option::Option<vector<u8>>,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct LpFeePolicyChanged has copy, drop {
        meme: 0x1::option::Option<0x1::type_name::TypeName>,
        old_meme_bps: 0x1::option::Option<u64>,
        old_quote_bps: 0x1::option::Option<u64>,
        new_meme_bps: 0x1::option::Option<u64>,
        new_quote_bps: 0x1::option::Option<u64>,
    }

    struct LpFeeDestinationChanged has copy, drop {
        old_destination: address,
        new_destination: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        venue: 0x1::type_name::TypeName,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        residual_meme: u64,
        residual_quote: u64,
        liquidity: u128,
        fee_split: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit,
    }

    struct FeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        gross_meme: u64,
        gross_quote: u64,
        protocol_destination: 0x1::option::Option<address>,
        protocol_meme: u64,
        protocol_quote: u64,
        creator_meme: u64,
        creator_quote: u64,
        auto_lp_meme: u64,
        auto_lp_quote: u64,
        rewards_meme: u64,
        rewards_quote: u64,
        burn_meme: u64,
        burn_quote: u64,
        recipient_meme: vector<u64>,
        recipient_quote: vector<u64>,
    }

    struct AutoLiquidityAdded has copy, drop {
        vault_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
        meme_pending: u64,
        quote_pending: u64,
    }

    struct BuybackBurned has copy, drop {
        vault_id: 0x2::object::ID,
        quote_spent: u64,
        meme_burned: u64,
        quote_pending: u64,
    }

    struct AutoLpPositionOpened has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct FeeSplitScheduled has copy, drop {
        vault_id: 0x2::object::ID,
        proposed: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct FeeSplitCancelled has copy, drop {
        vault_id: 0x2::object::ID,
        proposed: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit,
    }

    struct FeeSplitChanged has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_split: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit,
        new_fee_split: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit,
        delay_ms: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
    }

    struct RoundPublished has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        start_checkpoint: u64,
        end_checkpoint: u64,
        claim_deadline_at_ms: u64,
        root: vector<u8>,
        manifest_digest: vector<u8>,
        leaf_count: u64,
        meme_amount: u64,
        quote_amount: u64,
        meme_unallocated: u64,
        quote_unallocated: u64,
        treasury: address,
        gas_reserve_amount: u64,
    }

    struct GasReserveSettled has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        treasury: address,
        reimbursement_amount: u64,
        reserve_returned: u64,
        quote_unallocated: u64,
    }

    struct RoundClosed has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        meme_returned: u64,
        quote_returned: u64,
        gas_reserve_returned: u64,
    }

    struct RewardPaid has copy, drop {
        round_id: 0x2::object::ID,
        index: u64,
        beneficiary: address,
        meme_amount: u64,
        quote_amount: u64,
        meme_remaining: u64,
        quote_remaining: u64,
    }

    struct ProtocolFeesClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        claimant: address,
        meme_amount: u64,
        quote_amount: u64,
    }

    struct ProtocolLpFeesClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        protocol_destination: address,
        protocol_meme: u64,
        protocol_quote: u64,
        partner_meme: u64,
        partner_quote: u64,
    }

    struct CetusPoolReserved has copy, drop {
        meme: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        pool_creation_cap_id: 0x2::object::ID,
        tick_spacing: u32,
    }

    struct UpgradeDelayScheduled has copy, drop {
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct UpgradeDelayChanged has copy, drop {
        delay_ms: u64,
    }

    public(friend) fun auto_liquidity_added(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AutoLiquidityAdded{
            vault_id      : arg0,
            meme_amount   : arg1,
            quote_amount  : arg2,
            meme_pending  : arg3,
            quote_pending : arg4,
        };
        0x2::event::emit<AutoLiquidityAdded>(v0);
    }

    public(friend) fun auto_lp_position_opened(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = AutoLpPositionOpened{
            vault_id    : arg0,
            position_id : arg1,
        };
        0x2::event::emit<AutoLpPositionOpened>(v0);
    }

    public(friend) fun buyback_burned(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = BuybackBurned{
            vault_id      : arg0,
            quote_spent   : arg1,
            meme_burned   : arg2,
            quote_pending : arg3,
        };
        0x2::event::emit<BuybackBurned>(v0);
    }

    public(friend) fun cetus_pool_reserved<T0, T1>(arg0: 0x2::object::ID, arg1: u32) {
        let v0 = CetusPoolReserved{
            meme                 : 0x1::type_name::with_original_ids<T0>(),
            quote                : 0x1::type_name::with_original_ids<T1>(),
            pool_creation_cap_id : arg0,
            tick_spacing         : arg1,
        };
        0x2::event::emit<CetusPoolReserved>(v0);
    }

    public(friend) fun coin_shares_cancelled(arg0: 0x1::type_name::TypeName, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) {
        let v0 = CoinSharesCancelled{
            meme      : arg0,
            meme_bps  : arg1,
            quote_bps : arg2,
        };
        0x2::event::emit<CoinSharesCancelled>(v0);
    }

    public(friend) fun coin_shares_scheduled(arg0: 0x1::type_name::TypeName, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: u64) {
        let v0 = CoinSharesScheduled{
            meme        : arg0,
            meme_bps    : arg1,
            quote_bps   : arg2,
            ready_at_ms : arg3,
            delay_ms    : arg4,
        };
        0x2::event::emit<CoinSharesScheduled>(v0);
    }

    public(friend) fun creator_fees_claimed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = CreatorFeesClaimed{
            vault_id     : arg0,
            meme_amount  : arg1,
            quote_amount : arg2,
        };
        0x2::event::emit<CreatorFeesClaimed>(v0);
    }

    public(friend) fun default_shares_cancelled(arg0: u64, arg1: u64) {
        let v0 = DefaultSharesCancelled{
            meme_bps  : arg0,
            quote_bps : arg1,
        };
        0x2::event::emit<DefaultSharesCancelled>(v0);
    }

    public(friend) fun default_shares_scheduled(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = DefaultSharesScheduled{
            meme_bps    : arg0,
            quote_bps   : arg1,
            ready_at_ms : arg2,
            delay_ms    : arg3,
        };
        0x2::event::emit<DefaultSharesScheduled>(v0);
    }

    public(friend) fun fee_split_cancelled(arg0: 0x2::object::ID, arg1: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit) {
        let v0 = FeeSplitCancelled{
            vault_id : arg0,
            proposed : arg1,
        };
        0x2::event::emit<FeeSplitCancelled>(v0);
    }

    public(friend) fun fee_split_changed(arg0: 0x2::object::ID, arg1: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit, arg2: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit, arg3: u64) {
        let v0 = FeeSplitChanged{
            vault_id      : arg0,
            old_fee_split : arg1,
            new_fee_split : arg2,
            delay_ms      : arg3,
        };
        0x2::event::emit<FeeSplitChanged>(v0);
    }

    public(friend) fun fee_split_scheduled(arg0: 0x2::object::ID, arg1: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit, arg2: u64, arg3: u64) {
        let v0 = FeeSplitScheduled{
            vault_id    : arg0,
            proposed    : arg1,
            ready_at_ms : arg2,
            delay_ms    : arg3,
        };
        0x2::event::emit<FeeSplitScheduled>(v0);
    }

    public(friend) fun fees_collected(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0x1::option::Option<address>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: vector<u64>, arg15: vector<u64>) {
        let v0 = FeesCollected{
            vault_id             : arg0,
            gross_meme           : arg1,
            gross_quote          : arg2,
            protocol_destination : arg3,
            protocol_meme        : arg4,
            protocol_quote       : arg5,
            creator_meme         : arg6,
            creator_quote        : arg7,
            auto_lp_meme         : arg8,
            auto_lp_quote        : arg9,
            rewards_meme         : arg10,
            rewards_quote        : arg11,
            burn_meme            : arg12,
            burn_quote           : arg13,
            recipient_meme       : arg14,
            recipient_quote      : arg15,
        };
        0x2::event::emit<FeesCollected>(v0);
    }

    public(friend) fun gas_reserve_settled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = GasReserveSettled{
            vault_id             : arg0,
            round_id             : arg1,
            number               : arg2,
            treasury             : arg3,
            reimbursement_amount : arg4,
            reserve_returned     : arg5,
            quote_unallocated    : arg6,
        };
        0x2::event::emit<GasReserveSettled>(v0);
    }

    public(friend) fun lp_fee_destination_changed(arg0: address, arg1: address) {
        let v0 = LpFeeDestinationChanged{
            old_destination : arg0,
            new_destination : arg1,
        };
        0x2::event::emit<LpFeeDestinationChanged>(v0);
    }

    public(friend) fun lp_fee_policy_changed(arg0: 0x1::option::Option<0x1::type_name::TypeName>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>) {
        let v0 = LpFeePolicyChanged{
            meme          : arg0,
            old_meme_bps  : arg1,
            old_quote_bps : arg2,
            new_meme_bps  : arg3,
            new_quote_bps : arg4,
        };
        0x2::event::emit<LpFeePolicyChanged>(v0);
    }

    public(friend) fun protocol_destination_cancelled(arg0: address) {
        let v0 = ProtocolDestinationCancelled{destination: arg0};
        0x2::event::emit<ProtocolDestinationCancelled>(v0);
    }

    public(friend) fun protocol_destination_scheduled(arg0: address, arg1: u64, arg2: u64) {
        let v0 = ProtocolDestinationScheduled{
            destination : arg0,
            ready_at_ms : arg1,
            delay_ms    : arg2,
        };
        0x2::event::emit<ProtocolDestinationScheduled>(v0);
    }

    public(friend) fun protocol_fees_claimed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ProtocolFeesClaimed{
            vault_id     : arg0,
            meme         : 0x1::type_name::with_original_ids<T0>(),
            quote        : 0x1::type_name::with_original_ids<T1>(),
            claimant     : arg1,
            meme_amount  : arg2,
            quote_amount : arg3,
        };
        0x2::event::emit<ProtocolFeesClaimed>(v0);
    }

    public(friend) fun protocol_lp_fees_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ProtocolLpFeesClaimed{
            vault_id             : arg0,
            protocol_destination : arg1,
            protocol_meme        : arg2,
            protocol_quote       : arg3,
            partner_meme         : arg4,
            partner_quote        : arg5,
        };
        0x2::event::emit<ProtocolLpFeesClaimed>(v0);
    }

    public(friend) fun reward_paid(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = RewardPaid{
            round_id        : arg0,
            index           : arg1,
            beneficiary     : arg2,
            meme_amount     : arg3,
            quote_amount    : arg4,
            meme_remaining  : arg5,
            quote_remaining : arg6,
        };
        0x2::event::emit<RewardPaid>(v0);
    }

    public(friend) fun round_closed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = RoundClosed{
            vault_id             : arg0,
            round_id             : arg1,
            number               : arg2,
            meme_returned        : arg3,
            quote_returned       : arg4,
            gas_reserve_returned : arg5,
        };
        0x2::event::emit<RoundClosed>(v0);
    }

    public(friend) fun round_published(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u64) {
        let v0 = RoundPublished{
            vault_id             : arg0,
            round_id             : arg1,
            number               : arg2,
            start_checkpoint     : arg3,
            end_checkpoint       : arg4,
            claim_deadline_at_ms : arg5,
            root                 : arg6,
            manifest_digest      : arg7,
            leaf_count           : arg8,
            meme_amount          : arg9,
            quote_amount         : arg10,
            meme_unallocated     : arg11,
            quote_unallocated    : arg12,
            treasury             : arg13,
            gas_reserve_amount   : arg14,
        };
        0x2::event::emit<RoundPublished>(v0);
    }

    public(friend) fun upgrade_action_cancelled(arg0: 0x1::option::Option<vector<u8>>) {
        let v0 = UpgradeActionCancelled{digest: arg0};
        0x2::event::emit<UpgradeActionCancelled>(v0);
    }

    public(friend) fun upgrade_action_scheduled(arg0: 0x1::option::Option<vector<u8>>, arg1: u64, arg2: u64) {
        let v0 = UpgradeActionScheduled{
            digest      : arg0,
            ready_at_ms : arg1,
            delay_ms    : arg2,
        };
        0x2::event::emit<UpgradeActionScheduled>(v0);
    }

    public(friend) fun upgrade_delay_changed(arg0: u64) {
        let v0 = UpgradeDelayChanged{delay_ms: arg0};
        0x2::event::emit<UpgradeDelayChanged>(v0);
    }

    public(friend) fun upgrade_delay_scheduled(arg0: u64, arg1: u64) {
        let v0 = UpgradeDelayScheduled{
            delay_ms    : arg0,
            ready_at_ms : arg1,
        };
        0x2::event::emit<UpgradeDelayScheduled>(v0);
    }

    public(friend) fun vault_created<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u128, arg6: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::FeeSplit) {
        let v0 = VaultCreated{
            vault_id       : arg0,
            pool_id        : arg1,
            position_id    : arg2,
            venue          : 0x1::type_name::with_original_ids<T2>(),
            meme           : 0x1::type_name::with_original_ids<T0>(),
            quote          : 0x1::type_name::with_original_ids<T1>(),
            residual_meme  : arg3,
            residual_quote : arg4,
            liquidity      : arg5,
            fee_split      : arg6,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

