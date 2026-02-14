module 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::inbound {
    struct INBOUND has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        request_id: 0x2::object::ID,
    }

    struct BurnCap has store, key {
        id: 0x2::object::UID,
        request_id: 0x2::object::ID,
    }

    struct Digest has copy, drop, store {
        pos0: u64,
        pos1: vector<u8>,
    }

    struct TokenKey has copy, drop, store {
        pos0: u64,
        pos1: vector<u8>,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MetadataCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct XToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        mint_decimals: u8,
        max_supply: u64,
        chain_token: 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_token::ChainToken,
        rate_limit: 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::rate_limit::RateLimit,
    }

    struct MintRequest has key {
        id: 0x2::object::UID,
        mint_cap: 0x2::object::ID,
        wallet_key: u64,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        source_address: vector<u8>,
        source_amount: u256,
        digest: 0x1::option::Option<vector<u8>>,
        cancel_sign_id: 0x1::option::Option<0x2::object::ID>,
        status: u8,
        votes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct BurnRequest<phantom T0> has key {
        id: 0x2::object::UID,
        wallet_key: u64,
        source_chain: u64,
        source_token: vector<u8>,
        source_decimals: u8,
        destination_address: vector<u8>,
        source_amount: u256,
        balance: 0x2::balance::Balance<XToken<T0>>,
        message: vector<u8>,
        sign_id: 0x1::option::Option<0x2::object::ID>,
        status: u8,
        votes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct XBridgeInbound has key {
        id: 0x2::object::UID,
        chains: 0x2::vec_set::VecSet<u64>,
        digests: 0x2::table::Table<Digest, bool>,
    }

    public fun total_supply<T0>(arg0: &XBridgeInbound, arg1: u64, arg2: vector<u8>) : u64 {
        let v0 = TokenKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::coin::total_supply<XToken<T0>>(0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<XToken<T0>>>(&0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0).id, v1))
    }

    public fun add_chain(arg0: &mut XBridgeInbound, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<u64>(&mut arg0.chains, arg2);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_chain_added(arg2);
    }

    public fun add_token<T0: drop>(arg0: &mut XBridgeInbound, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg4: u64, arg5: vector<u8>, arg6: u8, arg7: u8, arg8: 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_token::ChainToken, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenKey{
            pos0 : arg4,
            pos1 : arg5,
        };
        assert!(!0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 32);
        assert!(0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::has_wallet(arg1, arg4), 5);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_token::assert_chain(&arg8, arg4);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_token::assert_token_address(arg4, &arg5);
        assert!(arg6 <= 18, 18);
        assert!(arg7 <= 18, 27);
        let v1 = XToken<T0>{
            id              : 0x2::object::new(arg13),
            source_chain    : arg4,
            source_token    : arg5,
            source_decimals : arg6,
            mint_decimals   : arg7,
            max_supply      : 0,
            chain_token     : arg8,
            rate_limit      : 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::rate_limit::new(),
        };
        let (v2, v3) = 0x2::coin_registry::new_currency<XToken<T0>>(arg2, arg7, arg9, arg10, arg11, arg12, arg13);
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<XToken<T0>>>(&mut v1.id, v4, v3);
        let v5 = MetadataCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<MetadataCapKey, 0x2::coin_registry::MetadataCap<XToken<T0>>>(&mut v1.id, v5, 0x2::coin_registry::finalize<XToken<T0>>(v2, arg13));
        let v6 = TokenKey{
            pos0 : arg4,
            pos1 : arg5,
        };
        0x2::dynamic_object_field::add<TokenKey, XToken<T0>>(&mut arg0.id, v6, v1);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_token_added(arg4, arg5, arg6, arg7);
    }

    fun assert_solana_message<T0>(arg0: &0x2::object::UID, arg1: TokenKey, arg2: vector<u8>, arg3: u256, arg4: vector<u8>, arg5: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_execute_data::ChainExecuteData, arg6: vector<u8>) {
        assert!(arg3 <= 18446744073709551615, 25);
        let v0 = 0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(arg0, arg1);
        assert!(arg6 == 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::solana::build_spl_transfer(arg2, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_token::source_ata(&v0.chain_token), v0.source_token, v0.source_decimals, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_execute_data::solana_durable_nonce(arg5), 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_execute_data::solana_nonce_account(arg5), arg4, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_execute_data::solana_destination_ata(arg5), (arg3 as u64)), 52);
    }

    public fun available_mint_supply<T0>(arg0: &XBridgeInbound, arg1: u64, arg2: vector<u8>) : u64 {
        let v0 = TokenKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        let v1 = 0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0);
        if (v1.max_supply == 0) {
            return 0
        };
        let v2 = TreasuryCapKey{dummy_field: false};
        v1.max_supply - 0x2::coin::total_supply<XToken<T0>>(0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<XToken<T0>>>(&v1.id, v2))
    }

    public fun cancel_burn_request<T0>(arg0: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg1: &mut BurnRequest<T0>, arg2: BurnCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<XToken<T0>> {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg0);
        assert!(arg2.request_id == 0x2::object::uid_to_inner(&arg1.id), 20);
        assert!(arg1.status == 0, 14);
        arg1.status = 2;
        let BurnCap {
            id         : v0,
            request_id : _,
        } = arg2;
        0x2::object::delete(v0);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_burn_request_cancelled(0x2::object::uid_to_inner(&arg1.id), arg1.source_chain, arg1.source_token, arg1.source_amount);
        0x2::coin::from_balance<XToken<T0>>(0x2::balance::withdraw_all<XToken<T0>>(&mut arg1.balance), arg3)
    }

    public fun cancel_mint_request<T0: drop, T1>(arg0: &mut XBridgeInbound, arg1: &mut 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::XCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: &mut MintRequest, arg4: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg5: &0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::Enclave<T0>, arg6: MintCap, arg7: 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::presign_cap::PresignCap<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_execute_data::ChainExecuteData, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg4);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_version(arg4);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_pcrs_configured(arg4);
        assert!(arg6.request_id == 0x2::object::uid_to_inner(&arg3.id), 17);
        assert!(0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::presign_cap::wallet_key<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(&arg7) == arg3.wallet_key, 5);
        assert!(arg3.status == 0, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg3.digest), 35);
        assert!(0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::has_validator<T0>(arg4), 16);
        let v0 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::expected_pcr0(arg4);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::pcr0<T0>(arg5) == &v0, 29);
        let v1 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::expected_pcr2(arg4);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::pcr2<T0>(arg5) == &v1, 29);
        let v2 = *0x1::option::borrow<vector<u8>>(&arg3.digest);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::verify_signature<T0, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::CancelMintResponse>(arg5, 3, arg10, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::new_cancel_mint_response(0x2::object::uid_to_inner(&arg3.id), arg3.wallet_key, arg3.source_chain, arg3.source_token, arg3.source_decimals, arg3.source_address, arg3.source_amount, v2, arg11), &arg8), 0);
        if (arg3.source_chain == 1) {
            let v3 = TokenKey{
                pos0 : arg3.source_chain,
                pos1 : arg3.source_token,
            };
            assert_solana_message<T1>(&arg0.id, v3, arg12, arg3.source_amount, arg3.source_address, &arg13, arg11);
        };
        let v4 = Digest{
            pos0 : arg3.source_chain,
            pos1 : v2,
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg0.digests, v4), 6);
        0x2::table::add<Digest, bool>(&mut arg0.digests, v4, true);
        let v5 = 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::sign<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(arg1, arg2, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::witness(), arg7, arg9, arg11, arg14);
        arg3.cancel_sign_id = 0x1::option::some<0x2::object::ID>(v5);
        arg3.status = 2;
        let MintCap {
            id         : v6,
            request_id : _,
        } = arg6;
        0x2::object::delete(v6);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_mint_request_cancelled(0x2::object::uid_to_inner(&arg3.id), arg3.source_chain, arg3.source_token, arg3.source_amount, v5);
        v5
    }

    public fun digest_consumed(arg0: &XBridgeInbound, arg1: u64, arg2: vector<u8>) : bool {
        let v0 = Digest{
            pos0 : arg1,
            pos1 : arg2,
        };
        0x2::table::contains<Digest, bool>(&arg0.digests, v0)
    }

    public fun execute_burn_request<T0>(arg0: &mut XBridgeInbound, arg1: &mut 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::XCore, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: &mut BurnRequest<T0>, arg4: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg5: &0x2::clock::Clock, arg6: BurnCap, arg7: 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::presign_cap::PresignCap<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg4);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_version(arg4);
        assert!(arg6.request_id == 0x2::object::uid_to_inner(&arg3.id), 20);
        assert!(0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::presign_cap::wallet_key<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(&arg7) == arg3.wallet_key, 5);
        assert!(arg3.status == 0, 14);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg3.votes) >= 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::min_votes(arg4), 15);
        let v0 = TokenKey{
            pos0 : arg3.source_chain,
            pos1 : arg3.source_token,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        let v1 = 0x2::dynamic_object_field::borrow_mut<TokenKey, XToken<T0>>(&mut arg0.id, v0);
        assert!(arg3.source_decimals == v1.source_decimals, 18);
        let v2 = 0x2::balance::value<XToken<T0>>(&arg3.balance);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::rate_limit::track(&mut v1.rate_limit, v2, 0x2::clock::timestamp_ms(arg5));
        let v3 = arg3.message;
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::balance::decrease_supply<XToken<T0>>(0x2::coin::supply_mut<XToken<T0>>(0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<XToken<T0>>>(&mut v1.id, v4)), 0x2::balance::withdraw_all<XToken<T0>>(&mut arg3.balance));
        let v5 = 0x1f9ded5e071cc9cb59dc1c4a0249e5674b82af44241092a0f40fc7a9bf6ea251::xcore::sign<0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::Witness>(arg1, arg2, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::witness(), arg7, arg8, v3, arg9);
        arg3.sign_id = 0x1::option::some<0x2::object::ID>(v5);
        arg3.status = 1;
        let BurnCap {
            id         : v6,
            request_id : _,
        } = arg6;
        0x2::object::delete(v6);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_burn_completed(0x2::object::uid_to_inner(&arg3.id), arg3.source_chain, arg3.source_token, arg3.destination_address, arg3.source_amount, v2, v5);
        v3
    }

    public fun execute_mint_request<T0>(arg0: &mut XBridgeInbound, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg2: &0x2::clock::Clock, arg3: &mut MintRequest, arg4: MintCap, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<XToken<T0>> {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg1);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_version(arg1);
        assert!(arg4.request_id == 0x2::object::uid_to_inner(&arg3.id), 17);
        assert!(arg3.status == 0, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg3.digest), 35);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg3.votes) >= 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::min_votes(arg1), 15);
        let v0 = *0x1::option::borrow<vector<u8>>(&arg3.digest);
        let v1 = Digest{
            pos0 : arg3.source_chain,
            pos1 : v0,
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg0.digests, v1), 6);
        0x2::table::add<Digest, bool>(&mut arg0.digests, v1, true);
        let v2 = TokenKey{
            pos0 : arg3.source_chain,
            pos1 : arg3.source_token,
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<TokenKey, XToken<T0>>(&mut arg0.id, v2);
        let v4 = (0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::utils::scale_amount(arg3.source_amount, arg3.source_decimals, v3.mint_decimals) as u64);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::rate_limit::track(&mut v3.rate_limit, v4, 0x2::clock::timestamp_ms(arg2));
        let v5 = TreasuryCapKey{dummy_field: false};
        let v6 = 0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<XToken<T0>>>(&mut v3.id, v5);
        assert!(v3.max_supply > 0, 30);
        assert!(0x2::coin::total_supply<XToken<T0>>(v6) + v4 <= v3.max_supply, 30);
        arg3.status = 1;
        let MintCap {
            id         : v7,
            request_id : _,
        } = arg4;
        0x2::object::delete(v7);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_mint_completed(0x2::object::uid_to_inner(&arg3.id), arg3.source_chain, arg3.source_token, arg3.source_amount, v4, v0);
        0x2::coin::mint<XToken<T0>>(v6, v4, arg5)
    }

    fun init(arg0: INBOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = XBridgeInbound{
            id      : 0x2::object::new(arg1),
            chains  : 0x2::vec_set::empty<u64>(),
            digests : 0x2::table::new<Digest, bool>(arg1),
        };
        0x2::transfer::share_object<XBridgeInbound>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<INBOUND>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun new_burn_request<T0>(arg0: &mut XBridgeInbound, arg1: &mut 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u256, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::chain_execute_data::ChainExecuteData, arg10: 0x2::coin::Coin<XToken<T0>>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: &mut 0x2::tx_context::TxContext) : (BurnRequest<T0>, BurnCap, 0x2::coin::Coin<XToken<T0>>) {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg1);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_version(arg1);
        assert!(arg6 > 0, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg11) >= 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::burn_fee(arg1), 9);
        assert!(0x2::vec_set::contains<u64>(&arg0.chains, &arg2), 4);
        assert!(0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::has_wallet(arg1, arg2), 5);
        let v0 = TokenKey{
            pos0 : arg2,
            pos1 : arg3,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        let v1 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::utils::scale_amount(arg6, arg4, 0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0).mint_decimals);
        assert!(v1 > 0, 31);
        assert!(v1 <= 18446744073709551615, 25);
        let v2 = (v1 as u64);
        assert!(0x2::coin::value<XToken<T0>>(&arg10) >= v2, 19);
        if (arg2 == 1) {
            assert_solana_message<T0>(&arg0.id, v0, arg7, arg6, arg5, &arg9, arg8);
        };
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::collect_fee(arg1, arg11);
        let v3 = 0x2::coin::into_balance<XToken<T0>>(arg10);
        let v4 = BurnRequest<T0>{
            id                  : 0x2::object::new(arg12),
            wallet_key          : 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::wallet_key(arg1, arg2),
            source_chain        : arg2,
            source_token        : arg3,
            source_decimals     : arg4,
            destination_address : arg5,
            source_amount       : arg6,
            balance             : 0x2::balance::split<XToken<T0>>(&mut v3, v2),
            message             : arg8,
            sign_id             : 0x1::option::none<0x2::object::ID>(),
            status              : 0,
            votes               : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_burn_request_created(0x2::object::uid_to_inner(&v4.id), 0x2::tx_context::sender(arg12), arg2, arg3, arg4, arg5, arg6);
        let v5 = BurnCap{
            id         : 0x2::object::new(arg12),
            request_id : 0x2::object::uid_to_inner(&v4.id),
        };
        (v4, v5, 0x2::coin::from_balance<XToken<T0>>(v3, arg12))
    }

    public fun new_mint_request<T0>(arg0: &mut XBridgeInbound, arg1: &mut 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg2: &0x109561412bf0ffe7b1b6b6af126355e05d6e45a9b9cbb01896074b2efa74fb33::registry::Registry, arg3: u64, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: u256, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : (MintRequest, MintCap) {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg1);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_version(arg1);
        assert!(arg7 > 0, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::mint_fee(arg1), 8);
        assert!(0x2::vec_set::contains<u64>(&arg0.chains, &arg3), 4);
        assert!(0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::has_wallet(arg1, arg3), 5);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::utils::assert_foreign_address_length(arg3, &arg6);
        assert!(0x2::tx_context::sender(arg9) == sui_address_for_chain(arg2, arg3, arg6), 23);
        let v0 = TokenKey{
            pos0 : arg3,
            pos1 : arg4,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 38);
        let v1 = 0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0);
        assert!(arg5 == v1.source_decimals, 60);
        let v2 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::utils::scale_amount(arg7, arg5, v1.mint_decimals);
        assert!(v2 > 0, 31);
        assert!(v2 <= 18446744073709551615, 25);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::collect_fee(arg1, arg8);
        let v3 = 0x2::object::new(arg9);
        let v4 = MintRequest{
            id              : 0x2::object::new(arg9),
            mint_cap        : 0x2::object::uid_to_inner(&v3),
            wallet_key      : 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::wallet_key(arg1, arg3),
            source_chain    : arg3,
            source_token    : arg4,
            source_decimals : arg5,
            source_address  : arg6,
            source_amount   : arg7,
            digest          : 0x1::option::none<vector<u8>>(),
            cancel_sign_id  : 0x1::option::none<0x2::object::ID>(),
            status          : 0,
            votes           : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_mint_request_created(0x2::object::uid_to_inner(&v4.id), 0x2::tx_context::sender(arg9), arg3, arg4, arg5, arg6, arg7);
        let v5 = MintCap{
            id         : v3,
            request_id : 0x2::object::uid_to_inner(&v4.id),
        };
        (v4, v5)
    }

    public fun remove_chain(arg0: &mut XBridgeInbound, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::remove<u64>(&mut arg0.chains, &arg2);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_chain_removed(arg2);
    }

    public fun set_max_supply<T0>(arg0: &mut XBridgeInbound, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenKey{
            pos0 : arg2,
            pos1 : arg3,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        0x2::dynamic_object_field::borrow_mut<TokenKey, XToken<T0>>(&mut arg0.id, v0).max_supply = arg4;
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_max_supply_set(arg2, arg3, arg4);
    }

    public fun set_metadata_description<T0>(arg0: &XBridgeInbound, arg1: &mut 0x2::coin_registry::Currency<XToken<T0>>, arg2: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg3: u64, arg4: vector<u8>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenKey{
            pos0 : arg3,
            pos1 : arg4,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        let v1 = MetadataCapKey{dummy_field: false};
        0x2::coin_registry::set_description<XToken<T0>>(arg1, 0x2::dynamic_object_field::borrow<MetadataCapKey, 0x2::coin_registry::MetadataCap<XToken<T0>>>(&0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0).id, v1), arg5);
    }

    public fun set_metadata_icon_url<T0>(arg0: &XBridgeInbound, arg1: &mut 0x2::coin_registry::Currency<XToken<T0>>, arg2: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg3: u64, arg4: vector<u8>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenKey{
            pos0 : arg3,
            pos1 : arg4,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        let v1 = MetadataCapKey{dummy_field: false};
        0x2::coin_registry::set_icon_url<XToken<T0>>(arg1, 0x2::dynamic_object_field::borrow<MetadataCapKey, 0x2::coin_registry::MetadataCap<XToken<T0>>>(&0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0).id, v1), arg5);
    }

    public fun set_metadata_name<T0>(arg0: &XBridgeInbound, arg1: &mut 0x2::coin_registry::Currency<XToken<T0>>, arg2: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg3: u64, arg4: vector<u8>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenKey{
            pos0 : arg3,
            pos1 : arg4,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        let v1 = MetadataCapKey{dummy_field: false};
        0x2::coin_registry::set_name<XToken<T0>>(arg1, 0x2::dynamic_object_field::borrow<MetadataCapKey, 0x2::coin_registry::MetadataCap<XToken<T0>>>(&0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0).id, v1), arg5);
    }

    public fun set_mint_digest(arg0: &XBridgeInbound, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg2: &mut MintRequest, arg3: &MintCap, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg1);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_version(arg1);
        assert!(arg3.request_id == 0x2::object::uid_to_inner(&arg2.id), 17);
        assert!(arg2.status == 0, 14);
        assert!(0x1::option::is_none<vector<u8>>(&arg2.digest), 34);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 57);
        let v0 = Digest{
            pos0 : arg2.source_chain,
            pos1 : arg4,
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg0.digests, v0), 6);
        arg2.digest = 0x1::option::some<vector<u8>>(arg4);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::emit_mint_digest_set(0x2::object::uid_to_inner(&arg2.id), arg4);
    }

    public fun set_rate_limit<T0>(arg0: &mut XBridgeInbound, arg1: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth::AdminCap, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenKey{
            pos0 : arg2,
            pos1 : arg3,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::rate_limit::set(&mut 0x2::dynamic_object_field::borrow_mut<TokenKey, XToken<T0>>(&mut arg0.id, v0).rate_limit, arg4, arg5);
    }

    public fun share_burn_request<T0>(arg0: BurnRequest<T0>) {
        0x2::transfer::share_object<BurnRequest<T0>>(arg0);
    }

    public fun share_mint_request(arg0: MintRequest) {
        0x2::transfer::share_object<MintRequest>(arg0);
    }

    fun sui_address_for_chain(arg0: &0x109561412bf0ffe7b1b6b6af126355e05d6e45a9b9cbb01896074b2efa74fb33::registry::Registry, arg1: u64, arg2: vector<u8>) : address {
        let v0 = if (arg1 == 1) {
            0x109561412bf0ffe7b1b6b6af126355e05d6e45a9b9cbb01896074b2efa74fb33::registry::get_sui_for_solana(arg0, arg2)
        } else {
            0x109561412bf0ffe7b1b6b6af126355e05d6e45a9b9cbb01896074b2efa74fb33::registry::get_sui_for_evm(arg0, arg2)
        };
        let v1 = v0;
        assert!(0x1::option::is_some<address>(&v1), 22);
        0x1::option::destroy_some<address>(v1)
    }

    public fun vote_burn_request<T0: drop, T1>(arg0: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg1: &mut BurnRequest<T1>, arg2: &0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::Enclave<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg0);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_pcrs_configured(arg0);
        assert!(arg1.status == 0, 14);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::has_validator<T0>(arg0), 16);
        let v1 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::expected_pcr0(arg0);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::pcr0<T0>(arg2) == &v1, 29);
        let v2 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::expected_pcr2(arg0);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::pcr2<T0>(arg2) == &v2, 29);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::verify_signature<T0, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::VoteBurnResponse>(arg2, 2, arg4, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::new_vote_burn_response(0x2::object::uid_to_inner(&arg1.id), arg1.wallet_key, arg1.source_chain, arg1.source_token, arg1.source_decimals, arg1.destination_address, arg1.source_amount, arg1.message), &arg3), 0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.votes, &v0), 24);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.votes, v0);
    }

    public fun vote_mint_request<T0: drop>(arg0: &0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::XBridgeConfig, arg1: &mut MintRequest, arg2: &0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::Enclave<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_not_paused(arg0);
        0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::assert_pcrs_configured(arg0);
        assert!(arg1.status == 0, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.digest), 35);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::has_validator<T0>(arg0), 16);
        let v1 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::expected_pcr0(arg0);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::pcr0<T0>(arg2) == &v1, 29);
        let v2 = 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::config::expected_pcr2(arg0);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::pcr2<T0>(arg2) == &v2, 29);
        assert!(0x6c8afdb6988ce65e3ff7c20941cc12a5773b040c83747f762e56b78a5ec15dc4::enclave::verify_signature<T0, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::VoteResponse>(arg2, 2, arg4, 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::structs::new_vote_response(0x2::object::uid_to_inner(&arg1.id), arg1.wallet_key, arg1.source_chain, arg1.source_token, arg1.source_decimals, arg1.source_address, arg1.source_amount, *0x1::option::borrow<vector<u8>>(&arg1.digest)), &arg3), 0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.votes, &v0), 24);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.votes, v0);
    }

    public fun xtoken<T0>(arg0: &XBridgeInbound, arg1: u64, arg2: vector<u8>) : &XToken<T0> {
        let v0 = TokenKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<TokenKey>(&arg0.id, v0), 11);
        0x2::dynamic_object_field::borrow<TokenKey, XToken<T0>>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

