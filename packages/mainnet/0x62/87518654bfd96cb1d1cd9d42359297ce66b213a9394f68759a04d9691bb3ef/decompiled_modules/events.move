module 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events {
    struct AdminCapTransferred has copy, drop {
        owner: address,
    }

    struct SupportedVersionUpdated has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct CoinSupported has copy, drop {
        vault: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        min_deposit: u64,
        sequence_number: u128,
    }

    struct MinDepositUpdated has copy, drop {
        vault: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        previous_min_deposit: u64,
        current_min_deposit: u64,
        sequence_number: u128,
    }

    struct DefaultProtocolFeeUpdated has copy, drop {
        old_protocol_fee_percentage: u64,
        new_protocol_fee_percentage: u64,
    }

    struct VaultCreated has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        manager: address,
        protocol_fee: u64,
    }

    struct Deposit has copy, drop {
        vault: 0x2::object::ID,
        sender: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        vault_coin_balance: u64,
        sequence_number: u128,
    }

    struct Withdraw has copy, drop {
        vault: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        vault_coin_balance: u64,
        sequence_number: u128,
    }

    struct VaultManagerUpdated has copy, drop {
        vault: 0x2::object::ID,
        previous_manager: address,
        current_manager: address,
    }

    struct ProtocolFeeRecipientUpdate has copy, drop {
        previous_recipient: address,
        current_recipient: address,
    }

    struct Swap has copy, drop {
        vault: 0x2::object::ID,
        quote_id: 0x1::string::String,
        account: address,
        token_in_type: 0x1::string::String,
        token_out_type: 0x1::string::String,
        token_in_amount: u64,
        token_out_amount: u64,
        fee: u64,
        vault_input_token_balance: TokenBalance,
        vault_output_token_balance: TokenBalance,
        sequence_number: u128,
    }

    struct TokenBalance has copy, drop {
        before: u64,
        after: u64,
    }

    struct ProtocolFeeClaimed has copy, drop {
        vault: 0x2::object::ID,
        token: 0x1::ascii::String,
        fee_claimed: u64,
        recipient: address,
        sequence_number: u128,
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address) {
        let v0 = AdminCapTransferred{owner: arg0};
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public(friend) fun emit_coin_deposited_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = Deposit{
            vault              : arg0,
            sender             : arg1,
            coin_type          : arg2,
            amount             : arg3,
            vault_coin_balance : arg4,
            sequence_number    : arg5,
        };
        0x2::event::emit<Deposit>(v0);
    }

    public(friend) fun emit_coin_supported(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u128) {
        let v0 = CoinSupported{
            vault           : arg0,
            coin_type       : arg1,
            min_deposit     : arg2,
            sequence_number : arg3,
        };
        0x2::event::emit<CoinSupported>(v0);
    }

    public(friend) fun emit_coin_withdrawn_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u128) {
        let v0 = Withdraw{
            vault              : arg0,
            coin_type          : arg1,
            amount             : arg2,
            vault_coin_balance : arg3,
            sequence_number    : arg4,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    public(friend) fun emit_default_protocol_fee_percentage_update_event(arg0: u64, arg1: u64) {
        let v0 = DefaultProtocolFeeUpdated{
            old_protocol_fee_percentage : arg0,
            new_protocol_fee_percentage : arg1,
        };
        0x2::event::emit<DefaultProtocolFeeUpdated>(v0);
    }

    public(friend) fun emit_min_deposit_coin_updated(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u128) {
        let v0 = MinDepositUpdated{
            vault                : arg0,
            coin_type            : arg1,
            previous_min_deposit : arg2,
            current_min_deposit  : arg3,
            sequence_number      : arg4,
        };
        0x2::event::emit<MinDepositUpdated>(v0);
    }

    public(friend) fun emit_protocol_fee_claimed_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: address, arg4: u128) {
        let v0 = ProtocolFeeClaimed{
            vault           : arg0,
            token           : arg1,
            fee_claimed     : arg2,
            recipient       : arg3,
            sequence_number : arg4,
        };
        0x2::event::emit<ProtocolFeeClaimed>(v0);
    }

    public(friend) fun emit_protocol_fee_recipient_update_event(arg0: address, arg1: address) {
        let v0 = ProtocolFeeRecipientUpdate{
            previous_recipient : arg0,
            current_recipient  : arg1,
        };
        0x2::event::emit<ProtocolFeeRecipientUpdate>(v0);
    }

    public(friend) fun emit_supported_version_update_event(arg0: u64, arg1: u64) {
        let v0 = SupportedVersionUpdated{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<SupportedVersionUpdated>(v0);
    }

    public(friend) fun emit_swap_executed_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u128) {
        let v0 = TokenBalance{
            before : arg8,
            after  : arg10,
        };
        let v1 = TokenBalance{
            before : arg9,
            after  : arg11,
        };
        let v2 = Swap{
            vault                      : arg0,
            quote_id                   : arg1,
            account                    : arg2,
            token_in_type              : arg3,
            token_out_type             : arg4,
            token_in_amount            : arg5,
            token_out_amount           : arg6,
            fee                        : arg7,
            vault_input_token_balance  : v0,
            vault_output_token_balance : v1,
            sequence_number            : arg12,
        };
        0x2::event::emit<Swap>(v2);
    }

    public(friend) fun emit_vault_created_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = VaultCreated{
            id           : arg0,
            sender       : arg1,
            manager      : arg2,
            protocol_fee : arg3,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public(friend) fun emit_vault_manager_updated_event(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = VaultManagerUpdated{
            vault            : arg0,
            previous_manager : arg1,
            current_manager  : arg2,
        };
        0x2::event::emit<VaultManagerUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

