module 0x5ecb75df6755448841eacd52012f5841f05565c5019f607f2abd1f16219877cc::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreateVaultEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        meta_coin_type: vector<u8>,
        meta_coin_decimals: u8,
        protocol_fee_share_bps: u16,
    }

    struct DepositEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        meta_coin_type: vector<u8>,
        meta_coin_amount_minted: u64,
        meta_coin_amount_total_supply: u64,
        coin_in_type: vector<u8>,
        coin_in_amount_deposited: u64,
        coin_in_amount_in_vault: u64,
        exchange_rate_meta_to_ref_coin: u128,
        exchange_rate_coin_in_to_ref_coin: u128,
    }

    struct WithdrawEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        meta_coin_type: vector<u8>,
        meta_coin_amount_burned: u64,
        meta_coin_amount_total_supply: u64,
        coin_out_type: vector<u8>,
        coin_out_amount_withdrawn: u64,
        coin_out_amount_in_vault: u64,
        fee_coin_amount: u64,
        exchange_rate_meta_to_ref_coin: u128,
        exchange_rate_coin_in_to_ref_coin: u128,
    }

    struct SwapEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        coin_in_type: vector<u8>,
        coin_in_amount_deposited: u64,
        coin_in_amount_in_vault: u64,
        coin_out_type: vector<u8>,
        coin_out_amount_withdrawn: u64,
        coin_out_amount_in_vault: u64,
        fee_coin_amount: u64,
        exchange_rate_meta_coin_to_coin_in: u128,
        exchange_rate_meta_coin_to_coin_out: u128,
    }

    struct SupportCoinEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        deposit_cap: u64,
        min_priority: u64,
        max_priority: u64,
        from_min_fees: vector<u64>,
        from_max_fees: vector<u64>,
        from_target_fees: vector<u64>,
        to_min_fees: vector<u64>,
        to_max_fees: vector<u64>,
        to_target_fees: vector<u64>,
        decimals: u8,
    }

    struct UpdateFeePairEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        coin_in_type: vector<u8>,
        coin_out_type: vector<u8>,
        new_min_fee: u64,
        new_max_fee: u64,
        new_target_fee: u64,
    }

    struct UpdateFlashLoanFeeEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        new_flash_loan_fee: u64,
    }

    struct AuthorizedAppEventV1 has copy, drop {
        app_id: address,
    }

    struct DeauthorizedAppEventV1 has copy, drop {
        app_id: address,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_authorized_app_event(arg0: &0x2::object::UID) {
        let v0 = AuthorizedAppEventV1{app_id: 0x2::object::uid_to_address(arg0)};
        emit<AuthorizedAppEventV1>(v0);
    }

    public(friend) fun emit_create_vault_event<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: u16) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = CreateVaultEventV1{
            vault_id               : arg0,
            meta_coin_type         : *0x1::ascii::as_bytes(&v0),
            meta_coin_decimals     : arg1,
            protocol_fee_share_bps : arg2,
        };
        emit<CreateVaultEventV1>(v1);
    }

    public(friend) fun emit_deauthorized_app_event(arg0: &0x2::object::UID) {
        let v0 = DeauthorizedAppEventV1{app_id: 0x2::object::uid_to_address(arg0)};
        emit<DeauthorizedAppEventV1>(v0);
    }

    public(friend) fun emit_deposit_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = DepositEventV1{
            vault_id                          : arg0,
            meta_coin_type                    : *0x1::ascii::as_bytes(&v0),
            meta_coin_amount_minted           : arg1,
            meta_coin_amount_total_supply     : arg2,
            coin_in_type                      : *0x1::ascii::as_bytes(&v1),
            coin_in_amount_deposited          : arg3,
            coin_in_amount_in_vault           : arg4,
            exchange_rate_meta_to_ref_coin    : arg5,
            exchange_rate_coin_in_to_ref_coin : arg6,
        };
        emit<DepositEventV1>(v2);
    }

    public(friend) fun emit_support_coin_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: u8) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = SupportCoinEventV1{
            vault_id         : arg0,
            coin_type        : *0x1::ascii::as_bytes(&v0),
            deposit_cap      : arg1,
            min_priority     : arg2,
            max_priority     : arg3,
            from_min_fees    : arg4,
            from_max_fees    : arg5,
            from_target_fees : arg6,
            to_min_fees      : arg7,
            to_max_fees      : arg8,
            to_target_fees   : arg9,
            decimals         : arg10,
        };
        emit<SupportCoinEventV1>(v1);
    }

    public(friend) fun emit_swap_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = SwapEventV1{
            vault_id                            : arg0,
            coin_in_type                        : *0x1::ascii::as_bytes(&v0),
            coin_in_amount_deposited            : arg1,
            coin_in_amount_in_vault             : arg2,
            coin_out_type                       : *0x1::ascii::as_bytes(&v1),
            coin_out_amount_withdrawn           : arg3,
            coin_out_amount_in_vault            : arg4,
            fee_coin_amount                     : arg5,
            exchange_rate_meta_coin_to_coin_in  : arg6,
            exchange_rate_meta_coin_to_coin_out : arg7,
        };
        emit<SwapEventV1>(v2);
    }

    public(friend) fun emit_update_fee_pair_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = UpdateFeePairEventV1{
            vault_id       : arg0,
            coin_in_type   : *0x1::ascii::as_bytes(&v0),
            coin_out_type  : *0x1::ascii::as_bytes(&v1),
            new_min_fee    : arg1,
            new_max_fee    : arg2,
            new_target_fee : arg3,
        };
        emit<UpdateFeePairEventV1>(v2);
    }

    public(friend) fun emit_update_flash_loan_fee_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = UpdateFlashLoanFeeEventV1{
            vault_id           : arg0,
            coin_type          : *0x1::ascii::as_bytes(&v0),
            new_flash_loan_fee : arg1,
        };
        emit<UpdateFlashLoanFeeEventV1>(v1);
    }

    public(friend) fun emit_withdraw_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = WithdrawEventV1{
            vault_id                          : arg0,
            meta_coin_type                    : *0x1::ascii::as_bytes(&v0),
            meta_coin_amount_burned           : arg1,
            meta_coin_amount_total_supply     : arg2,
            coin_out_type                     : *0x1::ascii::as_bytes(&v1),
            coin_out_amount_withdrawn         : arg3,
            coin_out_amount_in_vault          : arg4,
            fee_coin_amount                   : arg5,
            exchange_rate_meta_to_ref_coin    : arg6,
            exchange_rate_coin_in_to_ref_coin : arg7,
        };
        emit<WithdrawEventV1>(v2);
    }

    // decompiled from Move bytecode v7
}

