module 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreateVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        meta_coin_type: vector<u8>,
        meta_coin_decimals: u8,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        meta_coin_type: vector<u8>,
        meta_coin_amount_minted: u64,
        meta_coin_amount_total_supply: u64,
        coin_in_type: vector<u8>,
        coin_in_amount_deposited: u64,
        coin_in_amount_in_vault: u64,
        exchange_rate_meta_coin_to_coin_in: u128,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        meta_coin_type: vector<u8>,
        meta_coin_amount_burned: u64,
        meta_coin_amount_total_supply: u64,
        coin_out_type: vector<u8>,
        coin_out_amount_withdrawn: u64,
        coin_out_amount_in_vault: u64,
        fee_coin_amount: u64,
        exchange_rate_meta_coin_to_coin_out: u128,
    }

    struct SwapEvent has copy, drop {
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

    struct SupportCoinEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        deposit_cap: u64,
        min_fee: u64,
        max_fee: u64,
        priority: u64,
        decimals: u8,
    }

    struct UpdateFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        new_min_fee: u64,
        new_max_fee: u64,
        new_flash_loan_fee: u64,
    }

    struct AuthorizedAppEvent has copy, drop {
        app_id: address,
    }

    struct DeauthorizedAppEvent has copy, drop {
        app_id: address,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_authorized_app_event(arg0: &0x2::object::UID) {
        let v0 = AuthorizedAppEvent{app_id: 0x2::object::uid_to_address(arg0)};
        emit<AuthorizedAppEvent>(v0);
    }

    public(friend) fun emit_create_vault_event<T0>(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = CreateVaultEvent{
            vault_id           : arg0,
            meta_coin_type     : *0x1::ascii::as_bytes(&v0),
            meta_coin_decimals : arg1,
        };
        emit<CreateVaultEvent>(v1);
    }

    public(friend) fun emit_deauthorized_app_event(arg0: &0x2::object::UID) {
        let v0 = DeauthorizedAppEvent{app_id: 0x2::object::uid_to_address(arg0)};
        emit<DeauthorizedAppEvent>(v0);
    }

    public(friend) fun emit_deposit_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = DepositEvent{
            vault_id                           : arg0,
            meta_coin_type                     : *0x1::ascii::as_bytes(&v0),
            meta_coin_amount_minted            : arg1,
            meta_coin_amount_total_supply      : arg2,
            coin_in_type                       : *0x1::ascii::as_bytes(&v1),
            coin_in_amount_deposited           : arg3,
            coin_in_amount_in_vault            : arg4,
            exchange_rate_meta_coin_to_coin_in : arg5,
        };
        emit<DepositEvent>(v2);
    }

    public(friend) fun emit_support_coin_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = SupportCoinEvent{
            vault_id    : arg0,
            coin_type   : *0x1::ascii::as_bytes(&v0),
            deposit_cap : arg1,
            min_fee     : arg2,
            max_fee     : arg3,
            priority    : arg4,
            decimals    : arg5,
        };
        emit<SupportCoinEvent>(v1);
    }

    public(friend) fun emit_swap_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = SwapEvent{
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
        emit<SwapEvent>(v2);
    }

    public(friend) fun emit_update_fee_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = UpdateFeeEvent{
            vault_id           : arg0,
            coin_type          : *0x1::ascii::as_bytes(&v0),
            new_min_fee        : arg1,
            new_max_fee        : arg2,
            new_flash_loan_fee : arg3,
        };
        emit<UpdateFeeEvent>(v1);
    }

    public(friend) fun emit_withdraw_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = WithdrawEvent{
            vault_id                            : arg0,
            meta_coin_type                      : *0x1::ascii::as_bytes(&v0),
            meta_coin_amount_burned             : arg1,
            meta_coin_amount_total_supply       : arg2,
            coin_out_type                       : *0x1::ascii::as_bytes(&v1),
            coin_out_amount_withdrawn           : arg3,
            coin_out_amount_in_vault            : arg4,
            fee_coin_amount                     : arg5,
            exchange_rate_meta_coin_to_coin_out : arg6,
        };
        emit<WithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

