module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal {
    struct LegSpec has copy, drop, store {
        router: address,
        input_type: 0x1::type_name::TypeName,
        output_type: 0x1::type_name::TypeName,
        amount_in: u64,
        min_amount_out: u64,
        notional_usd_micro: u64,
    }

    struct ApprovedRebalancePlan has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        methodology_hash: vector<u8>,
        proposal_id: u64,
        target_weights_hash: vector<u8>,
        max_slippage_bps: u64,
        expires_at_ms: u64,
        operator: address,
        legs: vector<LegSpec>,
    }

    struct RebalanceTicket {
        vault_id: 0x2::object::ID,
        methodology_hash: vector<u8>,
        proposal_id: u64,
        target_weights_hash: vector<u8>,
        max_slippage_bps: u64,
        expires_at_ms: u64,
        expected_legs: u16,
        legs_executed: u16,
        notional_executed_usd_micro: u64,
        planned_legs: vector<LegSpec>,
    }

    struct SettleReceipt {
        vault_id: 0x2::object::ID,
        methodology_hash: vector<u8>,
        proposal_id: u64,
        target_weights_hash: vector<u8>,
        legs_executed: u16,
        notional_executed_usd_micro: u64,
    }

    public fun approve_plan(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<LegSpec>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : ApprovedRebalancePlan {
        assert!(!0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::is_paused(arg0), 1);
        assert!(0x2::clock::timestamp_ms(arg8) < arg6, 10);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 11);
        assert!(arg5 <= (0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::max_leg_slippage_bps(arg0) as u64), 11);
        let v0 = 0x1::vector::length<LegSpec>(&arg7);
        assert!(v0 > 0, 28);
        assert!(v0 <= (256 as u64), 11);
        ApprovedRebalancePlan{
            id                  : 0x2::object::new(arg9),
            registry_id         : 0x2::object::id<0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry>(arg0),
            vault_id            : arg2,
            methodology_hash    : 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::methodology_hash(arg0),
            proposal_id         : arg3,
            target_weights_hash : arg4,
            max_slippage_bps    : arg5,
            expires_at_ms       : arg6,
            operator            : 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::operator(arg0),
            legs                : arg7,
        }
    }

    public(friend) fun begin(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::OperatorCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : RebalanceTicket {
        assert!(!0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::is_paused(arg0), 1);
        assert!(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::methodology_hash(arg0) == arg3, 6);
        assert!(0x2::clock::timestamp_ms(arg9) < arg8, 10);
        assert!(arg6 <= (0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::max_leg_slippage_bps(arg0) as u64), 11);
        assert!(0x2::tx_context::sender(arg10) == 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::operator(arg0), 11);
        assert!(arg7 <= 256, 11);
        RebalanceTicket{
            vault_id                    : arg2,
            methodology_hash            : arg3,
            proposal_id                 : arg4,
            target_weights_hash         : arg5,
            max_slippage_bps            : arg6,
            expires_at_ms               : arg8,
            expected_legs               : arg7,
            legs_executed               : 0,
            notional_executed_usd_micro : 0,
            planned_legs                : 0x1::vector::empty<LegSpec>(),
        }
    }

    public fun begin_with_plan(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::OperatorCap, arg2: ApprovedRebalancePlan, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : RebalanceTicket {
        let ApprovedRebalancePlan {
            id                  : v0,
            registry_id         : v1,
            vault_id            : v2,
            methodology_hash    : v3,
            proposal_id         : v4,
            target_weights_hash : v5,
            max_slippage_bps    : v6,
            expires_at_ms       : v7,
            operator            : v8,
            legs                : v9,
        } = arg2;
        let v10 = v9;
        0x2::object::delete(v0);
        assert!(0x2::object::id<0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry>(arg0) == v1, 27);
        assert!(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::methodology_hash(arg0) == v3, 6);
        assert!(v8 == 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::operator(arg0), 27);
        assert!(0x2::tx_context::sender(arg4) == v8, 11);
        assert!(!0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::is_paused(arg0), 1);
        assert!(0x2::clock::timestamp_ms(arg3) < v7, 10);
        let v11 = (0x1::vector::length<LegSpec>(&v10) as u16);
        assert!(v11 > 0, 28);
        assert!(v11 <= 256, 11);
        RebalanceTicket{
            vault_id                    : v2,
            methodology_hash            : v3,
            proposal_id                 : v4,
            target_weights_hash         : v5,
            max_slippage_bps            : v6,
            expires_at_ms               : v7,
            expected_legs               : v11,
            legs_executed               : 0,
            notional_executed_usd_micro : 0,
            planned_legs                : v10,
        }
    }

    public(friend) fun consume_next_planned_leg<T0, T1>(arg0: &mut RebalanceTicket, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.expires_at_ms, 10);
        assert!(arg0.legs_executed < arg0.expected_legs, 15);
        assert!(0x1::vector::length<LegSpec>(&arg0.planned_legs) > 0, 27);
        let v0 = 0x1::vector::borrow<LegSpec>(&arg0.planned_legs, (arg0.legs_executed as u64));
        assert!(v0.router == arg1, 27);
        assert!(v0.input_type == 0x1::type_name::with_defining_ids<T0>(), 27);
        assert!(v0.output_type == 0x1::type_name::with_defining_ids<T1>(), 27);
        assert!(v0.amount_in == arg2, 27);
        assert!(v0.min_amount_out == arg3, 27);
        assert!(v0.notional_usd_micro == arg4, 27);
        arg0.legs_executed = arg0.legs_executed + 1;
        arg0.notional_executed_usd_micro = arg0.notional_executed_usd_micro + arg4;
    }

    public(friend) fun into_receipt_parts(arg0: SettleReceipt) : (0x2::object::ID, vector<u8>, u64, vector<u8>, u16, u64) {
        let SettleReceipt {
            vault_id                    : v0,
            methodology_hash            : v1,
            proposal_id                 : v2,
            target_weights_hash         : v3,
            legs_executed               : v4,
            notional_executed_usd_micro : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    public fun legs_executed(arg0: &SettleReceipt) : u16 {
        arg0.legs_executed
    }

    public fun methodology_hash(arg0: &SettleReceipt) : vector<u8> {
        arg0.methodology_hash
    }

    public fun new_leg_spec<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64) : LegSpec {
        assert!(arg1 > 0, 11);
        assert!(arg2 > 0, 11);
        LegSpec{
            router             : arg0,
            input_type         : 0x1::type_name::with_defining_ids<T0>(),
            output_type        : 0x1::type_name::with_defining_ids<T1>(),
            amount_in          : arg1,
            min_amount_out     : arg2,
            notional_usd_micro : arg3,
        }
    }

    public fun notional_executed_usd_micro(arg0: &SettleReceipt) : u64 {
        arg0.notional_executed_usd_micro
    }

    public fun proposal_id(arg0: &SettleReceipt) : u64 {
        arg0.proposal_id
    }

    public fun receipt_legs_executed(arg0: &SettleReceipt) : u16 {
        arg0.legs_executed
    }

    public fun receipt_methodology_hash(arg0: &SettleReceipt) : vector<u8> {
        arg0.methodology_hash
    }

    public fun receipt_notional_executed_usd_micro(arg0: &SettleReceipt) : u64 {
        arg0.notional_executed_usd_micro
    }

    public fun receipt_proposal_id(arg0: &SettleReceipt) : u64 {
        arg0.proposal_id
    }

    public fun receipt_target_weights_hash(arg0: &SettleReceipt) : vector<u8> {
        arg0.target_weights_hash
    }

    public fun receipt_vault_id(arg0: &SettleReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun record_leg(arg0: &mut RebalanceTicket, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_at_ms, 10);
        assert!(arg0.legs_executed < arg0.expected_legs, 15);
        arg0.legs_executed = arg0.legs_executed + 1;
        arg0.notional_executed_usd_micro = arg0.notional_executed_usd_micro + arg1;
    }

    public fun settle(arg0: RebalanceTicket, arg1: &0x2::clock::Clock) : SettleReceipt {
        let RebalanceTicket {
            vault_id                    : v0,
            methodology_hash            : v1,
            proposal_id                 : v2,
            target_weights_hash         : v3,
            max_slippage_bps            : _,
            expires_at_ms               : v5,
            expected_legs               : v6,
            legs_executed               : v7,
            notional_executed_usd_micro : v8,
            planned_legs                : _,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) < v5, 10);
        assert!(v7 == v6, 26);
        SettleReceipt{
            vault_id                    : v0,
            methodology_hash            : v1,
            proposal_id                 : v2,
            target_weights_hash         : v3,
            legs_executed               : v7,
            notional_executed_usd_micro : v8,
        }
    }

    public fun target_weights_hash(arg0: &SettleReceipt) : vector<u8> {
        arg0.target_weights_hash
    }

    public fun ticket_expected_legs(arg0: &RebalanceTicket) : u16 {
        arg0.expected_legs
    }

    public fun ticket_expires_at_ms(arg0: &RebalanceTicket) : u64 {
        arg0.expires_at_ms
    }

    public fun ticket_legs_executed(arg0: &RebalanceTicket) : u16 {
        arg0.legs_executed
    }

    public fun ticket_max_slippage_bps(arg0: &RebalanceTicket) : u64 {
        arg0.max_slippage_bps
    }

    public fun ticket_methodology_hash(arg0: &RebalanceTicket) : vector<u8> {
        arg0.methodology_hash
    }

    public fun ticket_proposal_id(arg0: &RebalanceTicket) : u64 {
        arg0.proposal_id
    }

    public fun ticket_target_weights_hash(arg0: &RebalanceTicket) : vector<u8> {
        arg0.target_weights_hash
    }

    public fun ticket_vault_id(arg0: &RebalanceTicket) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun vault_id(arg0: &SettleReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

