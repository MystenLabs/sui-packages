module 0x3b56af191976c2c7382531e47c05e9d542552e3adfd998334b0c2be2b1d90f74::events {
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
        deposited_coin_type: vector<u8>,
        deposited_coin_amount: u64,
        meta_coin_type: vector<u8>,
        meta_coin_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawn_coin_type: vector<u8>,
        withdrawn_coin_amount: u64,
        meta_coin_type: vector<u8>,
        meta_coin_amount: u64,
    }

    struct SwapEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposited_coin_type: vector<u8>,
        deposited_coin_amount: u64,
        withdrawn_coin_type: vector<u8>,
        withdrawn_coin_amount: u64,
    }

    struct SupportCoinEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        deposit_cap: u64,
        min_fee_bps: u64,
        max_fee_bps: u64,
        priority: u64,
        decimals: u8,
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

    public(friend) fun emit_deposit_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = DepositEvent{
            vault_id              : arg0,
            deposited_coin_type   : *0x1::ascii::as_bytes(&v0),
            deposited_coin_amount : arg1,
            meta_coin_type        : *0x1::ascii::as_bytes(&v1),
            meta_coin_amount      : arg2,
        };
        emit<DepositEvent>(v2);
    }

    public(friend) fun emit_support_coin_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = SupportCoinEvent{
            vault_id    : arg0,
            coin_type   : *0x1::ascii::as_bytes(&v0),
            deposit_cap : arg1,
            min_fee_bps : arg2,
            max_fee_bps : arg3,
            priority    : arg4,
            decimals    : arg5,
        };
        emit<SupportCoinEvent>(v1);
    }

    public(friend) fun emit_swap_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = SwapEvent{
            vault_id              : arg0,
            deposited_coin_type   : *0x1::ascii::as_bytes(&v0),
            deposited_coin_amount : arg1,
            withdrawn_coin_type   : *0x1::ascii::as_bytes(&v1),
            withdrawn_coin_amount : arg2,
        };
        emit<SwapEvent>(v2);
    }

    public(friend) fun emit_withdraw_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = WithdrawEvent{
            vault_id              : arg0,
            withdrawn_coin_type   : *0x1::ascii::as_bytes(&v0),
            withdrawn_coin_amount : arg1,
            meta_coin_type        : *0x1::ascii::as_bytes(&v1),
            meta_coin_amount      : arg2,
        };
        emit<WithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

