module 0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::cross {
    struct TokenPair has copy, drop, store {
        token_pair_id: u64,
        sui_token_address: 0x1::ascii::String,
        sui_token_type: u8,
        external_chain_id: u64,
        external_token_address: 0x1::ascii::String,
        is_active: bool,
    }

    struct TokenPairRegistry has key {
        id: 0x2::object::UID,
        pairs_by_id: 0x2::table::Table<u64, TokenPair>,
    }

    struct TreasuryCapsRegistry has key {
        id: 0x2::object::UID,
    }

    struct FoundationConfig has key {
        id: 0x2::object::UID,
        fee_recipient: address,
    }

    struct PauseConfig has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct TokenPairAdded has copy, drop {
        token_pair_id: u64,
        sui_token_address: 0x1::ascii::String,
        external_chain_id: u64,
        external_token_address: 0x1::ascii::String,
        sui_token_type: u8,
    }

    struct TokenPairRemoved has copy, drop {
        token_pair_id: u64,
        sui_token_address: 0x1::ascii::String,
        external_chain_id: u64,
        external_token_address: 0x1::ascii::String,
    }

    struct TokenPairUpdated has copy, drop {
        token_pair_id: u64,
        sui_token_address: 0x1::ascii::String,
        external_chain_id: u64,
        external_token_address: 0x1::ascii::String,
        sui_token_type: u8,
        is_active: bool,
    }

    struct TreasuryCapReceived has copy, drop {
        token_type: 0x1::ascii::String,
        receiver: address,
    }

    struct PartnerEvent has copy, drop {
        partner_name: 0x1::ascii::String,
    }

    struct UserLockLogger has copy, drop {
        smg_id: vector<u8>,
        token_pair_id: u64,
        sender: address,
        recipient: 0x1::ascii::String,
        amount: u64,
        network_fee: u64,
        sui_token_address: 0x1::ascii::String,
        external_chain_id: u64,
        external_token_address: 0x1::ascii::String,
        token_type: 0x1::ascii::String,
    }

    struct UserBurnLogger has copy, drop {
        smg_id: vector<u8>,
        token_pair_id: u64,
        sender: address,
        recipient: 0x1::ascii::String,
        amount: u64,
        network_fee: u64,
        sui_token_address: 0x1::ascii::String,
        external_chain_id: u64,
        external_token_address: 0x1::ascii::String,
        token_type: 0x1::ascii::String,
    }

    struct SmgMintLogger has copy, drop {
        unique_id: vector<u8>,
        smg_id: vector<u8>,
        token_pair_id: u64,
        recipient: address,
        amount: u64,
        service_fee: u64,
        fee_recipient: address,
        token_type: 0x1::ascii::String,
    }

    struct SmgReleaseLogger has copy, drop {
        unique_id: vector<u8>,
        smg_id: vector<u8>,
        token_pair_id: u64,
        recipient: address,
        amount: u64,
        service_fee: u64,
        fee_recipient: address,
        token_type: 0x1::ascii::String,
    }

    struct FeeCollectedEvent has copy, drop {
        chain_id: u64,
        amount: u64,
        recipient: address,
    }

    struct FeeRecipientChangedEvent has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    struct PauseStatusChangedEvent has copy, drop {
        is_paused: bool,
    }

    struct TokenVault has key {
        id: 0x2::object::UID,
    }

    struct TokenBalance<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    struct TokenBalanceKey has copy, drop, store {
        type_name: 0x1::type_name::TypeName,
    }

    struct ProcessedTransactions has key {
        id: 0x2::object::UID,
        processed: 0x2::table::Table<vector<u8>, bool>,
    }

    public entry fun add_token_pair(arg0: &mut TokenPairRegistry, arg1: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg2: u64, arg3: 0x1::ascii::String, arg4: u8, arg5: u64, arg6: 0x1::ascii::String, arg7: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_admin(arg1, arg7);
        assert!(arg2 > 0, 3);
        assert!(arg5 > 0, 3);
        assert!(0x1::ascii::length(&arg3) > 0, 4);
        assert!(0x1::ascii::length(&arg6) > 0, 4);
        assert!(arg4 == 1 || arg4 == 2, 6);
        assert!(!0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg2), 5);
        let v0 = TokenPair{
            token_pair_id          : arg2,
            sui_token_address      : arg3,
            sui_token_type         : arg4,
            external_chain_id      : arg5,
            external_token_address : arg6,
            is_active              : true,
        };
        0x2::table::add<u64, TokenPair>(&mut arg0.pairs_by_id, arg2, v0);
        let v1 = TokenPairAdded{
            token_pair_id          : arg2,
            sui_token_address      : arg3,
            external_chain_id      : arg5,
            external_token_address : arg6,
            sui_token_type         : arg4,
        };
        0x2::event::emit<TokenPairAdded>(v1);
    }

    public fun get_token_pair_by_id(arg0: &TokenPairRegistry, arg1: u64) : (0x1::ascii::String, 0x1::ascii::String, u64, u8, bool) {
        assert!(0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg1), 2);
        let v0 = 0x2::table::borrow<u64, TokenPair>(&arg0.pairs_by_id, arg1);
        (v0.sui_token_address, v0.external_token_address, v0.external_chain_id, v0.sui_token_type, v0.is_active)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenPairRegistry{
            id          : 0x2::object::new(arg0),
            pairs_by_id : 0x2::table::new<u64, TokenPair>(arg0),
        };
        let v1 = TokenVault{id: 0x2::object::new(arg0)};
        let v2 = TreasuryCapsRegistry{id: 0x2::object::new(arg0)};
        let v3 = ProcessedTransactions{
            id        : 0x2::object::new(arg0),
            processed : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        let v4 = FoundationConfig{
            id            : 0x2::object::new(arg0),
            fee_recipient : 0x2::tx_context::sender(arg0),
        };
        let v5 = PauseConfig{
            id        : 0x2::object::new(arg0),
            is_paused : false,
        };
        0x2::transfer::share_object<TokenPairRegistry>(v0);
        0x2::transfer::share_object<TokenVault>(v1);
        0x2::transfer::share_object<TreasuryCapsRegistry>(v2);
        0x2::transfer::share_object<ProcessedTransactions>(v3);
        0x2::transfer::share_object<FoundationConfig>(v4);
        0x2::transfer::share_object<PauseConfig>(v5);
    }

    public entry fun receive_treasury_cap<T0>(arg0: &mut TreasuryCapsRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 11);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0, arg1);
        let v1 = TreasuryCapReceived{
            token_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            receiver   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TreasuryCapReceived>(v1);
    }

    public entry fun remove_token_pair(arg0: &mut TokenPairRegistry, arg1: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_admin(arg1, arg3);
        assert!(0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg2), 2);
        let v0 = 0x2::table::remove<u64, TokenPair>(&mut arg0.pairs_by_id, arg2);
        let v1 = TokenPairRemoved{
            token_pair_id          : arg2,
            sui_token_address      : v0.sui_token_address,
            external_chain_id      : v0.external_chain_id,
            external_token_address : v0.external_token_address,
        };
        0x2::event::emit<TokenPairRemoved>(v1);
    }

    public entry fun set_fee_recipient(arg0: &mut FoundationConfig, arg1: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_admin(arg1, arg3);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientChangedEvent{
            old_recipient : arg0.fee_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<FeeRecipientChangedEvent>(v0);
    }

    public entry fun set_pause_status(arg0: &mut PauseConfig, arg1: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_admin(arg1, arg3);
        if (arg0.is_paused != arg2) {
            arg0.is_paused = arg2;
            let v0 = PauseStatusChangedEvent{is_paused: arg2};
            0x2::event::emit<PauseStatusChangedEvent>(v0);
        };
    }

    public entry fun smg_mint<T0>(arg0: &TokenPairRegistry, arg1: &mut TreasuryCapsRegistry, arg2: &mut ProcessedTransactions, arg3: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::OracleStorage, arg4: &PauseConfig, arg5: &FoundationConfig, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: address, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.is_paused, 14);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg2.processed, arg7), 12);
        assert!(0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg9), 2);
        let v0 = 0x2::table::borrow<u64, TokenPair>(&arg0.pairs_by_id, arg9);
        assert!(v0.is_active, 7);
        assert!(v0.sui_token_type == 2, 6);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::into_string(v1);
        assert!(v2 == v0.sui_token_address, 9);
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg1.id, v1), 10);
        let v3 = arg5.fee_recipient;
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 2147484432;
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&v5));
        0x1::vector::append<u8>(&mut v4, arg7);
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&arg9));
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&arg11));
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&arg12));
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<address>(&arg10));
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::verify_signature(arg3, arg6, arg8, v4, arg13);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(v6, arg11, arg14), arg10);
        if (arg12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(v6, arg12, arg14), v3);
        };
        0x2::table::add<vector<u8>, bool>(&mut arg2.processed, arg7, true);
        let v7 = SmgMintLogger{
            unique_id     : arg7,
            smg_id        : arg8,
            token_pair_id : arg9,
            recipient     : arg10,
            amount        : arg11,
            service_fee   : arg12,
            fee_recipient : v3,
            token_type    : v2,
        };
        0x2::event::emit<SmgMintLogger>(v7);
    }

    public entry fun smg_release<T0>(arg0: &TokenPairRegistry, arg1: &mut TokenVault, arg2: &mut ProcessedTransactions, arg3: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::OracleStorage, arg4: &PauseConfig, arg5: &FoundationConfig, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: address, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.is_paused, 14);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg2.processed, arg7), 12);
        assert!(0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg9), 2);
        let v0 = 0x2::table::borrow<u64, TokenPair>(&arg0.pairs_by_id, arg9);
        assert!(v0.is_active, 7);
        assert!(v0.sui_token_type == 1, 6);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::into_string(v1);
        assert!(v2 == v0.sui_token_address, 9);
        let v3 = arg5.fee_recipient;
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 2147484432;
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&v5));
        0x1::vector::append<u8>(&mut v4, arg7);
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&arg9));
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&arg11));
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<u64>(&arg12));
        0x1::vector::append<u8>(&mut v4, 0x1::bcs::to_bytes<address>(&arg10));
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::verify_signature(arg3, arg6, arg8, v4, arg13);
        let v6 = TokenBalanceKey{type_name: v1};
        assert!(0x2::dynamic_field::exists_<TokenBalanceKey>(&arg1.id, v6), 8);
        let v7 = 0x2::dynamic_field::borrow_mut<TokenBalanceKey, TokenBalance<T0>>(&mut arg1.id, v6);
        assert!(0x2::balance::value<T0>(&v7.balance) >= arg11 + arg12, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7.balance, arg11), arg14), arg10);
        if (arg12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7.balance, arg12), arg14), v3);
        };
        0x2::table::add<vector<u8>, bool>(&mut arg2.processed, arg7, true);
        let v8 = SmgReleaseLogger{
            unique_id     : arg7,
            smg_id        : arg8,
            token_pair_id : arg9,
            recipient     : arg10,
            amount        : arg11,
            service_fee   : arg12,
            fee_recipient : v3,
            token_type    : v2,
        };
        0x2::event::emit<SmgReleaseLogger>(v8);
    }

    public entry fun update_token_pair(arg0: &mut TokenPairRegistry, arg1: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::Admin, arg2: u64, arg3: 0x1::ascii::String, arg4: u8, arg5: u64, arg6: 0x1::ascii::String, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::admin::assert_admin(arg1, arg8);
        assert!(arg5 > 0, 3);
        assert!(0x1::ascii::length(&arg3) > 0, 4);
        assert!(0x1::ascii::length(&arg6) > 0, 4);
        assert!(arg4 == 1 || arg4 == 2, 6);
        assert!(0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg2), 2);
        let v0 = 0x2::table::borrow_mut<u64, TokenPair>(&mut arg0.pairs_by_id, arg2);
        v0.sui_token_address = arg3;
        v0.sui_token_type = arg4;
        v0.external_chain_id = arg5;
        v0.external_token_address = arg6;
        v0.is_active = arg7;
        let v1 = TokenPairUpdated{
            token_pair_id          : arg2,
            sui_token_address      : arg3,
            external_chain_id      : arg5,
            external_token_address : arg6,
            sui_token_type         : arg4,
            is_active              : arg7,
        };
        0x2::event::emit<TokenPairUpdated>(v1);
    }

    public entry fun user_burn<T0>(arg0: &TokenPairRegistry, arg1: &mut TreasuryCapsRegistry, arg2: &FoundationConfig, arg3: &PauseConfig, arg4: &0x16b03acd7aa1fd34e913282b69ebd778951db2a4a55b4015f1d7f0d5a7f40b2d::fee_manager::FeeConfig, arg5: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::OracleStorage, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: u64, arg9: 0x1::ascii::String, arg10: 0x2::coin::Coin<T0>, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x1::ascii::String, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 14);
        assert!(0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg8), 2);
        let v0 = 0x2::table::borrow<u64, TokenPair>(&arg0.pairs_by_id, arg8);
        assert!(v0.is_active, 7);
        assert!(v0.sui_token_type == 2, 6);
        let v1 = 0x16b03acd7aa1fd34e913282b69ebd778951db2a4a55b4015f1d7f0d5a7f40b2d::fee_manager::get_fee(arg4, v0.external_chain_id);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg11) >= v1, 13);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg11, v1, arg13), arg2.fee_recipient);
            let v2 = FeeCollectedEvent{
                chain_id  : v0.external_chain_id,
                amount    : v1,
                recipient : arg2.fee_recipient,
            };
            0x2::event::emit<FeeCollectedEvent>(v2);
        };
        let v3 = 0x2::coin::value<T0>(&arg10);
        assert!(v3 > 0, 8);
        let v4 = 0x1::type_name::get<T0>();
        let v5 = 0x1::type_name::into_string(v4);
        assert!(v5 == v0.sui_token_address, 9);
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg1.id, v4), 10);
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::verify_smg_id(arg5, arg6, arg7);
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, v4), arg10);
        let v6 = PartnerEvent{partner_name: arg12};
        0x2::event::emit<PartnerEvent>(v6);
        let v7 = UserBurnLogger{
            smg_id                 : arg7,
            token_pair_id          : arg8,
            sender                 : 0x2::tx_context::sender(arg13),
            recipient              : arg9,
            amount                 : v3,
            network_fee            : v1,
            sui_token_address      : v0.sui_token_address,
            external_chain_id      : v0.external_chain_id,
            external_token_address : v0.external_token_address,
            token_type             : v5,
        };
        0x2::event::emit<UserBurnLogger>(v7);
    }

    public entry fun user_lock<T0>(arg0: &TokenPairRegistry, arg1: &mut TokenVault, arg2: &FoundationConfig, arg3: &PauseConfig, arg4: &0x16b03acd7aa1fd34e913282b69ebd778951db2a4a55b4015f1d7f0d5a7f40b2d::fee_manager::FeeConfig, arg5: &0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::OracleStorage, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: u64, arg9: 0x1::ascii::String, arg10: 0x2::coin::Coin<T0>, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x1::ascii::String, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 14);
        assert!(0x2::table::contains<u64, TokenPair>(&arg0.pairs_by_id, arg8), 2);
        let v0 = 0x2::table::borrow<u64, TokenPair>(&arg0.pairs_by_id, arg8);
        assert!(v0.is_active, 7);
        assert!(v0.sui_token_type == 1, 6);
        let v1 = 0x16b03acd7aa1fd34e913282b69ebd778951db2a4a55b4015f1d7f0d5a7f40b2d::fee_manager::get_fee(arg4, v0.external_chain_id);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg11) >= v1, 13);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg11, v1, arg13), arg2.fee_recipient);
            let v2 = FeeCollectedEvent{
                chain_id  : v0.external_chain_id,
                amount    : v1,
                recipient : arg2.fee_recipient,
            };
            0x2::event::emit<FeeCollectedEvent>(v2);
        };
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0x1::type_name::into_string(v3);
        assert!(v4 == v0.sui_token_address, 9);
        let v5 = 0x2::coin::value<T0>(&arg10);
        assert!(v5 > 0, 8);
        0x1c8b984b5d896a916b356171ee7c48eb5b62d8685ffe8da6f5ac30cc1def8c6a::oracle::verify_smg_id(arg5, arg6, arg7);
        let v6 = TokenBalanceKey{type_name: v3};
        if (!0x2::dynamic_field::exists_<TokenBalanceKey>(&arg1.id, v6)) {
            let v7 = TokenBalance<T0>{balance: 0x2::balance::zero<T0>()};
            0x2::dynamic_field::add<TokenBalanceKey, TokenBalance<T0>>(&mut arg1.id, v6, v7);
        };
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<TokenBalanceKey, TokenBalance<T0>>(&mut arg1.id, v6).balance, 0x2::coin::into_balance<T0>(arg10));
        let v8 = PartnerEvent{partner_name: arg12};
        0x2::event::emit<PartnerEvent>(v8);
        let v9 = UserLockLogger{
            smg_id                 : arg7,
            token_pair_id          : arg8,
            sender                 : 0x2::tx_context::sender(arg13),
            recipient              : arg9,
            amount                 : v5,
            network_fee            : v1,
            sui_token_address      : v0.sui_token_address,
            external_chain_id      : v0.external_chain_id,
            external_token_address : v0.external_token_address,
            token_type             : v4,
        };
        0x2::event::emit<UserLockLogger>(v9);
    }

    // decompiled from Move bytecode v6
}

