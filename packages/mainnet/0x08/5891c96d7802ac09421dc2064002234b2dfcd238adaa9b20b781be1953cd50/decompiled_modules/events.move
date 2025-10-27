module 0x85891c96d7802ac09421dc2064002234b2dfcd238adaa9b20b781be1953cd50::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreateVaultEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        lp_coin_type: 0x1::ascii::String,
        lp_coin_decimals: u8,
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

    struct VerifiedExtensionEventV1 has copy, drop {
        extension: 0x1::ascii::String,
    }

    struct UnverifiedExtensionEventV1 has copy, drop {
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

    struct WithdrawFundsFromExtensionEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        extension: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct DepositFundsIntoExtensionEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        extension: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
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

    public(friend) fun emit_admin_deposit_into_extension_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = DepositFundsIntoExtensionEventV1{
            vault_id  : arg0,
            extension : 0x1::type_name::into_string(arg1),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : arg2,
        };
        emit<DepositFundsIntoExtensionEventV1>(v0);
    }

    public(friend) fun emit_admin_withdraw_from_extension_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = WithdrawFundsFromExtensionEventV1{
            vault_id  : arg0,
            extension : 0x1::type_name::into_string(arg1),
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : arg2,
        };
        emit<WithdrawFundsFromExtensionEventV1>(v0);
    }

    public(friend) fun emit_allow_deposits_of_type_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = AllowDepositsOfTypeEventV1{
            vault_id               : arg0,
            lp_coin_type           : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_type              : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            price_feed_storage_id  : arg1,
            staleness_threshold_ms : arg2,
        };
        emit<AllowDepositsOfTypeEventV1>(v0);
    }

    public(friend) fun emit_create_vault_event<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = CreateVaultEventV1{
            vault_id                : arg0,
            lp_coin_type            : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_coin_decimals        : arg1,
            force_withdraw_delay_ms : arg2,
            lock_duration_ms        : arg3,
        };
        emit<CreateVaultEventV1>(v0);
    }

    public(friend) fun emit_deposit_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = DepositEventV1{
            vault_id       : arg0,
            lp_coin_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_coin_amount : arg1,
            coin_in_type   : arg2,
            coin_in_amount : arg3,
        };
        emit<DepositEventV1>(v0);
    }

    public(friend) fun emit_force_withdraw_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ForceWithdrawEventV1{
            vault_id           : arg0,
            withdraw_ticket_id : arg1,
            lp_coin_type       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_coin_amount     : arg2,
            coin_out_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            coin_out_amount    : arg3,
        };
        emit<ForceWithdrawEventV1>(v0);
    }

    public(friend) fun emit_process_pending_withdraw_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ProcessPendingWithdrawEventV1{
            vault_id           : arg0,
            withdraw_ticket_id : arg1,
            lp_coin_type       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_coin_amount     : arg2,
            lp_coin_burnt      : arg3,
            coin_out_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            coin_out_amount    : arg4,
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

    public(friend) fun emit_unverified_extension_event(arg0: 0x1::type_name::TypeName) {
        let v0 = UnverifiedExtensionEventV1{extension: 0x1::type_name::into_string(arg0)};
        emit<UnverifiedExtensionEventV1>(v0);
    }

    public(friend) fun emit_verified_extension_event(arg0: 0x1::type_name::TypeName) {
        let v0 = VerifiedExtensionEventV1{extension: 0x1::type_name::into_string(arg0)};
        emit<VerifiedExtensionEventV1>(v0);
    }

    public(friend) fun emit_withdraw_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = WithdrawEventV1{
            vault_id           : arg0,
            withdraw_ticket_id : arg1,
            lp_coin_type       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            lp_coin_amount     : arg2,
            lp_coin_burnt      : arg3,
            coin_out_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            coin_out_amount    : arg4,
        };
        emit<WithdrawEventV1>(v0);
    }

    // decompiled from Move bytecode v6
}

