module 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::liquidity_pool {
    struct Bank<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        sweep_accounts: 0x2::object_table::ObjectTable<address, SweepAccount>,
        swap_requests: 0x2::object_table::ObjectTable<address, SwapRequest>,
        jupnet_withdraw_requests: 0x2::table::Table<address, bool>,
        jupnet_swap_requests: 0x2::table::Table<address, bool>,
        invalidated_jupnet_requests: 0x2::table::Table<address, bool>,
        transaction_digest: vector<u8>,
        active_swap_cap_ids: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bank_id: 0x2::object::ID,
    }

    struct SwapCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bank_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BankBalance<phantom T0> has store {
        amount: 0x2::balance::Balance<T0>,
    }

    struct SweepAccount has store, key {
        id: 0x2::object::UID,
    }

    struct SwapRequest has store, key {
        id: 0x2::object::UID,
        user: address,
        valid_till: u64,
        coin_type_in: 0x1::type_name::TypeName,
        coin_type_out: 0x1::type_name::TypeName,
        expected_input_amount: u64,
        minimum_output_amount: u64,
    }

    struct SwapHotPotato {
        swap_request: SwapRequest,
        jupnet_swap_request: address,
    }

    struct JupnetInboxWitness has drop {
        dummy_field: bool,
    }

    struct JupnetBridgeProgramIdKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SweepAccountFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SweepAccountFeeRecipientKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SweepCoinEvent has copy, drop {
        sweep_account: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        msg_version: u8,
        msg_id: u64,
        inbox_hash: vector<u8>,
    }

    struct WithdrawCoinEvent has copy, drop {
        user_withdrawal_address: address,
        jupnet_withdrawal_request: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        msg_version: u8,
        msg_id: u64,
        inbox_hash: vector<u8>,
    }

    struct SwapEvent has copy, drop {
        user: address,
        jupnet_swap_request: address,
        input_coin_type: 0x1::type_name::TypeName,
        output_coin_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        msg_version: u8,
        msg_id: u64,
        inbox_hash: vector<u8>,
    }

    struct RequestInvalidatedEvent has copy, drop {
        jupnet_request: address,
        msg_version: u8,
        msg_id: u64,
        inbox_hash: vector<u8>,
    }

    struct SweepAccountCreatedEvent has copy, drop {
        sweep_account: address,
        msg_version: u8,
        msg_id: u64,
        inbox_hash: vector<u8>,
    }

    struct InjectBalanceEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct LIQUIDITY_POOL has drop {
        dummy_field: bool,
    }

    fun coin_type_address<T0>() : address {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            if (v3 == 58) {
                break
            };
            0x1::vector::push_back<u8>(&mut v1, v3);
            v2 = v2 + 1;
        };
        0x2::address::from_ascii_bytes(&v1)
    }

    public fun complete_fulfill_swap_request<T0, T1, T2>(arg0: &SwapCap<T0>, arg1: address, arg2: SwapHotPotato, arg3: &mut Bank<T0>, arg4: &mut 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::outbox_bridge::OutboxBridge, arg5: &mut 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::InboxBridge, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T2>, arg8: u64, arg9: u64, arg10: vector<vector<u8>>, arg11: vector<u8>, arg12: vector<u8>, arg13: u16, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg3.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(arg0)), 8);
        assert!(arg3.transaction_digest != *0x2::tx_context::digest(arg14), 4);
        arg3.transaction_digest = *0x2::tx_context::digest(arg14);
        let SwapHotPotato {
            swap_request        : v0,
            jupnet_swap_request : v1,
        } = arg2;
        let v2 = v0;
        assert!(arg1 == v1, 6);
        assert!(0x1::type_name::with_defining_ids<T1>() == v2.coin_type_in, 5);
        assert!(0x1::type_name::with_defining_ids<T2>() == v2.coin_type_out, 5);
        assert!(v2.valid_till > 0x2::clock::timestamp_ms(arg6), 2);
        let v3 = 0x2::coin::value<T2>(&arg7);
        assert!(v3 >= v2.minimum_output_amount, 3);
        let v4 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC");
        if (!v4) {
            assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 7);
        };
        let v5 = if (v4) {
            0x1::type_name::with_defining_ids<T2>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        let v6 = JupnetBridgeProgramIdKey{dummy_field: false};
        0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::outbox_bridge::verify_outbox_message(arg4, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_swap_message_hash(v5, v2.expected_input_amount, v2.minimum_output_amount, v2.valid_till, arg1, v4), *0x2::dynamic_field::borrow<JupnetBridgeProgramIdKey, vector<u8>>(&arg3.id, v6), arg8, arg9, arg10, arg11, arg12, arg13);
        let v7 = BalanceKey<T2>{dummy_field: false};
        0x2::balance::join<T2>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T2>, BankBalance<T2>>(&mut arg3.id, v7).amount, 0x2::coin::into_balance<T2>(arg7));
        let v8 = JupnetInboxWitness{dummy_field: false};
        let (v9, v10, v11) = 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::submit_inbox_message<JupnetInboxWitness>(arg5, v8, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_swapped_inbox_hash(arg1, coin_type_address<T2>(), v3), arg6);
        let v12 = SwapEvent{
            user                : v2.user,
            jupnet_swap_request : arg1,
            input_coin_type     : 0x1::type_name::with_defining_ids<T1>(),
            output_coin_type    : 0x1::type_name::with_defining_ids<T2>(),
            input_amount        : v2.expected_input_amount,
            output_amount       : v3,
            msg_version         : v9,
            msg_id              : v10,
            inbox_hash          : v11,
        };
        0x2::event::emit<SwapEvent>(v12);
        let SwapRequest {
            id                    : v13,
            user                  : _,
            valid_till            : _,
            coin_type_in          : _,
            coin_type_out         : _,
            expected_input_amount : _,
            minimum_output_amount : _,
        } = v2;
        0x2::object::delete(v13);
    }

    public fun create_swap_cap<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) : SwapCap<T0> {
        let v0 = 0x2::object::new(arg2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.active_swap_cap_ids, 0x2::object::uid_to_inner(&v0), true);
        SwapCap<T0>{
            id      : v0,
            bank_id : 0x2::object::id<Bank<T0>>(arg1),
        }
    }

    public fun create_swap_request<T0, T1, T2>(arg0: &SwapCap<T0>, arg1: address, arg2: &mut Bank<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg2.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(arg0)), 8);
        assert!(!0x2::table::contains<address, bool>(&arg2.invalidated_jupnet_requests, arg1), 12);
        assert!(!0x2::table::contains<address, bool>(&arg2.jupnet_swap_requests, arg1), 10);
        let v0 = SwapRequest{
            id                    : 0x2::object::new(arg7),
            user                  : arg3,
            valid_till            : arg4,
            coin_type_in          : 0x1::type_name::with_defining_ids<T1>(),
            coin_type_out         : 0x1::type_name::with_defining_ids<T2>(),
            expected_input_amount : arg5,
            minimum_output_amount : arg6,
        };
        0x2::object_table::add<address, SwapRequest>(&mut arg2.swap_requests, arg1, v0);
        0x2::table::add<address, bool>(&mut arg2.jupnet_swap_requests, arg1, true);
    }

    public fun create_sweep_account<T0>(arg0: &mut Bank<T0>, arg1: &mut 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::InboxBridge, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = SweepAccountFeeKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_<SweepAccountFeeKey>(&arg0.id, v0)) {
            let v2 = SweepAccountFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<SweepAccountFeeKey, u64>(&arg0.id, v2)
        } else {
            0
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 13);
        let v3 = if (v1 > 0) {
            let v4 = SweepAccountFeeRecipientKey{dummy_field: false};
            0x2::dynamic_field::exists_<SweepAccountFeeRecipientKey>(&arg0.id, v4)
        } else {
            false
        };
        if (v3) {
            let v5 = SweepAccountFeeRecipientKey{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, *0x2::dynamic_field::borrow<SweepAccountFeeRecipientKey, address>(&arg0.id, v5));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        };
        let v6 = SweepAccount{id: 0x2::object::new(arg4)};
        let v7 = 0x2::object::uid_to_address(&v6.id);
        0x2::object_table::add<address, SweepAccount>(&mut arg0.sweep_accounts, v7, v6);
        let v8 = JupnetInboxWitness{dummy_field: false};
        let (v9, v10, v11) = 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::submit_inbox_message<JupnetInboxWitness>(arg1, v8, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_sweep_account_created_inbox_hash(v7), arg3);
        let v12 = SweepAccountCreatedEvent{
            sweep_account : v7,
            msg_version   : v9,
            msg_id        : v10,
            inbox_hash    : v11,
        };
        0x2::event::emit<SweepAccountCreatedEvent>(v12);
    }

    fun init(arg0: LIQUIDITY_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUIDITY_POOL>(arg0, arg1);
        let (v0, v1, v2) = init_bank<LIQUIDITY_POOL>(arg1);
        0x2::transfer::share_object<Bank<LIQUIDITY_POOL>>(v0);
        0x2::transfer::transfer<AdminCap<LIQUIDITY_POOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<SwapCap<LIQUIDITY_POOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun init_balance_for_coin<T0, T1>(arg0: &mut Bank<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = BalanceKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceKey<T1>>(&arg0.id, v0)) {
            let v1 = BalanceKey<T1>{dummy_field: false};
            let v2 = BankBalance<T1>{amount: 0x2::balance::zero<T1>()};
            0x2::dynamic_field::add<BalanceKey<T1>, BankBalance<T1>>(&mut arg0.id, v1, v2);
        };
    }

    fun init_bank<T0>(arg0: &mut 0x2::tx_context::TxContext) : (Bank<T0>, AdminCap<T0>, SwapCap<T0>) {
        let v0 = Bank<T0>{
            id                          : 0x2::object::new(arg0),
            version                     : 1,
            sweep_accounts              : 0x2::object_table::new<address, SweepAccount>(arg0),
            swap_requests               : 0x2::object_table::new<address, SwapRequest>(arg0),
            jupnet_withdraw_requests    : 0x2::table::new<address, bool>(arg0),
            jupnet_swap_requests        : 0x2::table::new<address, bool>(arg0),
            invalidated_jupnet_requests : 0x2::table::new<address, bool>(arg0),
            transaction_digest          : *0x2::tx_context::digest(arg0),
            active_swap_cap_ids         : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        let v1 = AdminCap<T0>{
            id      : 0x2::object::new(arg0),
            bank_id : 0x2::object::id<Bank<T0>>(&v0),
        };
        let v2 = SwapCap<T0>{
            id      : 0x2::object::new(arg0),
            bank_id : 0x2::object::id<Bank<T0>>(&v0),
        };
        0x2::table::add<0x2::object::ID, bool>(&mut v0.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(&v2), true);
        (v0, v1, v2)
    }

    public fun init_fulfill_swap_request<T0, T1>(arg0: &SwapCap<T0>, arg1: address, arg2: &mut Bank<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapHotPotato) {
        assert!(arg2.version == 1, 1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg2.active_swap_cap_ids, 0x2::object::id<SwapCap<T0>>(arg0)), 8);
        assert!(!0x2::table::contains<address, bool>(&arg2.invalidated_jupnet_requests, arg1), 12);
        let v0 = 0x2::object_table::remove<address, SwapRequest>(&mut arg2.swap_requests, arg1);
        assert!(0x1::type_name::with_defining_ids<T1>() == v0.coin_type_in, 5);
        let v1 = BalanceKey<T1>{dummy_field: false};
        let v2 = SwapHotPotato{
            swap_request        : v0,
            jupnet_swap_request : arg1,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg2.id, v1).amount, v0.expected_input_amount), arg3), v2)
    }

    public fun inject_balance<T0>(arg0: &AdminCap<LIQUIDITY_POOL>, arg1: &mut Bank<LIQUIDITY_POOL>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg1.id, v0)) {
            let v1 = BalanceKey<T0>{dummy_field: false};
            let v2 = BankBalance<T0>{amount: 0x2::balance::zero<T0>()};
            0x2::dynamic_field::add<BalanceKey<T0>, BankBalance<T0>>(&mut arg1.id, v1, v2);
        };
        let v3 = BalanceKey<T0>{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T0>, BankBalance<T0>>(&mut arg1.id, v3).amount, 0x2::coin::into_balance<T0>(arg2));
        let v4 = InjectBalanceEvent{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<InjectBalanceEvent>(v4);
    }

    public fun invalidate_jupnet_request<T0>(arg0: &mut Bank<T0>, arg1: &mut 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::outbox_bridge::OutboxBridge, arg2: &mut 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::InboxBridge, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: vector<vector<u8>>, arg8: vector<u8>, arg9: vector<u8>, arg10: u16, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.jupnet_swap_requests, arg4), 10);
        assert!(!0x2::table::contains<address, bool>(&arg0.jupnet_withdraw_requests, arg4), 10);
        assert!(arg3 < 0x2::clock::timestamp_ms(arg11), 2);
        let v0 = JupnetBridgeProgramIdKey{dummy_field: false};
        0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::outbox_bridge::verify_outbox_message(arg1, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_invalidation_message_hash(arg3, arg4), *0x2::dynamic_field::borrow<JupnetBridgeProgramIdKey, vector<u8>>(&arg0.id, v0), arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::table::add<address, bool>(&mut arg0.invalidated_jupnet_requests, arg4, true);
        let v1 = JupnetInboxWitness{dummy_field: false};
        let (v2, v3, v4) = 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::submit_inbox_message<JupnetInboxWitness>(arg2, v1, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_invalidated_inbox_hash(arg4), arg11);
        let v5 = RequestInvalidatedEvent{
            jupnet_request : arg4,
            msg_version    : v2,
            msg_id         : v3,
            inbox_hash     : v4,
        };
        0x2::event::emit<RequestInvalidatedEvent>(v5);
    }

    public fun migrate_version<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(1 > arg1.version, 1);
        arg1.version = 1;
    }

    public fun register_with_inbox<T0>(arg0: &AdminCap<T0>, arg1: &mut 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::InboxBridge, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::register<JupnetInboxWitness>(arg1, arg2, arg3);
    }

    public fun revoke_swap_cap<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: 0x2::object::ID) {
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.active_swap_cap_ids, arg2);
    }

    public fun set_jupnet_bridge_program_id<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = JupnetBridgeProgramIdKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<JupnetBridgeProgramIdKey>(&arg1.id, v0)) {
            let v1 = JupnetBridgeProgramIdKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<JupnetBridgeProgramIdKey, vector<u8>>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = JupnetBridgeProgramIdKey{dummy_field: false};
            0x2::dynamic_field::add<JupnetBridgeProgramIdKey, vector<u8>>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_sweep_account_fee<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: u64) {
        let v0 = SweepAccountFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<SweepAccountFeeKey>(&arg1.id, v0)) {
            let v1 = SweepAccountFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SweepAccountFeeKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = SweepAccountFeeKey{dummy_field: false};
            0x2::dynamic_field::add<SweepAccountFeeKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_sweep_account_fee_recipient<T0>(arg0: &AdminCap<T0>, arg1: &mut Bank<T0>, arg2: address) {
        let v0 = SweepAccountFeeRecipientKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<SweepAccountFeeRecipientKey>(&arg1.id, v0)) {
            let v1 = SweepAccountFeeRecipientKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SweepAccountFeeRecipientKey, address>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = SweepAccountFeeRecipientKey{dummy_field: false};
            0x2::dynamic_field::add<SweepAccountFeeRecipientKey, address>(&mut arg1.id, v2, arg2);
        };
    }

    public fun sweep_coin<T0, T1>(arg0: &mut Bank<T0>, arg1: address, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg3: &mut 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::InboxBridge, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut 0x2::object_table::borrow_mut<address, SweepAccount>(&mut arg0.sweep_accounts, arg1).id, arg2);
        let v1 = BalanceKey<T1>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg0.id, v1);
        let v3 = 0x2::coin::value<T1>(&v0);
        assert!(v3 > 0, 9);
        0x2::balance::join<T1>(&mut v2.amount, 0x2::coin::into_balance<T1>(v0));
        let v4 = JupnetInboxWitness{dummy_field: false};
        let (v5, v6, v7) = 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::submit_inbox_message<JupnetInboxWitness>(arg3, v4, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_deposited_inbox_hash(arg1, coin_type_address<T1>(), v3), arg4);
        let v8 = SweepCoinEvent{
            sweep_account : arg1,
            coin_type     : 0x1::type_name::with_defining_ids<T1>(),
            amount        : v3,
            msg_version   : v5,
            msg_id        : v6,
            inbox_hash    : v7,
        };
        0x2::event::emit<SweepCoinEvent>(v8);
    }

    public fun withdraw_tokens<T0, T1>(arg0: address, arg1: &mut Bank<T0>, arg2: &mut 0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::outbox_bridge::OutboxBridge, arg3: &mut 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::InboxBridge, arg4: &0x2::clock::Clock, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<vector<u8>>, arg11: vector<u8>, arg12: vector<u8>, arg13: u16, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(arg1.transaction_digest != *0x2::tx_context::digest(arg14), 4);
        assert!(arg7 > 0x2::clock::timestamp_ms(arg4), 2);
        arg1.transaction_digest = *0x2::tx_context::digest(arg14);
        assert!(!0x2::table::contains<address, bool>(&arg1.invalidated_jupnet_requests, arg0), 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.jupnet_withdraw_requests, arg0), 10);
        let v0 = JupnetBridgeProgramIdKey{dummy_field: false};
        0x81253fe6ae6f95d3de1f6a34d9e8252c6954a97bf08b7eb84bcc2cc769dbaa3a::outbox_bridge::verify_outbox_message(arg2, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_withdrawal_message_hash(0x1::type_name::with_defining_ids<T1>(), arg6, arg7, arg5, arg0), *0x2::dynamic_field::borrow<JupnetBridgeProgramIdKey, vector<u8>>(&arg1.id, v0), arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::table::add<address, bool>(&mut arg1.jupnet_withdraw_requests, arg0, true);
        let v1 = BalanceKey<T1>{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey<T1>, BankBalance<T1>>(&mut arg1.id, v1).amount, arg6), arg14), arg5);
        let v2 = JupnetInboxWitness{dummy_field: false};
        let (v3, v4, v5) = 0x700dee3cbb975568ec271c9c29713d38ac68e3c5a1d21ecd45374d6792a52709::inbox_bridge::submit_inbox_message<JupnetInboxWitness>(arg3, v2, 0x8240fc901befddfbb2a14a7dcf25a24a32c87958586f0e3cf4c274005784843d::verification::create_withdrew_inbox_hash(arg0, arg6, coin_type_address<T1>(), arg5), arg4);
        let v6 = WithdrawCoinEvent{
            user_withdrawal_address   : arg5,
            jupnet_withdrawal_request : arg0,
            coin_type                 : 0x1::type_name::with_defining_ids<T1>(),
            amount                    : arg6,
            msg_version               : v3,
            msg_id                    : v4,
            inbox_hash                : v5,
        };
        0x2::event::emit<WithdrawCoinEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

