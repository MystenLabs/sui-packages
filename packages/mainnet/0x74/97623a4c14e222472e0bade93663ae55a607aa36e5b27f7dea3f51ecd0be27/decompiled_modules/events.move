module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::events {
    struct Deposit has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        depositor: address,
        paid_in: 0x1::type_name::TypeName,
        amount_paid: u64,
        fee_value: u64,
        value_deposited: u64,
        value_delivered: u64,
        shares_minted: u64,
        shares_at_full_delivery: u64,
        share_price: u64,
        supply_after: u64,
        bought_tokens: vector<0x1::type_name::TypeName>,
        bought_spent: vector<u64>,
        bought_amounts: vector<u64>,
    }

    struct Withdrawal has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        withdrawer: address,
        shares_burned: u64,
        paid_in: 0x1::type_name::TypeName,
        amount_paid: u64,
        fee_paid: u64,
        from_reserve: u64,
        from_sales: u64,
        supply_after: u64,
        sold_tokens: vector<0x1::type_name::TypeName>,
        sold_amounts: vector<u64>,
        sold_received: vector<u64>,
    }

    struct WithdrawalInKind has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        withdrawer: address,
        shares_burned: u64,
        supply_before: u64,
        supply_after: u64,
        taken_tokens: vector<0x1::type_name::TypeName>,
        taken_amounts: vector<u64>,
    }

    struct RebalanceTrade has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        cycle: u64,
        kind: 0x1::string::String,
        sold: 0x1::type_name::TypeName,
        amount_sold: u64,
        bought: 0x1::type_name::TypeName,
        amount_bought: u64,
        minimum_accepted: u64,
        value: u64,
        reserve_wanted: u64,
        reserve_capped: bool,
    }

    struct RebalanceCompleted has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        cycle: u64,
        trades: u64,
        skipped: bool,
        largest_drift_bps: u64,
    }

    struct RebalanceAbandoned has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        cycle: u64,
        trades: u64,
        open_for_ms: u64,
    }

    struct NavUpdated has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        total_value: u64,
        share_supply: u64,
        share_price: u64,
        valued_tokens: vector<0x1::type_name::TypeName>,
        valued_amounts: vector<u64>,
        valued_prices: vector<u64>,
        valued_values: vector<u64>,
    }

    struct StatusChanged has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        from: u8,
        from_name: 0x1::string::String,
        to: u8,
        to_name: 0x1::string::String,
        changed_by: 0x1::string::String,
        reason: 0x1::string::String,
    }

    struct CompositionChanged has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        index_tokens: vector<0x1::type_name::TypeName>,
        index_weights_bps: vector<u64>,
        added: vector<0x1::type_name::TypeName>,
        removed: vector<0x1::type_name::TypeName>,
        weights_only: bool,
        snapshot_blob_id: 0x1::string::String,
    }

    struct FeedBound has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        pair_index: u32,
        previous_pair_index: 0x1::option::Option<u32>,
        token_decimals: u8,
        quote: 0x1::string::String,
    }

    struct ParameterChanged has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        parameter: 0x1::string::String,
        old_value: u64,
        new_value: u64,
    }

    struct FeeCollectorChanged has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        old_collector: address,
        new_collector: address,
    }

    struct DenominationChanged has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        accepted: bool,
        peg_band_bps: u64,
    }

    struct EmergencyExit has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        sold: 0x1::type_name::TypeName,
        amount_sold: u64,
        paid_in: 0x1::type_name::TypeName,
        amount_received: u64,
        minimum_accepted: u64,
    }

    struct Migrated has copy, drop {
        generation: u64,
        vault: 0x2::object::ID,
        from_generation: u64,
        share_supply: u64,
        verified_tokens: vector<0x1::type_name::TypeName>,
        verified_amounts: vector<u64>,
    }

    public(friend) fun composition_changed(arg0: u64, arg1: 0x2::object::ID, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<0x1::type_name::TypeName>, arg5: vector<0x1::type_name::TypeName>, arg6: bool, arg7: 0x1::string::String) {
        let v0 = CompositionChanged{
            generation        : arg0,
            vault             : arg1,
            index_tokens      : arg2,
            index_weights_bps : arg3,
            added             : arg4,
            removed           : arg5,
            weights_only      : arg6,
            snapshot_blob_id  : arg7,
        };
        0x2::event::emit<CompositionChanged>(v0);
    }

    public(friend) fun denomination_changed(arg0: u64, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: u64) {
        let v0 = DenominationChanged{
            generation   : arg0,
            vault        : arg1,
            token        : arg2,
            accepted     : arg3,
            peg_band_bps : arg4,
        };
        0x2::event::emit<DenominationChanged>(v0);
    }

    public(friend) fun deposit(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: vector<0x1::type_name::TypeName>, arg13: vector<u64>, arg14: vector<u64>) {
        let v0 = Deposit{
            generation              : arg0,
            vault                   : arg1,
            depositor               : arg2,
            paid_in                 : arg3,
            amount_paid             : arg4,
            fee_value               : arg5,
            value_deposited         : arg6,
            value_delivered         : arg7,
            shares_minted           : arg8,
            shares_at_full_delivery : arg9,
            share_price             : arg10,
            supply_after            : arg11,
            bought_tokens           : arg12,
            bought_spent            : arg13,
            bought_amounts          : arg14,
        };
        0x2::event::emit<Deposit>(v0);
    }

    public(friend) fun emergency_exit(arg0: u64, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64) {
        let v0 = EmergencyExit{
            generation       : arg0,
            vault            : arg1,
            sold             : arg2,
            amount_sold      : arg3,
            paid_in          : arg4,
            amount_received  : arg5,
            minimum_accepted : arg6,
        };
        0x2::event::emit<EmergencyExit>(v0);
    }

    public(friend) fun fee_collector_changed(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: address) {
        if (arg2 == arg3) {
            return
        };
        let v0 = FeeCollectorChanged{
            generation    : arg0,
            vault         : arg1,
            old_collector : arg2,
            new_collector : arg3,
        };
        0x2::event::emit<FeeCollectorChanged>(v0);
    }

    public(friend) fun feed_bound(arg0: u64, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u32, arg4: 0x1::option::Option<u32>, arg5: u8, arg6: 0x1::string::String) {
        let v0 = FeedBound{
            generation          : arg0,
            vault               : arg1,
            token               : arg2,
            pair_index          : arg3,
            previous_pair_index : arg4,
            token_decimals      : arg5,
            quote               : arg6,
        };
        0x2::event::emit<FeedBound>(v0);
    }

    public(friend) fun migrated(arg0: u64, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: vector<0x1::type_name::TypeName>, arg5: vector<u64>) {
        let v0 = Migrated{
            generation       : arg0,
            vault            : arg1,
            from_generation  : arg2,
            share_supply     : arg3,
            verified_tokens  : arg4,
            verified_amounts : arg5,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) fun nav_updated(arg0: u64, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: vector<0x1::type_name::TypeName>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>) {
        let v0 = NavUpdated{
            generation     : arg0,
            vault          : arg1,
            total_value    : arg2,
            share_supply   : arg3,
            share_price    : arg4,
            valued_tokens  : arg5,
            valued_amounts : arg6,
            valued_prices  : arg7,
            valued_values  : arg8,
        };
        0x2::event::emit<NavUpdated>(v0);
    }

    public(friend) fun parameter_changed(arg0: u64, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64, arg4: u64) {
        if (arg3 == arg4) {
            return
        };
        let v0 = ParameterChanged{
            generation : arg0,
            vault      : arg1,
            parameter  : 0x1::string::utf8(arg2),
            old_value  : arg3,
            new_value  : arg4,
        };
        0x2::event::emit<ParameterChanged>(v0);
    }

    public(friend) fun rebalance_abandoned(arg0: u64, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RebalanceAbandoned{
            generation  : arg0,
            vault       : arg1,
            cycle       : arg2,
            trades      : arg3,
            open_for_ms : arg4,
        };
        0x2::event::emit<RebalanceAbandoned>(v0);
    }

    public(friend) fun rebalance_completed(arg0: u64, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: bool, arg5: u64) {
        let v0 = RebalanceCompleted{
            generation        : arg0,
            vault             : arg1,
            cycle             : arg2,
            trades            : arg3,
            skipped           : arg4,
            largest_drift_bps : arg5,
        };
        0x2::event::emit<RebalanceCompleted>(v0);
    }

    public(friend) fun rebalance_trade(arg0: u64, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x1::type_name::TypeName, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool) {
        let v0 = RebalanceTrade{
            generation       : arg0,
            vault            : arg1,
            cycle            : arg2,
            kind             : arg3,
            sold             : arg4,
            amount_sold      : arg5,
            bought           : arg6,
            amount_bought    : arg7,
            minimum_accepted : arg8,
            value            : arg9,
            reserve_wanted   : arg10,
            reserve_capped   : arg11,
        };
        0x2::event::emit<RebalanceTrade>(v0);
    }

    public(friend) fun status_changed(arg0: u64, arg1: 0x2::object::ID, arg2: u8, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        let v0 = StatusChanged{
            generation : arg0,
            vault      : arg1,
            from       : arg2,
            from_name  : status_name(arg2),
            to         : arg3,
            to_name    : status_name(arg3),
            changed_by : arg4,
            reason     : arg5,
        };
        0x2::event::emit<StatusChanged>(v0);
    }

    public(friend) fun status_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"ACTIVE")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"DEPOSITS_HALTED")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"WITHDRAW_ONLY")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"FROZEN")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"PREPARED")
        } else {
            0x1::string::utf8(b"UNKNOWN")
        }
    }

    public(friend) fun withdrawal(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<0x1::type_name::TypeName>, arg11: vector<u64>, arg12: vector<u64>) {
        let v0 = Withdrawal{
            generation    : arg0,
            vault         : arg1,
            withdrawer    : arg2,
            shares_burned : arg3,
            paid_in       : arg4,
            amount_paid   : arg5,
            fee_paid      : arg6,
            from_reserve  : arg7,
            from_sales    : arg8,
            supply_after  : arg9,
            sold_tokens   : arg10,
            sold_amounts  : arg11,
            sold_received : arg12,
        };
        0x2::event::emit<Withdrawal>(v0);
    }

    public(friend) fun withdrawal_in_kind(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: vector<0x1::type_name::TypeName>, arg7: vector<u64>) {
        let v0 = WithdrawalInKind{
            generation    : arg0,
            vault         : arg1,
            withdrawer    : arg2,
            shares_burned : arg3,
            supply_before : arg4,
            supply_after  : arg5,
            taken_tokens  : arg6,
            taken_amounts : arg7,
        };
        0x2::event::emit<WithdrawalInKind>(v0);
    }

    // decompiled from Move bytecode v7
}

