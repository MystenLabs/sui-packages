module 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreateVaultEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        lp_coin_decimals: u64,
        force_withdraw_delay_ms: u64,
        lock_duration_ms: u64,
    }

    struct AllowDepositsOfTypeEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        price_feed_storage_id: 0x2::object::ID,
        staleness_threshold_ms: u64,
    }

    struct WhitelistedExtensionEventV1 has copy, drop {
        extension: 0x1::ascii::String,
    }

    struct UnwhitelistedExtensionEventV1 has copy, drop {
        extension: 0x1::ascii::String,
    }

    struct AddExtensionEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        extension: 0x1::ascii::String,
    }

    struct RemoveExtensionEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        extension: 0x1::ascii::String,
    }

    struct SetFeesEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        performance_fee_bps: u64,
        management_fee_bps: u64,
        withdrawal_fee_bps: u64,
    }

    struct SetFeeEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        type: 0x1::ascii::String,
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct PauseVaultEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UnpauseVaultEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct WithdrawFromExtensionEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        extension: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct DepositIntoExtensionEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        extension: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct SwapEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        coin_in_type: 0x1::ascii::String,
        coin_in_amount: u64,
        coin_out_type: 0x1::ascii::String,
        coin_out_amount: u64,
    }

    struct DepositEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        lp_coin_amount: u64,
        coin_in_type: 0x1::ascii::String,
        coin_in_amount: u64,
    }

    struct CreateDepositTicketEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_ticket_id: 0x2::object::ID,
        coin_in_type: 0x1::ascii::String,
        coin_in_amount: u64,
    }

    struct ProcessPendingDepositEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        recipient: address,
    }

    struct CancelDepositTicketEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
    }

    struct CreateWithdrawTicketEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        lp_coin_amount: u64,
        coin_out_type: 0x1::ascii::String,
    }

    struct CancelWithdrawTicketEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
    }

    struct WithdrawEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        withdraw_ticket_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        lp_coin_amount: u64,
        lp_coin_burnt: u64,
        coin_out_type: 0x1::ascii::String,
        coin_out_amount: u64,
    }

    struct ProcessPendingWithdrawEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        withdraw_ticket_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        lp_coin_amount: u64,
        lp_coin_burnt: u64,
        coin_out_type: 0x1::ascii::String,
        coin_out_amount: u64,
    }

    struct ForceWithdrawEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        withdraw_ticket_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        lp_coin_amount: u64,
        coin_out_type: 0x1::ascii::String,
        coin_out_amount: u64,
    }

    struct AddProfitEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct UnlockProfitEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_add_extension_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName) {
        let v0 = AddExtensionEventV1{
            vault_id  : arg0,
            extension : 0x1::type_name::into_string(arg1),
        };
        emit<AddExtensionEventV1>(v0);
    }

    public(friend) fun emit_add_profit_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = AddProfitEventV1{
            vault_id  : arg0,
            coin_type : 0x1::type_name::into_string(arg1),
            amount    : arg2,
        };
        emit<AddProfitEventV1>(v0);
    }

    public(friend) fun emit_allow_deposits_of_type_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = AllowDepositsOfTypeEventV1{
            vault_id               : arg0,
            lp_coin_type           : 0x1::type_name::into_string(arg1),
            coin_type              : 0x1::type_name::into_string(arg2),
            price_feed_storage_id  : arg3,
            staleness_threshold_ms : arg4,
        };
        emit<AllowDepositsOfTypeEventV1>(v0);
    }

    public(friend) fun emit_cancel_deposit_ticket_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CancelDepositTicketEventV1{
            vault_id  : arg0,
            ticket_id : arg1,
        };
        emit<CancelDepositTicketEventV1>(v0);
    }

    public(friend) fun emit_cancel_withdraw_ticket_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CancelWithdrawTicketEventV1{
            vault_id  : arg0,
            ticket_id : arg1,
        };
        emit<CancelWithdrawTicketEventV1>(v0);
    }

    public(friend) fun emit_create_deposit_ticket_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = CreateDepositTicketEventV1{
            vault_id          : arg0,
            deposit_ticket_id : arg1,
            coin_in_type      : 0x1::type_name::into_string(arg2),
            coin_in_amount    : arg3,
        };
        emit<CreateDepositTicketEventV1>(v0);
    }

    public(friend) fun emit_create_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = CreateVaultEventV1{
            vault_id                : arg0,
            state_id                : arg1,
            lp_coin_type            : 0x1::type_name::into_string(arg2),
            lp_coin_decimals        : arg3,
            force_withdraw_delay_ms : arg4,
            lock_duration_ms        : arg5,
        };
        emit<CreateVaultEventV1>(v0);
    }

    public(friend) fun emit_create_withdraw_ticket_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName) {
        let v0 = CreateWithdrawTicketEventV1{
            vault_id       : arg0,
            ticket_id      : arg1,
            lp_coin_type   : 0x1::type_name::into_string(arg2),
            lp_coin_amount : arg3,
            coin_out_type  : 0x1::type_name::into_string(arg4),
        };
        emit<CreateWithdrawTicketEventV1>(v0);
    }

    public(friend) fun emit_deposit_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64) {
        let v0 = DepositEventV1{
            vault_id       : arg0,
            lp_coin_type   : 0x1::type_name::into_string(arg1),
            lp_coin_amount : arg2,
            coin_in_type   : 0x1::type_name::into_string(arg3),
            coin_in_amount : arg4,
        };
        emit<DepositEventV1>(v0);
    }

    public(friend) fun emit_deposit_into_extension_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = DepositIntoExtensionEventV1{
            vault_id  : arg0,
            extension : 0x1::type_name::into_string(arg1),
            coin_type : 0x1::type_name::into_string(arg2),
            amount    : arg3,
        };
        emit<DepositIntoExtensionEventV1>(v0);
    }

    public(friend) fun emit_force_withdraw_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = ForceWithdrawEventV1{
            vault_id           : arg0,
            withdraw_ticket_id : arg1,
            lp_coin_type       : 0x1::type_name::into_string(arg2),
            lp_coin_amount     : arg3,
            coin_out_type      : 0x1::type_name::into_string(arg4),
            coin_out_amount    : arg5,
        };
        emit<ForceWithdrawEventV1>(v0);
    }

    public(friend) fun emit_pause_vault_event(arg0: 0x2::object::ID) {
        let v0 = PauseVaultEventV1{vault_id: arg0};
        emit<PauseVaultEventV1>(v0);
    }

    public(friend) fun emit_process_pending_deposit_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = ProcessPendingDepositEventV1{
            vault_id  : arg0,
            ticket_id : arg1,
            recipient : arg2,
        };
        emit<ProcessPendingDepositEventV1>(v0);
    }

    public(friend) fun emit_process_pending_withdraw_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64) {
        let v0 = ProcessPendingWithdrawEventV1{
            vault_id           : arg0,
            withdraw_ticket_id : arg1,
            lp_coin_type       : 0x1::type_name::into_string(arg2),
            lp_coin_amount     : arg3,
            lp_coin_burnt      : arg4,
            coin_out_type      : 0x1::type_name::into_string(arg5),
            coin_out_amount    : arg6,
        };
        emit<ProcessPendingWithdrawEventV1>(v0);
    }

    public(friend) fun emit_remove_extension_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName) {
        let v0 = RemoveExtensionEventV1{
            vault_id  : arg0,
            extension : 0x1::type_name::into_string(arg1),
        };
        emit<RemoveExtensionEventV1>(v0);
    }

    public(friend) fun emit_set_fee_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = SetFeeEventV1{
            vault_id    : arg0,
            type        : arg1,
            old_fee_bps : arg2,
            new_fee_bps : arg3,
        };
        emit<SetFeeEventV1>(v0);
    }

    public(friend) fun emit_set_fees_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = SetFeesEventV1{
            vault_id            : arg0,
            performance_fee_bps : arg1,
            management_fee_bps  : arg2,
            withdrawal_fee_bps  : arg3,
        };
        emit<SetFeesEventV1>(v0);
    }

    public(friend) fun emit_swap_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64) {
        let v0 = SwapEventV1{
            vault_id        : arg0,
            coin_in_type    : 0x1::type_name::into_string(arg1),
            coin_in_amount  : arg2,
            coin_out_type   : 0x1::type_name::into_string(arg3),
            coin_out_amount : arg4,
        };
        emit<SwapEventV1>(v0);
    }

    public(friend) fun emit_unlock_profit_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = UnlockProfitEventV1{
            vault_id  : arg0,
            coin_type : 0x1::type_name::into_string(arg1),
            amount    : arg2,
        };
        emit<UnlockProfitEventV1>(v0);
    }

    public(friend) fun emit_unpause_vault_event(arg0: 0x2::object::ID) {
        let v0 = UnpauseVaultEventV1{vault_id: arg0};
        emit<UnpauseVaultEventV1>(v0);
    }

    public(friend) fun emit_unwhitelisted_extension_event(arg0: 0x1::type_name::TypeName) {
        let v0 = UnwhitelistedExtensionEventV1{extension: 0x1::type_name::into_string(arg0)};
        emit<UnwhitelistedExtensionEventV1>(v0);
    }

    public(friend) fun emit_whitelisted_extension_event(arg0: 0x1::type_name::TypeName) {
        let v0 = WhitelistedExtensionEventV1{extension: 0x1::type_name::into_string(arg0)};
        emit<WhitelistedExtensionEventV1>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64) {
        let v0 = WithdrawEventV1{
            vault_id           : arg0,
            withdraw_ticket_id : arg1,
            lp_coin_type       : 0x1::type_name::into_string(arg2),
            lp_coin_amount     : arg3,
            lp_coin_burnt      : arg4,
            coin_out_type      : 0x1::type_name::into_string(arg5),
            coin_out_amount    : arg6,
        };
        emit<WithdrawEventV1>(v0);
    }

    public(friend) fun emit_withdraw_from_extension_event(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = WithdrawFromExtensionEventV1{
            vault_id  : arg0,
            extension : 0x1::type_name::into_string(arg1),
            coin_type : 0x1::type_name::into_string(arg2),
            amount    : arg3,
        };
        emit<WithdrawFromExtensionEventV1>(v0);
    }

    // decompiled from Move bytecode v6
}

