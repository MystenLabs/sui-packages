module 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::outbound {
    struct OUTBOUND has drop {
        dummy_field: bool,
    }

    struct LockCap has store, key {
        id: 0x2::object::UID,
        request_id: 0x2::object::ID,
    }

    struct UnlockCap has store, key {
        id: 0x2::object::UID,
        request_id: 0x2::object::ID,
    }

    struct Digest has copy, drop, store {
        pos0: u64,
        pos1: vector<u8>,
    }

    struct OutTokenKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct OutToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        target_chain: u64,
        foreign_token: vector<u8>,
        foreign_decimals: u8,
        decimals: u8,
        locked_balance: 0x2::balance::Balance<T0>,
        max_lock: u64,
        chain_token: 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_token::ChainToken,
        rate_limit: 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::rate_limit::RateLimit,
    }

    struct LockRequest<phantom T0> has key {
        id: 0x2::object::UID,
        lock_cap: 0x2::object::ID,
        wallet_key: u64,
        target_chain: u64,
        foreign_token: vector<u8>,
        foreign_decimals: u8,
        recipient_address: vector<u8>,
        lock_amount: u64,
        foreign_amount: u256,
        message: vector<u8>,
        sign_id: 0x1::option::Option<0x2::object::ID>,
        status: u8,
        votes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct UnlockRequest<phantom T0> has key {
        id: 0x2::object::UID,
        unlock_cap: 0x2::object::ID,
        wallet_key: u64,
        source_chain: u64,
        foreign_token: vector<u8>,
        foreign_decimals: u8,
        sender_address: vector<u8>,
        sui_recipient: address,
        foreign_amount: u256,
        lock_amount: u64,
        digest: 0x1::option::Option<vector<u8>>,
        cancel_sign_id: 0x1::option::Option<0x2::object::ID>,
        status: u8,
        votes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct XBridgeOutbound has key {
        id: 0x2::object::UID,
        chains: 0x2::vec_set::VecSet<u64>,
        unlock_digests: 0x2::table::Table<Digest, bool>,
    }

    public fun add_chain(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<u64>(&mut arg0.chains, arg2);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_chain_added(arg2);
    }

    fun address_for_chain(arg0: &0x627db9e69f072af2119cbdc744b06216e67bc685d75ead2b0d9a5f7a5e0dca5::registry::Registry, arg1: u64, arg2: vector<u8>) : address {
        let v0 = if (arg1 == 1) {
            0x627db9e69f072af2119cbdc744b06216e67bc685d75ead2b0d9a5f7a5e0dca5::registry::get_sui_for_solana(arg0, arg2)
        } else {
            0x627db9e69f072af2119cbdc744b06216e67bc685d75ead2b0d9a5f7a5e0dca5::registry::get_sui_for_evm(arg0, arg2)
        };
        let v1 = v0;
        assert!(0x1::option::is_some<address>(&v1), 46);
        0x1::option::destroy_some<address>(v1)
    }

    fun assert_solana_message<T0>(arg0: &0x2::object::UID, arg1: vector<u8>, arg2: u256, arg3: vector<u8>, arg4: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_execute_data::ChainExecuteData, arg5: vector<u8>) {
        assert!(arg2 <= 18446744073709551615, 25);
        let v0 = OutTokenKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow<OutTokenKey<T0>, OutToken<T0>>(arg0, v0);
        assert!(arg5 == 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::solana::build_spl_transfer(arg1, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_token::source_ata(&v1.chain_token), v1.foreign_token, v1.foreign_decimals, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_execute_data::solana_durable_nonce(arg4), 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_execute_data::solana_nonce_account(arg4), 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_execute_data::solana_nonce_authority(arg4), arg3, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_execute_data::solana_destination_ata(arg4), (arg2 as u64)), 52);
    }

    public fun cancel_lock_request<T0>(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg2: &mut LockRequest<T0>, arg3: LockCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_version(arg1);
        assert!(arg3.request_id == 0x2::object::uid_to_inner(&arg2.id), 39);
        assert!(arg2.status == 0, 14);
        let v0 = OutTokenKey<T0>{dummy_field: false};
        arg2.status = 2;
        let LockCap {
            id         : v1,
            request_id : _,
        } = arg3;
        0x2::object::delete(v1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_lock_request_cancelled(0x2::object::uid_to_inner(&arg2.id), arg2.target_chain, arg2.lock_amount);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_object_field::borrow_mut<OutTokenKey<T0>, OutToken<T0>>(&mut arg0.id, v0).locked_balance, arg2.lock_amount), arg4)
    }

    public fun cancel_unlock_request<T0: drop, T1>(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg2: &mut 0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::xcore::XCore, arg3: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg4: &0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::Enclave<T0>, arg5: &mut UnlockRequest<T1>, arg6: UnlockCap, arg7: 0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::presign_cap::PresignCap, arg8: vector<u8>, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_execute_data::ChainExecuteData, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_version(arg1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_pcrs_configured(arg1);
        assert!(arg6.request_id == 0x2::object::uid_to_inner(&arg5.id), 40);
        assert!(arg5.status == 0, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg5.digest), 35);
        assert!(!0x1::vector::is_empty<u8>(&arg10), 13);
        assert!(0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::has_validator<T0>(arg1), 16);
        let v0 = 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::expected_pcr0(arg1);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::pcr0<T0>(arg4) == &v0, 29);
        let v1 = 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::expected_pcr2(arg1);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::pcr2<T0>(arg4) == &v1, 29);
        assert!(0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::presign_cap::wallet_key(&arg7) == 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::wallet_key(arg1, arg5.source_chain), 5);
        let v2 = *0x1::option::borrow<vector<u8>>(&arg5.digest);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::verify_signature<T0, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::CancelUnlockResponse>(arg4, 8, arg9, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::new_cancel_unlock_response(0x2::object::uid_to_inner(&arg5.id), arg5.wallet_key, arg5.source_chain, arg5.foreign_token, arg5.foreign_decimals, arg5.sender_address, arg5.foreign_amount, v2, arg11), &arg8), 0);
        if (arg5.source_chain == 1) {
            assert_solana_message<T1>(&arg0.id, arg12, arg5.foreign_amount, arg5.sender_address, &arg13, arg11);
        };
        let v3 = Digest{
            pos0 : arg5.source_chain,
            pos1 : v2,
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg0.unlock_digests, v3), 6);
        0x2::table::add<Digest, bool>(&mut arg0.unlock_digests, v3, true);
        let v4 = 0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::xcore::sign<0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::Witness>(arg2, arg3, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::witness(), arg7, arg10, arg11, arg14);
        arg5.cancel_sign_id = 0x1::option::some<0x2::object::ID>(v4);
        arg5.status = 2;
        let UnlockCap {
            id         : v5,
            request_id : _,
        } = arg6;
        0x2::object::delete(v5);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_unlock_request_cancelled(0x2::object::uid_to_inner(&arg5.id), arg5.source_chain, arg5.foreign_amount, v4);
        v4
    }

    public fun digest_consumed(arg0: &XBridgeOutbound, arg1: u64, arg2: vector<u8>) : bool {
        let v0 = Digest{
            pos0 : arg1,
            pos1 : arg2,
        };
        0x2::table::contains<Digest, bool>(&arg0.unlock_digests, v0)
    }

    public fun execute_lock_request<T0>(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg2: &mut 0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::xcore::XCore, arg3: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg4: &0x2::clock::Clock, arg5: &mut LockRequest<T0>, arg6: LockCap, arg7: 0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::presign_cap::PresignCap, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_version(arg1);
        assert!(arg6.request_id == 0x2::object::uid_to_inner(&arg5.id), 39);
        assert!(arg5.status == 0, 14);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg5.votes) >= 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::min_votes(arg1), 15);
        assert!(!0x1::vector::is_empty<u8>(&arg8), 13);
        assert!(0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::presign_cap::wallet_key(&arg7) == 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::wallet_key(arg1, arg5.target_chain), 5);
        let v0 = OutTokenKey<T0>{dummy_field: false};
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::rate_limit::track(&mut 0x2::dynamic_object_field::borrow_mut<OutTokenKey<T0>, OutToken<T0>>(&mut arg0.id, v0).rate_limit, arg5.lock_amount, 0x2::clock::timestamp_ms(arg4));
        let v1 = 0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::xcore::sign<0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::Witness>(arg2, arg3, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::witness(), arg7, arg8, arg5.message, arg9);
        arg5.sign_id = 0x1::option::some<0x2::object::ID>(v1);
        arg5.status = 1;
        let LockCap {
            id         : v2,
            request_id : _,
        } = arg6;
        0x2::object::delete(v2);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_lock_completed(0x2::object::uid_to_inner(&arg5.id), arg5.target_chain, arg5.foreign_token, arg5.recipient_address, arg5.lock_amount, arg5.foreign_amount, v1);
        v1
    }

    public fun execute_unlock_request<T0>(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg2: &0x2::clock::Clock, arg3: &mut UnlockRequest<T0>, arg4: UnlockCap, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_version(arg1);
        assert!(arg4.request_id == 0x2::object::uid_to_inner(&arg3.id), 40);
        assert!(arg3.status == 0, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg3.digest), 35);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg3.votes) >= 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::min_votes(arg1), 15);
        let v0 = *0x1::option::borrow<vector<u8>>(&arg3.digest);
        let v1 = Digest{
            pos0 : arg3.source_chain,
            pos1 : v0,
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg0.unlock_digests, v1), 6);
        0x2::table::add<Digest, bool>(&mut arg0.unlock_digests, v1, true);
        let v2 = OutTokenKey<T0>{dummy_field: false};
        let v3 = 0x2::dynamic_object_field::borrow_mut<OutTokenKey<T0>, OutToken<T0>>(&mut arg0.id, v2);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::rate_limit::track(&mut v3.rate_limit, arg3.lock_amount, 0x2::clock::timestamp_ms(arg2));
        assert!(0x2::balance::value<T0>(&v3.locked_balance) >= arg3.lock_amount, 42);
        arg3.status = 1;
        let UnlockCap {
            id         : v4,
            request_id : _,
        } = arg4;
        0x2::object::delete(v4);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_unlock_completed(0x2::object::uid_to_inner(&arg3.id), arg3.source_chain, arg3.foreign_token, arg3.sender_address, arg3.foreign_amount, arg3.lock_amount, v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3.locked_balance, arg3.lock_amount), arg5)
    }

    fun init(arg0: OUTBOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = XBridgeOutbound{
            id             : 0x2::object::new(arg1),
            chains         : 0x2::vec_set::empty<u64>(),
            unlock_digests : 0x2::table::new<Digest, bool>(arg1),
        };
        0x2::transfer::share_object<XBridgeOutbound>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<OUTBOUND>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun locked_balance<T0>(arg0: &XBridgeOutbound) : u64 {
        let v0 = OutTokenKey<T0>{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<OutTokenKey<T0>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<OutTokenKey<T0>, OutToken<T0>>(&arg0.id, v0).locked_balance)
    }

    public fun new_lock_request<T0>(arg0: &mut XBridgeOutbound, arg1: &mut 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg2: &0x627db9e69f072af2119cbdc744b06216e67bc685d75ead2b0d9a5f7a5e0dca5::registry::Registry, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_execute_data::ChainExecuteData, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : (LockRequest<T0>, LockCap, 0x2::coin::Coin<T0>) {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_version(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::lock_fee(arg1), 36);
        assert!(0x2::vec_set::contains<u64>(&arg0.chains, &arg3), 4);
        assert!(0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::has_wallet(arg1, arg3), 5);
        let v0 = OutTokenKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<OutTokenKey<T0>>(&arg0.id, v0), 38);
        let v1 = 0x2::coin::value<T0>(&arg8);
        assert!(v1 > 0, 7);
        let (v2, v3, v4) = validate_lock<T0>(0x2::dynamic_object_field::borrow<OutTokenKey<T0>, OutToken<T0>>(&arg0.id, v0), arg3, v1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::utils::assert_foreign_address_length(arg3, &arg4);
        assert!(0x2::tx_context::sender(arg10) == address_for_chain(arg2, arg3, arg4), 45);
        if (arg3 == 1) {
            assert_solana_message<T0>(&arg0.id, arg5, v4, arg4, &arg7, arg6);
        };
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::collect_fee(arg1, arg9);
        let v5 = 0x2::coin::into_balance<T0>(arg8);
        0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<OutTokenKey<T0>, OutToken<T0>>(&mut arg0.id, v0).locked_balance, 0x2::balance::split<T0>(&mut v5, v1));
        let v6 = 0x2::object::new(arg10);
        let v7 = LockRequest<T0>{
            id                : 0x2::object::new(arg10),
            lock_cap          : 0x2::object::uid_to_inner(&v6),
            wallet_key        : 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::wallet_key(arg1, arg3),
            target_chain      : arg3,
            foreign_token     : v2,
            foreign_decimals  : v3,
            recipient_address : arg4,
            lock_amount       : v1,
            foreign_amount    : v4,
            message           : arg6,
            sign_id           : 0x1::option::none<0x2::object::ID>(),
            status            : 0,
            votes             : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_lock_request_created(0x2::object::uid_to_inner(&v7.id), 0x2::tx_context::sender(arg10), arg3, v2, arg4, v1, v4);
        let v8 = LockCap{
            id         : v6,
            request_id : 0x2::object::uid_to_inner(&v7.id),
        };
        (v7, v8, 0x2::coin::from_balance<T0>(v5, arg10))
    }

    public fun new_unlock_request<T0>(arg0: &mut XBridgeOutbound, arg1: &mut 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg2: &0x627db9e69f072af2119cbdc744b06216e67bc685d75ead2b0d9a5f7a5e0dca5::registry::Registry, arg3: u64, arg4: vector<u8>, arg5: u256, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : (UnlockRequest<T0>, UnlockCap) {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_version(arg1);
        assert!(arg5 > 0, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::unlock_fee(arg1), 37);
        assert!(0x2::vec_set::contains<u64>(&arg0.chains, &arg3), 4);
        assert!(0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::has_wallet(arg1, arg3), 5);
        let v0 = OutTokenKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<OutTokenKey<T0>>(&arg0.id, v0), 38);
        let v1 = 0x2::dynamic_object_field::borrow<OutTokenKey<T0>, OutToken<T0>>(&arg0.id, v0);
        assert!(v1.target_chain == arg3, 4);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::utils::assert_foreign_address_length(arg3, &arg4);
        assert!(0x2::tx_context::sender(arg7) == address_for_chain(arg2, arg3, arg4), 47);
        let v2 = scale_amount(arg5, v1.foreign_decimals, v1.decimals);
        assert!(v2 > 0, 31);
        assert!(v2 <= 18446744073709551615, 25);
        let v3 = (v2 as u64);
        assert!(0x2::balance::value<T0>(&v1.locked_balance) >= v3, 42);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::collect_fee(arg1, arg6);
        let v4 = 0x2::object::new(arg7);
        let v5 = UnlockRequest<T0>{
            id               : 0x2::object::new(arg7),
            unlock_cap       : 0x2::object::uid_to_inner(&v4),
            wallet_key       : 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::wallet_key(arg1, arg3),
            source_chain     : arg3,
            foreign_token    : v1.foreign_token,
            foreign_decimals : v1.foreign_decimals,
            sender_address   : arg4,
            sui_recipient    : 0x2::tx_context::sender(arg7),
            foreign_amount   : arg5,
            lock_amount      : v3,
            digest           : 0x1::option::none<vector<u8>>(),
            cancel_sign_id   : 0x1::option::none<0x2::object::ID>(),
            status           : 0,
            votes            : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_unlock_request_created(0x2::object::uid_to_inner(&v5.id), 0x2::tx_context::sender(arg7), arg3, v1.foreign_token, arg4, 0x2::tx_context::sender(arg7), arg5);
        let v6 = UnlockCap{
            id         : v4,
            request_id : 0x2::object::uid_to_inner(&v5.id),
        };
        (v5, v6)
    }

    public fun out_token<T0>(arg0: &XBridgeOutbound) : &OutToken<T0> {
        let v0 = OutTokenKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<OutTokenKey<T0>>(&arg0.id, v0), 38);
        0x2::dynamic_object_field::borrow<OutTokenKey<T0>, OutToken<T0>>(&arg0.id, v0)
    }

    public fun register_token<T0>(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg2: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::AdminCap, arg3: u64, arg4: vector<u8>, arg5: u8, arg6: u8, arg7: 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_token::ChainToken, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = OutTokenKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_<OutTokenKey<T0>>(&arg0.id, v0), 44);
        assert!(0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::has_wallet(arg1, arg3), 5);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_token::assert_chain(&arg7, arg3);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::chain_token::assert_token_address(arg3, &arg4);
        assert!(arg5 <= 18, 48);
        assert!(arg6 <= 18, 27);
        let v1 = OutToken<T0>{
            id               : 0x2::object::new(arg8),
            target_chain     : arg3,
            foreign_token    : arg4,
            foreign_decimals : arg5,
            decimals         : arg6,
            locked_balance   : 0x2::balance::zero<T0>(),
            max_lock         : 0,
            chain_token      : arg7,
            rate_limit       : 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::rate_limit::new(),
        };
        0x2::dynamic_object_field::add<OutTokenKey<T0>, OutToken<T0>>(&mut arg0.id, v0, v1);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_out_token_registered(arg3, arg4, arg5, arg6);
    }

    public fun remove_chain(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::remove<u64>(&mut arg0.chains, &arg2);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_chain_removed(arg2);
    }

    fun scale_amount(arg0: u256, arg1: u8, arg2: u8) : u256 {
        if (arg2 >= arg1) {
            arg0 * (0x1::u64::pow(10, arg2 - arg1) as u256)
        } else {
            let v1 = (0x1::u64::pow(10, arg1 - arg2) as u256);
            assert!(arg0 % v1 == 0, 33);
            arg0 / v1
        }
    }

    public fun set_max_lock<T0>(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OutTokenKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<OutTokenKey<T0>>(&arg0.id, v0), 38);
        let v1 = 0x2::dynamic_object_field::borrow_mut<OutTokenKey<T0>, OutToken<T0>>(&mut arg0.id, v0);
        v1.max_lock = arg2;
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_max_lock_set(v1.target_chain, v1.foreign_token, arg2);
    }

    public fun set_rate_limit<T0>(arg0: &mut XBridgeOutbound, arg1: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::auth::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OutTokenKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<OutTokenKey<T0>>(&arg0.id, v0), 38);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::rate_limit::set(&mut 0x2::dynamic_object_field::borrow_mut<OutTokenKey<T0>, OutToken<T0>>(&mut arg0.id, v0).rate_limit, arg2, arg3);
    }

    public fun set_unlock_digest<T0>(arg0: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg1: &XBridgeOutbound, arg2: &mut UnlockRequest<T0>, arg3: &UnlockCap, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg0);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_version(arg0);
        assert!(arg3.request_id == 0x2::object::uid_to_inner(&arg2.id), 40);
        assert!(arg2.status == 0, 14);
        assert!(0x1::option::is_none<vector<u8>>(&arg2.digest), 34);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 57);
        let v0 = Digest{
            pos0 : arg2.source_chain,
            pos1 : arg4,
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg1.unlock_digests, v0), 6);
        arg2.digest = 0x1::option::some<vector<u8>>(arg4);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::emit_unlock_digest_set(0x2::object::uid_to_inner(&arg2.id), arg4);
    }

    public fun share_lock_request<T0>(arg0: LockRequest<T0>) {
        0x2::transfer::share_object<LockRequest<T0>>(arg0);
    }

    public fun share_unlock_request<T0>(arg0: UnlockRequest<T0>) {
        0x2::transfer::share_object<UnlockRequest<T0>>(arg0);
    }

    fun validate_lock<T0>(arg0: &OutToken<T0>, arg1: u64, arg2: u64) : (vector<u8>, u8, u256) {
        assert!(arg0.target_chain == arg1, 4);
        let v0 = scale_amount((arg2 as u256), arg0.decimals, arg0.foreign_decimals);
        assert!(v0 > 0, 31);
        assert!(arg0.max_lock > 0, 50);
        assert!(0x2::balance::value<T0>(&arg0.locked_balance) + arg2 <= arg0.max_lock, 43);
        (arg0.foreign_token, arg0.foreign_decimals, v0)
    }

    public fun vote_lock_request<T0: drop, T1>(arg0: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg1: &mut LockRequest<T1>, arg2: &0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::Enclave<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg0);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_pcrs_configured(arg0);
        assert!(arg1.status == 0, 14);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::has_validator<T0>(arg0), 16);
        let v1 = 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::expected_pcr0(arg0);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::pcr0<T0>(arg2) == &v1, 29);
        let v2 = 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::expected_pcr2(arg0);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::pcr2<T0>(arg2) == &v2, 29);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::verify_signature<T0, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::VoteLockResponse>(arg2, 6, arg4, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::new_vote_lock_response(0x2::object::uid_to_inner(&arg1.id), arg1.wallet_key, arg1.target_chain, arg1.foreign_token, arg1.foreign_decimals, arg1.recipient_address, arg1.foreign_amount, arg1.message), &arg3), 0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.votes, &v0), 24);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.votes, v0);
    }

    public fun vote_unlock_request<T0: drop, T1>(arg0: &0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::XBridgeConfig, arg1: &mut UnlockRequest<T1>, arg2: &0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::Enclave<T0>, arg3: vector<u8>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_not_paused(arg0);
        0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::assert_pcrs_configured(arg0);
        assert!(arg1.status == 0, 14);
        assert!(0x1::option::is_some<vector<u8>>(&arg1.digest), 35);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::has_validator<T0>(arg0), 16);
        let v1 = 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::expected_pcr0(arg0);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::pcr0<T0>(arg2) == &v1, 29);
        let v2 = 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::config::expected_pcr2(arg0);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::pcr2<T0>(arg2) == &v2, 29);
        assert!(0xd8210045df3ec6b95c2e814562d12403cd8e3204959b50f1e1dde34e9ec5724::enclave::verify_signature<T0, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::VoteUnlockResponse>(arg2, 7, arg4, 0x8766594ed06c6975e75fb2af5382a5f930a3f4c201a13ef0dfb0cb7c57870b03::structs::new_vote_unlock_response(0x2::object::uid_to_inner(&arg1.id), arg1.wallet_key, arg1.source_chain, arg1.foreign_token, arg1.foreign_decimals, arg1.sender_address, arg1.sui_recipient, arg1.foreign_amount, *0x1::option::borrow<vector<u8>>(&arg1.digest)), &arg3), 0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.votes, &v0), 24);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.votes, v0);
    }

    // decompiled from Move bytecode v6
}

