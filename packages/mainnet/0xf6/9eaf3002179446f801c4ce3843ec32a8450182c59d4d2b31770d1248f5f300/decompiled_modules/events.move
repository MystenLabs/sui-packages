module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::events {
    struct LaunchEvent has copy, drop {
        token_type: 0x1::ascii::String,
        creator: address,
        vault_id: 0x2::object::ID,
        bonding_curve_id: 0x2::object::ID,
        total_supply: u64,
        bonding_curve_tax_bps: u16,
        post_graduation_tax_bps: u16,
        graduation_market_cap_sui: u64,
        payout_kind: u8,
        distribution_interval_hours: u16,
        launched_at_ms: u64,
    }

    struct AccrualEvent has copy, drop {
        token_type: 0x1::ascii::String,
        delta_payout: u64,
        delta_lp_token: u64,
        new_payout_balance: u64,
        accrued_at_ms: u64,
    }

    struct DistributionEvent has copy, drop {
        token_type: 0x1::ascii::String,
        holders: vector<address>,
        amounts: vector<u64>,
        total: u64,
        snapshot_at_ms: u64,
        distributed_at_ms: u64,
    }

    struct RegistryPauseChanged has copy, drop {
        paused: bool,
        changed_at_ms: u64,
    }

    struct BondingCurveSwapEvent has copy, drop {
        token_type: 0x1::ascii::String,
        trader: address,
        is_buy: bool,
        sui_in_or_out: u64,
        t_out_or_in: u64,
        tax_sui: u64,
        new_real_sui: u64,
        new_real_t: u64,
        swapped_at_ms: u64,
    }

    struct GraduationEvent has copy, drop {
        token_type: 0x1::ascii::String,
        cetus_pool_id: 0x2::object::ID,
        cetus_partner_id: 0x2::object::ID,
        sui_seeded: u64,
        t_seeded: u64,
        graduated_at_ms: u64,
    }

    public(friend) fun emit_accrual(arg0: AccrualEvent) {
        0x2::event::emit<AccrualEvent>(arg0);
    }

    public(friend) fun emit_bc_swap(arg0: BondingCurveSwapEvent) {
        0x2::event::emit<BondingCurveSwapEvent>(arg0);
    }

    public(friend) fun emit_distribution(arg0: DistributionEvent) {
        0x2::event::emit<DistributionEvent>(arg0);
    }

    public(friend) fun emit_graduation(arg0: GraduationEvent) {
        0x2::event::emit<GraduationEvent>(arg0);
    }

    public(friend) fun emit_launch(arg0: LaunchEvent) {
        0x2::event::emit<LaunchEvent>(arg0);
    }

    public(friend) fun emit_pause(arg0: RegistryPauseChanged) {
        0x2::event::emit<RegistryPauseChanged>(arg0);
    }

    public(friend) fun new_accrual_event(arg0: 0x1::ascii::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : AccrualEvent {
        AccrualEvent{
            token_type         : arg0,
            delta_payout       : arg1,
            delta_lp_token     : arg2,
            new_payout_balance : arg3,
            accrued_at_ms      : arg4,
        }
    }

    public(friend) fun new_bc_swap_event(arg0: 0x1::ascii::String, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : BondingCurveSwapEvent {
        BondingCurveSwapEvent{
            token_type    : arg0,
            trader        : arg1,
            is_buy        : arg2,
            sui_in_or_out : arg3,
            t_out_or_in   : arg4,
            tax_sui       : arg5,
            new_real_sui  : arg6,
            new_real_t    : arg7,
            swapped_at_ms : arg8,
        }
    }

    public(friend) fun new_distribution_event(arg0: 0x1::ascii::String, arg1: vector<address>, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u64) : DistributionEvent {
        DistributionEvent{
            token_type        : arg0,
            holders           : arg1,
            amounts           : arg2,
            total             : arg3,
            snapshot_at_ms    : arg4,
            distributed_at_ms : arg5,
        }
    }

    public(friend) fun new_graduation_event(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) : GraduationEvent {
        GraduationEvent{
            token_type       : arg0,
            cetus_pool_id    : arg1,
            cetus_partner_id : arg2,
            sui_seeded       : arg3,
            t_seeded         : arg4,
            graduated_at_ms  : arg5,
        }
    }

    public(friend) fun new_launch_event(arg0: 0x1::ascii::String, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u16, arg7: u64, arg8: u8, arg9: u16, arg10: u64) : LaunchEvent {
        LaunchEvent{
            token_type                  : arg0,
            creator                     : arg1,
            vault_id                    : arg2,
            bonding_curve_id            : arg3,
            total_supply                : arg4,
            bonding_curve_tax_bps       : arg5,
            post_graduation_tax_bps     : arg6,
            graduation_market_cap_sui   : arg7,
            payout_kind                 : arg8,
            distribution_interval_hours : arg9,
            launched_at_ms              : arg10,
        }
    }

    public(friend) fun new_pause_event(arg0: bool, arg1: u64) : RegistryPauseChanged {
        RegistryPauseChanged{
            paused        : arg0,
            changed_at_ms : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

