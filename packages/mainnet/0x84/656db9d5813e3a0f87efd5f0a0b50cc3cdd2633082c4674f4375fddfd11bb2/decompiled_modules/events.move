module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events {
    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        deposit_coin_type: 0x1::ascii::String,
        share_coin_type: 0x1::ascii::String,
    }

    struct Minted has copy, drop {
        vault_id: 0x2::object::ID,
        minter: address,
        deposit_amount: u64,
        fee_amount: u64,
        shares_minted: u64,
        nav_micro: u64,
        timestamp_ms: u64,
    }

    struct Redeemed has copy, drop {
        vault_id: 0x2::object::ID,
        redeemer: address,
        shares_burned: u64,
        output_amount: u64,
        fee_amount: u64,
        nav_micro: u64,
        timestamp_ms: u64,
    }

    struct PauseChanged has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
        actor: address,
        timestamp_ms: u64,
    }

    struct MethodologyProposed has copy, drop {
        registry_id: 0x2::object::ID,
        next_hash: vector<u8>,
        unlock_ts_ms: u64,
    }

    struct MethodologyApplied has copy, drop {
        registry_id: 0x2::object::ID,
        new_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct OperatorRotated has copy, drop {
        registry_id: 0x2::object::ID,
        old_operator: address,
        new_operator: address,
    }

    struct NavUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        new_nav_micro: u64,
        timestamp_ms: u64,
    }

    struct RouterAdded has copy, drop {
        registry_id: 0x2::object::ID,
        router: address,
    }

    struct RouterRemoved has copy, drop {
        registry_id: 0x2::object::ID,
        router: address,
    }

    struct BasketSeeded has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        timestamp_ms: u64,
    }

    struct VaultLocked has copy, drop {
        vault_id: 0x2::object::ID,
        until_ms: u64,
        locked_by: address,
        timestamp_ms: u64,
    }

    struct VaultUnlocked has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct RebalanceLegStarted has copy, drop {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        router: address,
        input_type: 0x1::ascii::String,
        output_type: 0x1::ascii::String,
        amount_in: u64,
        min_amount_out: u64,
        notional_usd_micro: u64,
        timestamp_ms: u64,
    }

    struct RebalanceLegFinished has copy, drop {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        router: address,
        input_type: 0x1::ascii::String,
        output_type: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        timestamp_ms: u64,
    }

    public(friend) fun emit_basket_seeded(arg0: BasketSeeded) {
        0x2::event::emit<BasketSeeded>(arg0);
    }

    public(friend) fun emit_methodology_applied(arg0: MethodologyApplied) {
        0x2::event::emit<MethodologyApplied>(arg0);
    }

    public(friend) fun emit_methodology_proposed(arg0: MethodologyProposed) {
        0x2::event::emit<MethodologyProposed>(arg0);
    }

    public(friend) fun emit_minted(arg0: Minted) {
        0x2::event::emit<Minted>(arg0);
    }

    public(friend) fun emit_nav_updated(arg0: NavUpdated) {
        0x2::event::emit<NavUpdated>(arg0);
    }

    public(friend) fun emit_operator_rotated(arg0: OperatorRotated) {
        0x2::event::emit<OperatorRotated>(arg0);
    }

    public(friend) fun emit_pause_changed(arg0: PauseChanged) {
        0x2::event::emit<PauseChanged>(arg0);
    }

    public(friend) fun emit_rebalance_leg_finished(arg0: RebalanceLegFinished) {
        0x2::event::emit<RebalanceLegFinished>(arg0);
    }

    public(friend) fun emit_rebalance_leg_started(arg0: RebalanceLegStarted) {
        0x2::event::emit<RebalanceLegStarted>(arg0);
    }

    public(friend) fun emit_redeemed(arg0: Redeemed) {
        0x2::event::emit<Redeemed>(arg0);
    }

    public(friend) fun emit_router_added(arg0: RouterAdded) {
        0x2::event::emit<RouterAdded>(arg0);
    }

    public(friend) fun emit_router_removed(arg0: RouterRemoved) {
        0x2::event::emit<RouterRemoved>(arg0);
    }

    public(friend) fun emit_vault_created(arg0: VaultCreated) {
        0x2::event::emit<VaultCreated>(arg0);
    }

    public(friend) fun emit_vault_locked(arg0: VaultLocked) {
        0x2::event::emit<VaultLocked>(arg0);
    }

    public(friend) fun emit_vault_unlocked(arg0: VaultUnlocked) {
        0x2::event::emit<VaultUnlocked>(arg0);
    }

    public(friend) fun new_basket_seeded(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) : BasketSeeded {
        BasketSeeded{
            vault_id     : arg0,
            coin_type    : arg1,
            amount       : arg2,
            timestamp_ms : arg3,
        }
    }

    public(friend) fun new_methodology_applied(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) : MethodologyApplied {
        MethodologyApplied{
            registry_id  : arg0,
            new_hash     : arg1,
            timestamp_ms : arg2,
        }
    }

    public(friend) fun new_methodology_proposed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) : MethodologyProposed {
        MethodologyProposed{
            registry_id  : arg0,
            next_hash    : arg1,
            unlock_ts_ms : arg2,
        }
    }

    public(friend) fun new_minted(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : Minted {
        Minted{
            vault_id       : arg0,
            minter         : arg1,
            deposit_amount : arg2,
            fee_amount     : arg3,
            shares_minted  : arg4,
            nav_micro      : arg5,
            timestamp_ms   : arg6,
        }
    }

    public(friend) fun new_nav_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) : NavUpdated {
        NavUpdated{
            vault_id      : arg0,
            new_nav_micro : arg1,
            timestamp_ms  : arg2,
        }
    }

    public(friend) fun new_operator_rotated(arg0: 0x2::object::ID, arg1: address, arg2: address) : OperatorRotated {
        OperatorRotated{
            registry_id  : arg0,
            old_operator : arg1,
            new_operator : arg2,
        }
    }

    public(friend) fun new_pause_changed(arg0: 0x2::object::ID, arg1: bool, arg2: address, arg3: u64) : PauseChanged {
        PauseChanged{
            vault_id     : arg0,
            paused       : arg1,
            actor        : arg2,
            timestamp_ms : arg3,
        }
    }

    public(friend) fun new_rebalance_leg_finished(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64, arg6: u64, arg7: u64) : RebalanceLegFinished {
        RebalanceLegFinished{
            vault_id     : arg0,
            proposal_id  : arg1,
            router       : arg2,
            input_type   : arg3,
            output_type  : arg4,
            amount_in    : arg5,
            amount_out   : arg6,
            timestamp_ms : arg7,
        }
    }

    public(friend) fun new_rebalance_leg_started(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : RebalanceLegStarted {
        RebalanceLegStarted{
            vault_id           : arg0,
            proposal_id        : arg1,
            router             : arg2,
            input_type         : arg3,
            output_type        : arg4,
            amount_in          : arg5,
            min_amount_out     : arg6,
            notional_usd_micro : arg7,
            timestamp_ms       : arg8,
        }
    }

    public(friend) fun new_redeemed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : Redeemed {
        Redeemed{
            vault_id      : arg0,
            redeemer      : arg1,
            shares_burned : arg2,
            output_amount : arg3,
            fee_amount    : arg4,
            nav_micro     : arg5,
            timestamp_ms  : arg6,
        }
    }

    public(friend) fun new_router_added(arg0: 0x2::object::ID, arg1: address) : RouterAdded {
        RouterAdded{
            registry_id : arg0,
            router      : arg1,
        }
    }

    public(friend) fun new_router_removed(arg0: 0x2::object::ID, arg1: address) : RouterRemoved {
        RouterRemoved{
            registry_id : arg0,
            router      : arg1,
        }
    }

    public(friend) fun new_vault_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) : VaultCreated {
        VaultCreated{
            vault_id          : arg0,
            registry_id       : arg1,
            deposit_coin_type : arg2,
            share_coin_type   : arg3,
        }
    }

    public(friend) fun new_vault_locked(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) : VaultLocked {
        VaultLocked{
            vault_id     : arg0,
            until_ms     : arg1,
            locked_by    : arg2,
            timestamp_ms : arg3,
        }
    }

    public(friend) fun new_vault_unlocked(arg0: 0x2::object::ID, arg1: u64) : VaultUnlocked {
        VaultUnlocked{
            vault_id     : arg0,
            timestamp_ms : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

