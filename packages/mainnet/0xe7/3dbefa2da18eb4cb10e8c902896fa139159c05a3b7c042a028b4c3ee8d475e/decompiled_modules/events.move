module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::events {
    struct VaultIssued<phantom T0> has copy, drop {
        treasury_cap_id: 0x2::object::ID,
        metadata_cap_id: 0x2::object::ID,
        vault_policy: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy,
        max_order_notional: u64,
        nav_cap: u64,
    }

    struct VaultInitialized<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        binding: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::Binding,
        seed_amount: u64,
        seed_venue_equity: u64,
        seed_reserve: u64,
        seed_shareholder_nav: u64,
        locked_shares: u64,
        position_base: u64,
        lot_size: u64,
        position_side: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide,
        position_imr: u256,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
    }

    struct OrderFilled<phantom T0> has copy, drop {
        account_object_id: 0x2::object::ID,
        is_ask: bool,
        reduce_only: bool,
        emergency: bool,
        requested_base: u64,
        filled_base: u64,
        filled_quote: u256,
        reference_price: u64,
        executed_price: u64,
    }

    struct Minted<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        deposit: u64,
        shares: u64,
        contribution: u64,
        fee: u64,
        admin_fee: u64,
        reserve_fee: u64,
        reserve_after: u64,
        admin_cash_after: u64,
        supply_after: u64,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
    }

    struct Redeemed<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        shares: u64,
        net: u64,
        fee: u64,
        admin_fee: u64,
        reserve_fee: u64,
        reserve_after: u64,
        admin_cash_after: u64,
        supply_after: u64,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
    }

    struct Rebalanced<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        equity_before: u64,
        equity_after: u64,
        base_before: u64,
        base_after: u64,
        increase: bool,
        reserve_after: u64,
        admin_cash_after: u64,
        supply_after: u64,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
    }

    struct FundingSettled<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        is_cost: bool,
        raw_amount: u256,
        amount: u64,
        absorbed_by_reserve: u64,
        uncovered_cost: u64,
        restored_to_holders: u64,
        reserve_after: u64,
        previous_checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
    }

    struct CheckpointDrifted<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
    }

    struct Donated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        reserve_after: u64,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
    }

    struct ShutdownBegun<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        reason: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::ShutdownReason,
    }

    struct UnwindProgress<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        before: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
        after: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
        market_orders: u64,
        filled_quote: 0x1::option::Option<u256>,
    }

    struct ShutdownFinalized<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        recovered_cash: u64,
        eligible_supply: u64,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
        unrecoverable_collateral_raw: u256,
    }

    struct ShutdownRedeemed<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        shares: u64,
        cash_paid: u64,
        cash_remaining: u64,
        eligible_remaining: u64,
    }

    struct FeesUpdated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        previous_mint_bps: u64,
        previous_redeem_bps: u64,
        previous_admin_bps: u64,
        mint_bps: u64,
        redeem_bps: u64,
        admin_share_bps: u64,
    }

    struct NavCapUpdated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        previous_nav_cap: u64,
        nav_cap: u64,
    }

    struct MaxOrderNotionalUpdated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        previous: u64,
        max_order_notional: u64,
    }

    struct MetadataUpdated<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
    }

    struct AdminFeesWithdrawn<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        remaining: u64,
    }

    public(friend) fun admin_fees_withdrawn<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = AdminFeesWithdrawn<T0>{
            vault_id  : arg0,
            amount    : arg1,
            remaining : arg2,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<AdminFeesWithdrawn<T0>>(v0);
    }

    public(friend) fun checkpoint_drifted<T0>(arg0: 0x2::object::ID, arg1: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let v0 = CheckpointDrifted<T0>{
            vault_id   : arg0,
            checkpoint : arg1,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<CheckpointDrifted<T0>>(v0);
    }

    public(friend) fun donated<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let v0 = Donated<T0>{
            vault_id      : arg0,
            amount        : arg1,
            reserve_after : arg2,
            checkpoint    : arg3,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<Donated<T0>>(v0);
    }

    public(friend) fun fees_updated<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = FeesUpdated<T0>{
            vault_id            : arg0,
            previous_mint_bps   : arg1,
            previous_redeem_bps : arg2,
            previous_admin_bps  : arg3,
            mint_bps            : arg4,
            redeem_bps          : arg5,
            admin_share_bps     : arg6,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<FeesUpdated<T0>>(v0);
    }

    public(friend) fun funding_settled<T0>(arg0: 0x2::object::ID, arg1: bool, arg2: u256, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg9: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let v0 = FundingSettled<T0>{
            vault_id            : arg0,
            is_cost             : arg1,
            raw_amount          : arg2,
            amount              : arg3,
            absorbed_by_reserve : arg4,
            uncovered_cost      : arg5,
            restored_to_holders : arg6,
            reserve_after       : arg7,
            previous_checkpoint : arg8,
            checkpoint          : arg9,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<FundingSettled<T0>>(v0);
    }

    public(friend) fun max_order_notional_updated<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = MaxOrderNotionalUpdated<T0>{
            vault_id           : arg0,
            previous           : arg1,
            max_order_notional : arg2,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<MaxOrderNotionalUpdated<T0>>(v0);
    }

    public(friend) fun metadata_updated<T0>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = MetadataUpdated<T0>{
            vault_id    : arg0,
            name        : arg1,
            description : arg2,
            icon_url    : arg3,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<MetadataUpdated<T0>>(v0);
    }

    public(friend) fun minted<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let v0 = Minted<T0>{
            vault_id         : arg0,
            deposit          : arg1,
            shares           : arg2,
            contribution     : arg3,
            fee              : arg4,
            admin_fee        : arg5,
            reserve_fee      : arg6,
            reserve_after    : arg7,
            admin_cash_after : arg8,
            supply_after     : arg9,
            checkpoint       : arg10,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<Minted<T0>>(v0);
    }

    public(friend) fun nav_cap_updated<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = NavCapUpdated<T0>{
            vault_id         : arg0,
            previous_nav_cap : arg1,
            nav_cap          : arg2,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<NavCapUpdated<T0>>(v0);
    }

    public(friend) fun order_filled<T0>(arg0: 0x2::object::ID, arg1: bool, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: u256, arg7: u64, arg8: u64) {
        let v0 = OrderFilled<T0>{
            account_object_id : arg0,
            is_ask            : arg1,
            reduce_only       : arg2,
            emergency         : arg3,
            requested_base    : arg4,
            filled_base       : arg5,
            filled_quote      : arg6,
            reference_price   : arg7,
            executed_price    : arg8,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<OrderFilled<T0>>(v0);
    }

    public(friend) fun rebalanced<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let v0 = Rebalanced<T0>{
            vault_id         : arg0,
            equity_before    : arg1,
            equity_after     : arg2,
            base_before      : arg3,
            base_after       : arg4,
            increase         : arg5,
            reserve_after    : arg6,
            admin_cash_after : arg7,
            supply_after     : arg8,
            checkpoint       : arg9,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<Rebalanced<T0>>(v0);
    }

    public(friend) fun redeemed<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let v0 = Redeemed<T0>{
            vault_id         : arg0,
            shares           : arg1,
            net              : arg2,
            fee              : arg3,
            admin_fee        : arg4,
            reserve_fee      : arg5,
            reserve_after    : arg6,
            admin_cash_after : arg7,
            supply_after     : arg8,
            checkpoint       : arg9,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<Redeemed<T0>>(v0);
    }

    public(friend) fun shutdown_begun<T0>(arg0: 0x2::object::ID, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::ShutdownReason) {
        let v0 = ShutdownBegun<T0>{
            vault_id : arg0,
            reason   : arg1,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<ShutdownBegun<T0>>(v0);
    }

    public(friend) fun shutdown_finalized<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg4: u256) {
        let v0 = ShutdownFinalized<T0>{
            vault_id                     : arg0,
            recovered_cash               : arg1,
            eligible_supply              : arg2,
            checkpoint                   : arg3,
            unrecoverable_collateral_raw : arg4,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<ShutdownFinalized<T0>>(v0);
    }

    public(friend) fun shutdown_redeemed<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ShutdownRedeemed<T0>{
            vault_id           : arg0,
            shares             : arg1,
            cash_paid          : arg2,
            cash_remaining     : arg3,
            eligible_remaining : arg4,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<ShutdownRedeemed<T0>>(v0);
    }

    public(friend) fun unwind_progress<T0>(arg0: 0x2::object::ID, arg1: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg2: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint, arg3: u64, arg4: 0x1::option::Option<u256>) {
        let v0 = UnwindProgress<T0>{
            vault_id      : arg0,
            before        : arg1,
            after         : arg2,
            market_orders : arg3,
            filled_quote  : arg4,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<UnwindProgress<T0>>(v0);
    }

    public(friend) fun vault_initialized<T0>(arg0: 0x2::object::ID, arg1: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::Binding, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide, arg10: u256, arg11: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
        let v0 = VaultInitialized<T0>{
            vault_id             : arg0,
            binding              : arg1,
            seed_amount          : arg2,
            seed_venue_equity    : arg3,
            seed_reserve         : arg4,
            seed_shareholder_nav : arg5,
            locked_shares        : arg6,
            position_base        : arg7,
            lot_size             : arg8,
            position_side        : arg9,
            position_imr         : arg10,
            checkpoint           : arg11,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<VaultInitialized<T0>>(v0);
    }

    public(friend) fun vault_issued<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy, arg3: u64, arg4: u64) {
        let v0 = VaultIssued<T0>{
            treasury_cap_id    : arg0,
            metadata_cap_id    : arg1,
            vault_policy       : arg2,
            max_order_notional : arg3,
            nav_cap            : arg4,
        };
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events::emit_event<VaultIssued<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

