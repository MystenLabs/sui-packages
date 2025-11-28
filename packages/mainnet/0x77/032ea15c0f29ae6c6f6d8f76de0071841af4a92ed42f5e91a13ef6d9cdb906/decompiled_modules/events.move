module 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::events {
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

