module 0x2e331df0b00ad15901b951b4b9735f9d1874e48b7af74c131c60b57214306306::cctp {
    struct CctpDepositBox has key {
        id: 0x2::object::UID,
        version: u64,
        next_deposit_id: u64,
        deposits: 0x2::table::Table<u64, CctpDeposit>,
    }

    struct CctpDeposit has store {
        amount: u64,
        message_sender: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress,
    }

    struct CctpDepositCoinTypeKey has copy, drop, store {
        deposit_id: u64,
    }

    struct CctpReceiveAuth has drop {
        dummy_field: bool,
    }

    struct CctpBurnAuth has drop {
        dummy_field: bool,
    }

    struct CctpCoreAuth has drop {
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

    public fun create_receive_message_ticket<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg2: &mut CctpDepositBox, arg3: vector<u8>, arg4: vector<u8>) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::ReceiveMessageTicket<CctpReceiveAuth> {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        queue_deposit_for_receive<T0>(arg1, arg2, &arg3);
        let v0 = CctpReceiveAuth{dummy_field: false};
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_receive_message_ticket<CctpReceiveAuth>(v0, arg3, arg4)
    }

    fun assert_version(arg0: &CctpDepositBox) {
        assert!(arg0.version == 1, 2111);
    }

    public fun deposit_box_address(arg0: &CctpDepositBox) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun destination_caller() : address {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<CctpReceiveAuth>()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CctpDepositBox>(new_deposit_box(arg0));
    }

    entry fun migrate_deposit_box(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut CctpDepositBox) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg2.version < 1, 2111);
        arg2.version = 1;
    }

    fun new_deposit_box(arg0: &mut 0x2::tx_context::TxContext) : CctpDepositBox {
        let v0 = CctpDepositBox{
            id              : 0x2::object::new(arg0),
            version         : 1,
            next_deposit_id : 0,
            deposits        : 0x2::table::new<u64, CctpDeposit>(arg0),
        };
        let v1 = CctpDepositBoxCreatedEvent{box_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CctpDepositBoxCreatedEvent>(v1);
        v0
    }

    public fun pending_deposit_amount(arg0: &CctpDepositBox, arg1: u64) : u64 {
        0x2::table::borrow<u64, CctpDeposit>(&arg0.deposits, arg1).amount
    }

    public fun pending_deposit_message_sender(arg0: &CctpDepositBox, arg1: u64) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        0x2::table::borrow<u64, CctpDeposit>(&arg0.deposits, arg1).message_sender
    }

    fun queue_deposit<T0>(arg0: &mut CctpDepositBox, arg1: u64, arg2: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress) : u64 {
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&arg2) != @0x0, 105);
        let v0 = arg0.next_deposit_id;
        let v1 = CctpDeposit{
            amount         : arg1,
            message_sender : arg2,
        };
        0x2::table::add<u64, CctpDeposit>(&mut arg0.deposits, v0, v1);
        let v2 = CctpDepositCoinTypeKey{deposit_id: v0};
        0x2::dynamic_field::add<CctpDepositCoinTypeKey, 0x1::type_name::TypeName>(&mut arg0.id, v2, 0x1::type_name::with_defining_ids<T0>());
        arg0.next_deposit_id = v0 + 1;
        let v3 = CctpDepositQueuedEvent{
            box_id         : 0x2::object::uid_to_inner(&arg0.id),
            deposit_id     : v0,
            amount         : arg1,
            message_sender : arg2,
        };
        0x2::event::emit<CctpDepositQueuedEvent>(v3);
        v0
    }

    fun queue_deposit_for_receive<T0: drop>(arg0: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: &mut CctpDepositBox, arg2: &vector<u8>) {
        assert_version(arg1);
        let (v0, v1, v2) = queue_deposit_from_message<T0>(arg1, arg2);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_for_remote_domain_exists(arg0, v0) && 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::remote_token_messenger_from_remote_domain(arg0, v0) == v1, 2106);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token_exists(arg0, v0, v2) && 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::local_token_from_remote_token(arg0, v0, v2) == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::token_utils::calculate_token_id<T0>(), 2107);
    }

    fun queue_deposit_from_message<T0>(arg0: &mut CctpDepositBox, arg1: &vector<u8>) : (u32, address, address) {
        assert!(0x1::vector::length<u8>(arg1) >= 148 + 228, 2105);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg1, 76, 32) == 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator::MessageTransmitterAuthenticator>(), 2106);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg1, 108, 32) == destination_caller(), 2112);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg1, 148 + 36, 32) == deposit_box_address(arg0), 2102);
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg1, 148 + 68, 32);
        let v1 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u256_be(arg1, 148 + 164, 32);
        assert!(v0 <= 18446744073709551615 && v1 < v0, 2108);
        let v2 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_u32_be(arg1, 4, 4);
        queue_deposit<T0>(arg0, ((v0 - v1) as u64), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::cctp::unified_message_sender(v2, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg1, 148 + 100, 32)));
        (v2, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg1, 44, 32), 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(arg1, 148 + 4, 32))
    }

    entry fun sweep_deposit_box<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut CctpDepositBox, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: u64, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        assert_version(arg1);
        let CctpDeposit {
            amount         : v0,
            message_sender : v1,
        } = 0x2::table::remove<u64, CctpDeposit>(&mut arg1.deposits, arg4);
        let v2 = v1;
        let v3 = CctpDepositCoinTypeKey{deposit_id: arg4};
        if (0x2::dynamic_field::exists<CctpDepositCoinTypeKey>(&arg1.id, v3)) {
            assert!(0x2::dynamic_field::remove<CctpDepositCoinTypeKey, 0x1::type_name::TypeName>(&mut arg1.id, v3) == 0x1::type_name::with_defining_ids<T0>(), 2113);
        };
        let v4 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg5);
        let v5 = 0x2::coin::value<T0>(&v4);
        assert!(v5 == v0, 2103);
        let v6 = CctpCoreAuth{dummy_field: false};
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::package_auth::deposit_with_package_auth<T0, CctpCoreAuth>(v6, arg0, arg2, arg3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2), v4);
        let v7 = CctpDepositSweptEvent{
            box_id      : 0x2::object::uid_to_inner(&arg1.id),
            deposit_id  : arg4,
            beneficiary : v2,
            amount      : v5,
        };
        0x2::event::emit<CctpDepositSweptEvent>(v7);
    }

    public fun withdraw_and_create_burn_ticket<T0: drop>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u128, arg8: u128, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: u256, arg13: u32, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::DepositForBurnWithPackageAuthTicket<T0, CctpBurnAuth> {
        assert!(arg12 <= 10000000, 2114);
        let v0 = CctpCoreAuth{dummy_field: false};
        let (v1, v2, v3) = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::package_auth::withdraw_signed_with_package_auth<T0, CctpCoreAuth>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
        let v4 = v2;
        let v5 = CctpBurnAuth{dummy_field: false};
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::create_deposit_for_burn_with_package_auth_ticket<T0, CctpBurnAuth>(v1, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::cctp::domain_from_chain_id(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(&v4)), v3, @0x0, arg12, arg13, x"636374702d666f72776172640000000000000000000000000000000000000000", v5)
    }

    // decompiled from Move bytecode v7
}

