module 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::events {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timelock_duration_secs: u64,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        user: address,
        token: 0x1::ascii::String,
        gross_amount: u64,
        fee: u64,
        net_amount: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        token: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        user: address,
        token: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct GasDepositEvent has copy, drop {
        user: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct GasWithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct GasDeductedEvent has copy, drop {
        user: address,
        operation: 0x1::ascii::String,
        amount: u64,
        remaining: u64,
        timestamp: u64,
    }

    struct GasReservedEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct GasReleasedEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct OpenPositionEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        amount_a: u64,
        amount_b: u64,
        timestamp: u64,
    }

    struct ClosePositionEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        returned_a: u64,
        returned_b: u64,
        yield_fee_a: u64,
        yield_fee_b: u64,
        timestamp: u64,
    }

    struct LimitOrderCreatedEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        token: 0x1::ascii::String,
        amount: u64,
        target_bin_id: u32,
        side: u8,
        reserved_gas: u64,
        timestamp: u64,
    }

    struct LimitOrderFilledEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        input_token: 0x1::ascii::String,
        output_token: 0x1::ascii::String,
        input_amount: u64,
        output_amount: u64,
        fee: u64,
        timestamp: u64,
    }

    struct LimitOrderCancelledEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        returned_amount: u64,
        timestamp: u64,
    }

    struct LendingDepositEvent has copy, drop {
        user: address,
        protocol: u8,
        token: 0x1::ascii::String,
        amount: u64,
        shares_minted: u64,
        timestamp: u64,
    }

    struct LendingWithdrawEvent has copy, drop {
        user: address,
        protocol: u8,
        token: 0x1::ascii::String,
        amount: u64,
        shares_burned: u64,
        yield_earned: u64,
        yield_fee: u64,
        timestamp: u64,
    }

    struct ActionProposedEvent has copy, drop {
        nonce: u64,
        action_type: u8,
        executable_at: u64,
        timestamp: u64,
    }

    struct ActionExecutedEvent has copy, drop {
        nonce: u64,
        action_type: u8,
        timestamp: u64,
    }

    struct ActionCancelledEvent has copy, drop {
        nonce: u64,
        timestamp: u64,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
        timestamp: u64,
    }

    struct OperatorAddedEvent has copy, drop {
        operator: address,
        timestamp: u64,
    }

    struct OperatorRemovedEvent has copy, drop {
        operator: address,
        timestamp: u64,
    }

    struct FeesCollectedEvent has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct OperatorGasCollectedEvent has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct ForceCloseEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        gas_refunded: u64,
        timestamp: u64,
    }

    struct MaxLockUpdatedEvent has copy, drop {
        user: address,
        token: 0x1::ascii::String,
        new_max: u64,
        timestamp: u64,
    }

    struct RebalanceEvent has copy, drop {
        user: address,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct CompoundEvent has copy, drop {
        user: address,
        position_id: 0x2::object::ID,
        compounded_a: u64,
        compounded_b: u64,
        timestamp: u64,
    }

    struct MigrateLendingEvent has copy, drop {
        user: address,
        from_protocol: u8,
        to_protocol: u8,
        token: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct DustSweptEvent has copy, drop {
        user: address,
        token: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    public(friend) fun emit_action_cancelled(arg0: u64, arg1: u64) {
        let v0 = ActionCancelledEvent{
            nonce     : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<ActionCancelledEvent>(v0);
    }

    public(friend) fun emit_action_executed(arg0: u64, arg1: u8, arg2: u64) {
        let v0 = ActionExecutedEvent{
            nonce       : arg0,
            action_type : arg1,
            timestamp   : arg2,
        };
        0x2::event::emit<ActionExecutedEvent>(v0);
    }

    public(friend) fun emit_action_proposed(arg0: u64, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = ActionProposedEvent{
            nonce         : arg0,
            action_type   : arg1,
            executable_at : arg2,
            timestamp     : arg3,
        };
        0x2::event::emit<ActionProposedEvent>(v0);
    }

    public(friend) fun emit_close_position(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = ClosePositionEvent{
            user        : arg0,
            position_id : arg1,
            returned_a  : arg2,
            returned_b  : arg3,
            yield_fee_a : arg4,
            yield_fee_b : arg5,
            timestamp   : arg6,
        };
        0x2::event::emit<ClosePositionEvent>(v0);
    }

    public(friend) fun emit_compound(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CompoundEvent{
            user         : arg0,
            position_id  : arg1,
            compounded_a : arg2,
            compounded_b : arg3,
            timestamp    : arg4,
        };
        0x2::event::emit<CompoundEvent>(v0);
    }

    public(friend) fun emit_deposit(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = DepositEvent{
            user         : arg0,
            token        : arg1,
            gross_amount : arg2,
            fee          : arg3,
            net_amount   : arg4,
            timestamp    : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_dust_swept(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = DustSweptEvent{
            user      : arg0,
            token     : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<DustSweptEvent>(v0);
    }

    public(friend) fun emit_emergency_withdraw(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = EmergencyWithdrawEvent{
            user      : arg0,
            token     : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v0);
    }

    public(friend) fun emit_fees_collected(arg0: 0x1::ascii::String, arg1: u64, arg2: address, arg3: u64) {
        let v0 = FeesCollectedEvent{
            token     : arg0,
            amount    : arg1,
            recipient : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<FeesCollectedEvent>(v0);
    }

    public(friend) fun emit_force_close(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ForceCloseEvent{
            user         : arg0,
            position_id  : arg1,
            gas_refunded : arg2,
            timestamp    : arg3,
        };
        0x2::event::emit<ForceCloseEvent>(v0);
    }

    public(friend) fun emit_gas_deducted(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = GasDeductedEvent{
            user      : arg0,
            operation : arg1,
            amount    : arg2,
            remaining : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<GasDeductedEvent>(v0);
    }

    public(friend) fun emit_gas_deposit(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = GasDepositEvent{
            user        : arg0,
            amount      : arg1,
            new_balance : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<GasDepositEvent>(v0);
    }

    public(friend) fun emit_gas_released(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = GasReleasedEvent{
            user        : arg0,
            position_id : arg1,
            amount      : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<GasReleasedEvent>(v0);
    }

    public(friend) fun emit_gas_reserved(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = GasReservedEvent{
            user        : arg0,
            position_id : arg1,
            amount      : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<GasReservedEvent>(v0);
    }

    public(friend) fun emit_gas_withdraw(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = GasWithdrawEvent{
            user        : arg0,
            amount      : arg1,
            new_balance : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<GasWithdrawEvent>(v0);
    }

    public(friend) fun emit_lending_deposit(arg0: address, arg1: u8, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LendingDepositEvent{
            user          : arg0,
            protocol      : arg1,
            token         : arg2,
            amount        : arg3,
            shares_minted : arg4,
            timestamp     : arg5,
        };
        0x2::event::emit<LendingDepositEvent>(v0);
    }

    public(friend) fun emit_lending_withdraw(arg0: address, arg1: u8, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = LendingWithdrawEvent{
            user          : arg0,
            protocol      : arg1,
            token         : arg2,
            amount        : arg3,
            shares_burned : arg4,
            yield_earned  : arg5,
            yield_fee     : arg6,
            timestamp     : arg7,
        };
        0x2::event::emit<LendingWithdrawEvent>(v0);
    }

    public(friend) fun emit_limit_order_cancelled(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = LimitOrderCancelledEvent{
            user            : arg0,
            position_id     : arg1,
            returned_amount : arg2,
            timestamp       : arg3,
        };
        0x2::event::emit<LimitOrderCancelledEvent>(v0);
    }

    public(friend) fun emit_limit_order_created(arg0: address, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: u64, arg4: u32, arg5: u8, arg6: u64, arg7: u64) {
        let v0 = LimitOrderCreatedEvent{
            user          : arg0,
            position_id   : arg1,
            token         : arg2,
            amount        : arg3,
            target_bin_id : arg4,
            side          : arg5,
            reserved_gas  : arg6,
            timestamp     : arg7,
        };
        0x2::event::emit<LimitOrderCreatedEvent>(v0);
    }

    public(friend) fun emit_limit_order_filled(arg0: address, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = LimitOrderFilledEvent{
            user          : arg0,
            position_id   : arg1,
            input_token   : arg2,
            output_token  : arg3,
            input_amount  : arg4,
            output_amount : arg5,
            fee           : arg6,
            timestamp     : arg7,
        };
        0x2::event::emit<LimitOrderFilledEvent>(v0);
    }

    public(friend) fun emit_max_lock_updated(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = MaxLockUpdatedEvent{
            user      : arg0,
            token     : arg1,
            new_max   : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<MaxLockUpdatedEvent>(v0);
    }

    public(friend) fun emit_migrate_lending(arg0: address, arg1: u8, arg2: u8, arg3: 0x1::ascii::String, arg4: u64, arg5: u64) {
        let v0 = MigrateLendingEvent{
            user          : arg0,
            from_protocol : arg1,
            to_protocol   : arg2,
            token         : arg3,
            amount        : arg4,
            timestamp     : arg5,
        };
        0x2::event::emit<MigrateLendingEvent>(v0);
    }

    public(friend) fun emit_open_position(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = OpenPositionEvent{
            user        : arg0,
            position_id : arg1,
            pool_id     : arg2,
            token_a     : arg3,
            token_b     : arg4,
            amount_a    : arg5,
            amount_b    : arg6,
            timestamp   : arg7,
        };
        0x2::event::emit<OpenPositionEvent>(v0);
    }

    public(friend) fun emit_operator_added(arg0: address, arg1: u64) {
        let v0 = OperatorAddedEvent{
            operator  : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<OperatorAddedEvent>(v0);
    }

    public(friend) fun emit_operator_gas_collected(arg0: u64, arg1: address, arg2: u64) {
        let v0 = OperatorGasCollectedEvent{
            amount    : arg0,
            recipient : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<OperatorGasCollectedEvent>(v0);
    }

    public(friend) fun emit_operator_removed(arg0: address, arg1: u64) {
        let v0 = OperatorRemovedEvent{
            operator  : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<OperatorRemovedEvent>(v0);
    }

    public(friend) fun emit_pause(arg0: bool, arg1: u64) {
        let v0 = PauseEvent{
            paused    : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public(friend) fun emit_rebalance(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = RebalanceEvent{
            user            : arg0,
            old_position_id : arg1,
            new_position_id : arg2,
            timestamp       : arg3,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public(friend) fun emit_vault_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = VaultCreatedEvent{
            vault_id               : arg0,
            admin                  : arg1,
            timelock_duration_secs : arg2,
            timestamp              : arg3,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public(friend) fun emit_withdraw(arg0: address, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = WithdrawEvent{
            user      : arg0,
            token     : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

