module 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload {
    struct JsonBuilder has drop {
        buffer: vector<u8>,
        is_first_field: bool,
    }

    public fun add_address(arg0: &mut JsonBuilder, arg1: vector<u8>, arg2: address) {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg2));
        add_string(arg0, arg1, v0);
    }

    public fun add_bool(arg0: &mut JsonBuilder, arg1: vector<u8>, arg2: bool) {
        let v0 = if (arg2) {
            0x1::string::utf8(b"true")
        } else {
            0x1::string::utf8(b"false")
        };
        add_string(arg0, arg1, v0);
    }

    public fun add_bytes(arg0: &mut JsonBuilder, arg1: vector<u8>, arg2: vector<u8>) {
        append_field_prefix(arg0, arg1);
        0x1::vector::append<u8>(&mut arg0.buffer, arg2);
        append_field_suffix(arg0);
    }

    public fun add_margin(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        user_amount_action(b"AddMargin", arg0, arg1, arg2, arg3, arg4)
    }

    public fun add_string(arg0: &mut JsonBuilder, arg1: vector<u8>, arg2: 0x1::string::String) {
        append_field_prefix(arg0, arg1);
        0x1::vector::append<u8>(&mut arg0.buffer, 0x1::string::into_bytes(arg2));
        append_field_suffix(arg0);
    }

    public fun add_u128(arg0: &mut JsonBuilder, arg1: vector<u8>, arg2: u128) {
        add_string(arg0, arg1, 0x1::u128::to_string(arg2));
    }

    public fun add_u64(arg0: &mut JsonBuilder, arg1: vector<u8>, arg2: u64) {
        add_string(arg0, arg1, 0x1::u64::to_string(arg2));
    }

    public fun add_u8(arg0: &mut JsonBuilder, arg1: vector<u8>, arg2: u8) {
        add_string(arg0, arg1, 0x1::u8::to_string(arg2));
    }

    public fun adjust_leverage(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"AdjustLeverage");
        let v2 = &mut v0;
        add_address(v2, b"market", arg0);
        let v3 = &mut v0;
        add_bytes(v3, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_u128(v4, b"new_leverage", arg2);
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg3);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg4);
        build(v0)
    }

    fun append_field_prefix(arg0: &mut JsonBuilder, arg1: vector<u8>) {
        0x1::vector::append<u8>(&mut arg0.buffer, b"\"");
        0x1::vector::append<u8>(&mut arg0.buffer, arg1);
        0x1::vector::append<u8>(&mut arg0.buffer, b"\":\"");
    }

    fun append_field_suffix(arg0: &mut JsonBuilder) {
        0x1::vector::append<u8>(&mut arg0.buffer, x"222c0a");
        arg0.is_first_field = false;
    }

    public fun build(arg0: JsonBuilder) : vector<u8> {
        let v0 = arg0.buffer;
        0x1::vector::append<u8>(&mut v0, b"\"domain\":\"");
        0x1::vector::append<u8>(&mut v0, b"dipcoin.io");
        0x1::vector::append<u8>(&mut v0, x"220a");
        0x1::vector::append<u8>(&mut v0, b"}");
        v0
    }

    public fun cancel_order(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u8, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: u128, arg9: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"CancelOrder");
        let v2 = &mut v0;
        add_address(v2, b"market", arg0);
        let v3 = &mut v0;
        add_bytes(v3, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_u8(v4, b"orderFlag", arg2);
        let v5 = &mut v0;
        add_u128(v5, b"price", arg3);
        let v6 = &mut v0;
        add_u128(v6, b"quantity", arg4);
        let v7 = &mut v0;
        add_u128(v7, b"leverage", arg5);
        let v8 = &mut v0;
        add_u64(v8, b"orderExpiration", arg6);
        let v9 = &mut v0;
        add_u128(v9, b"orderSalt", arg7);
        let v10 = &mut v0;
        add_u128(v10, b"salt", arg8);
        let v11 = &mut v0;
        add_u64(v11, b"expiration", arg9);
        build(v0)
    }

    public fun close_position(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"ClosePosition");
        let v2 = &mut v0;
        add_address(v2, b"market", arg0);
        let v3 = &mut v0;
        add_bytes(v3, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_u128(v4, b"salt", arg2);
        let v5 = &mut v0;
        add_u64(v5, b"expiration", arg3);
        build(v0)
    }

    public fun new_builder() : JsonBuilder {
        JsonBuilder{
            buffer         : x"7b0a",
            is_first_field : true,
        }
    }

    public fun remove_margin(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        user_amount_action(b"RemoveMargin", arg0, arg1, arg2, arg3, arg4)
    }

    public fun set_sub_account(arg0: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: bool, arg3: u128, arg4: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"SetSubAccount");
        let v2 = &mut v0;
        add_bytes(v2, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg0));
        let v3 = &mut v0;
        add_bytes(v3, b"subAccount", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_bool(v4, b"status", arg2);
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg3);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg4);
        build(v0)
    }

    public fun type_string<T0>() : 0x1::string::String {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        0x1::string::utf8(v0)
    }

    fun user_amount_action(arg0: vector<u8>, arg1: address, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: u128, arg4: u128, arg5: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", arg0);
        let v2 = &mut v0;
        add_address(v2, b"market", arg1);
        let v3 = &mut v0;
        add_bytes(v3, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v4 = &mut v0;
        add_u128(v4, b"amount", arg3);
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg4);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg5);
        build(v0)
    }

    public fun vault_claim_closed_vault_funds(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u64) : vector<u8> {
        vault_user_action(b"VaultClaimClosedFunds", arg0, arg1, arg2, arg3)
    }

    public fun vault_close(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u64) : vector<u8> {
        vault_user_action(b"VaultClose", arg0, arg1, arg2, arg3)
    }

    public fun vault_create(arg0: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg1: 0x1::string::String, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"VaultCreate");
        let v2 = &mut v0;
        add_bytes(v2, b"creator", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg0));
        let v3 = &mut v0;
        add_string(v3, b"name", arg1);
        let v4 = &mut v0;
        add_bytes(v4, b"trader", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v5 = &mut v0;
        add_u128(v5, b"maxCap", arg3);
        let v6 = &mut v0;
        add_u128(v6, b"minDepositAmount", arg4);
        let v7 = &mut v0;
        add_u128(v7, b"creatorMinimumShareRatio", arg5);
        let v8 = &mut v0;
        add_u128(v8, b"creatorProfitShareRatio", arg6);
        let v9 = &mut v0;
        add_u128(v9, b"initialAmount", arg7);
        let v10 = &mut v0;
        add_u128(v10, b"salt", arg8);
        let v11 = &mut v0;
        add_u64(v11, b"expiration", arg9);
        build(v0)
    }

    fun vault_creator_amount_action(arg0: vector<u8>, arg1: address, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: u128, arg4: u128, arg5: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", arg0);
        let v2 = &mut v0;
        add_address(v2, b"vault", arg1);
        let v3 = &mut v0;
        add_bytes(v3, b"creator", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v4 = &mut v0;
        add_u128(v4, b"amount", arg3);
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg4);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg5);
        build(v0)
    }

    public fun vault_deposit(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        vault_user_amount_action(b"VaultDeposit", arg0, arg1, arg2, arg3, arg4)
    }

    public fun vault_request_withdraw(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        vault_user_amount_action(b"VaultRequestWithdraw", arg0, arg1, arg2, arg3, arg4)
    }

    public fun vault_set_auto_close_on_withdraw(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: bool, arg3: u128, arg4: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"VaultSetAutoCloseOnWithdraw");
        let v2 = &mut v0;
        add_address(v2, b"vault", arg0);
        let v3 = &mut v0;
        add_bytes(v3, b"creator", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_bool(v4, b"autoCloseOnWithdraw", arg2);
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg3);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg4);
        build(v0)
    }

    public fun vault_set_deposit_status(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: bool, arg3: u128, arg4: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"VaultSetDepositStatus");
        let v2 = &mut v0;
        add_address(v2, b"vault", arg0);
        let v3 = &mut v0;
        add_bytes(v3, b"creator", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_bool(v4, b"status", arg2);
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg3);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg4);
        build(v0)
    }

    public fun vault_set_follower_max_cap(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        vault_creator_amount_action(b"VaultSetFollowerMaxCap", arg0, arg1, arg2, arg3, arg4)
    }

    public fun vault_set_max_cap(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        vault_creator_amount_action(b"VaultSetMaxCap", arg0, arg1, arg2, arg3, arg4)
    }

    public fun vault_set_min_deposit_amount(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        vault_creator_amount_action(b"VaultSetMinDepositAmount", arg0, arg1, arg2, arg3, arg4)
    }

    public fun vault_set_sub_trader(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: bool, arg4: u128, arg5: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"VaultSetSubTrader");
        let v2 = &mut v0;
        add_address(v2, b"vault", arg0);
        let v3 = &mut v0;
        add_bytes(v3, b"trader", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_bytes(v4, b"subTrader", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v5 = &mut v0;
        add_bool(v5, b"status", arg3);
        let v6 = &mut v0;
        add_u128(v6, b"salt", arg4);
        let v7 = &mut v0;
        add_u64(v7, b"expiration", arg5);
        build(v0)
    }

    public fun vault_set_trader(arg0: address, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: u128, arg4: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"VaultSetTrader");
        let v2 = &mut v0;
        add_address(v2, b"vault", arg0);
        let v3 = &mut v0;
        add_bytes(v3, b"creator", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg1));
        let v4 = &mut v0;
        add_bytes(v4, b"newTrader", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg3);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg4);
        build(v0)
    }

    fun vault_user_action(arg0: vector<u8>, arg1: address, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: u128, arg4: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", arg0);
        let v2 = &mut v0;
        add_address(v2, b"vault", arg1);
        let v3 = &mut v0;
        add_bytes(v3, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v4 = &mut v0;
        add_u128(v4, b"salt", arg3);
        let v5 = &mut v0;
        add_u64(v5, b"expiration", arg4);
        build(v0)
    }

    fun vault_user_amount_action(arg0: vector<u8>, arg1: address, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: u128, arg4: u128, arg5: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", arg0);
        let v2 = &mut v0;
        add_address(v2, b"vault", arg1);
        let v3 = &mut v0;
        add_bytes(v3, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v4 = &mut v0;
        add_u128(v4, b"amount", arg3);
        let v5 = &mut v0;
        add_u128(v5, b"salt", arg4);
        let v6 = &mut v0;
        add_u64(v6, b"expiration", arg5);
        build(v0)
    }

    public fun withdraw(arg0: address, arg1: 0x1::string::String, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg4: u128, arg5: u128, arg6: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"Withdraw");
        let v2 = &mut v0;
        add_address(v2, b"bank", arg0);
        let v3 = &mut v0;
        add_string(v3, b"coinType", arg1);
        let v4 = &mut v0;
        add_bytes(v4, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v5 = &mut v0;
        add_bytes(v5, b"destination", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg3));
        let v6 = &mut v0;
        add_u128(v6, b"amount", arg4);
        let v7 = &mut v0;
        add_u128(v7, b"salt", arg5);
        let v8 = &mut v0;
        add_u64(v8, b"expiration", arg6);
        build(v0)
    }

    public fun withdraw_all(arg0: address, arg1: 0x1::string::String, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg4: u128, arg5: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"WithdrawAll");
        let v2 = &mut v0;
        add_address(v2, b"bank", arg0);
        let v3 = &mut v0;
        add_string(v3, b"coinType", arg1);
        let v4 = &mut v0;
        add_bytes(v4, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v5 = &mut v0;
        add_bytes(v5, b"destination", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg3));
        let v6 = &mut v0;
        add_u128(v6, b"salt", arg4);
        let v7 = &mut v0;
        add_u64(v7, b"expiration", arg5);
        build(v0)
    }

    public fun withdraw_solana(arg0: address, arg1: 0x1::string::String, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg3: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg4: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg5: u128, arg6: u128, arg7: u64) : vector<u8> {
        let v0 = new_builder();
        let v1 = &mut v0;
        add_bytes(v1, b"action", b"Withdraw");
        let v2 = &mut v0;
        add_address(v2, b"bank", arg0);
        let v3 = &mut v0;
        add_string(v3, b"coinType", arg1);
        let v4 = &mut v0;
        add_bytes(v4, b"user", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg2));
        let v5 = &mut v0;
        add_bytes(v5, b"destination", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg3));
        let v6 = &mut v0;
        add_bytes(v6, b"tokenAccount", 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::display_bytes(&arg4));
        let v7 = &mut v0;
        add_u128(v7, b"amount", arg5);
        let v8 = &mut v0;
        add_u128(v8, b"salt", arg6);
        let v9 = &mut v0;
        add_u64(v9, b"expiration", arg7);
        build(v0)
    }

    // decompiled from Move bytecode v7
}

