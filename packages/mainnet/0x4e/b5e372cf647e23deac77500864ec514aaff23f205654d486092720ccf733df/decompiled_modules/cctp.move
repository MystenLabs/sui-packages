module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::cctp {
    struct CctpDepositBox has store, key {
        id: 0x2::object::UID,
        next_deposit_id: u64,
        deposits: 0x2::table::Table<u64, CctpDeposit>,
    }

    struct CctpDeposit has store {
        amount: u64,
        message_sender: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
    }

    struct CctpReceiveAuth has drop {
        dummy_field: bool,
    }

    struct CctpBurnAuth has drop {
        dummy_field: bool,
    }

    struct CctpDepositBoxCreatedEvent has copy, drop {
        box_id: 0x2::object::ID,
    }

    struct CctpDepositQueuedEvent has copy, drop {
        box_id: 0x2::object::ID,
        deposit_id: u64,
        amount: u64,
        message_sender: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
    }

    struct CctpDepositSweptEvent has copy, drop {
        box_id: 0x2::object::ID,
        deposit_id: u64,
        beneficiary: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
        amount: u64,
    }

    public fun create_receive_message_ticket(arg0: vector<u8>, arg1: vector<u8>) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::ReceiveMessageTicket<CctpReceiveAuth> {
        abort 999
    }

    public fun deposit_box_address(arg0: &CctpDepositBox) : address {
        abort 999
    }

    public fun destination_caller() : address {
        abort 999
    }

    public fun pending_deposit_amount(arg0: &CctpDepositBox, arg1: u64) : u64 {
        abort 999
    }

    public fun pending_deposit_message_sender(arg0: &CctpDepositBox, arg1: u64) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        abort 999
    }

    public fun receive_into_deposit_box<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::Receipt, arg2: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: &mut CctpDepositBox, arg6: &mut 0x2::tx_context::TxContext) : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::StampReceiptTicket<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator> {
        abort 999
    }

    public fun withdraw_and_create_burn_ticket<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u128, arg8: u128, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnTicket<T0, CctpBurnAuth> {
        abort 999
    }

    // decompiled from Move bytecode v7
}

