module 0x2efb658c5e588022dcb78e24bc36daa083057976652546c5bc05f4f6c0fca3db::ledger_inner {
    struct Chain has copy, drop, store {
        pos0: u8,
    }

    struct Token has copy, drop, store {
        pos0: Chain,
        pos1: vector<u8>,
    }

    struct Digest has copy, drop, store {
        pos0: Chain,
        pos1: vector<u8>,
    }

    struct UserBalanceKey has copy, drop, store {
        pos0: address,
        pos1: Token,
    }

    struct AppState has store, key {
        id: 0x2::object::UID,
        wallets: 0x2::object_table::ObjectTable<u64, Wallet>,
        balances: 0x2::table::Table<UserBalanceKey, u256>,
        consumed_digests: 0x2::table::Table<Digest, bool>,
        ika_balance: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        wallet_count: u64,
        paused: bool,
    }

    struct Wallet has store, key {
        id: 0x2::object::UID,
        dwallet_cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
        dwallet_network_encryption_key_id: 0x2::object::ID,
        dwallet: address,
        curve: u32,
        hash_scheme: u32,
        signature_algorithm: u32,
        unverified_presign_caps: vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>,
    }

    struct StateV1 has store, key {
        id: 0x2::object::UID,
        apps: 0x2::object_table::ObjectTable<0x1::type_name::TypeName, AppState>,
        allowed_chains: 0x2::vec_set::VecSet<u8>,
        registered_apps: vector<0x1::type_name::TypeName>,
    }

    public(friend) fun add_allowed_chain(arg0: &mut StateV1, arg1: u8) {
        0x2::vec_set::insert<u8>(&mut arg0.allowed_chains, arg1);
    }

    public(friend) fun add_ika_balance(arg0: &mut StateV1, arg1: 0x1::type_name::TypeName, arg2: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        let v0 = app_state_mut(arg0, arg1);
        assert!(!v0.paused, 14);
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut v0.ika_balance, arg2);
    }

    public(friend) fun add_presign(arg0: &mut StateV1, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : address {
        let v0 = app_state_mut(arg0, arg2);
        assert!(!v0.paused, 14);
        assert!(arg3 < v0.wallet_count, 8);
        assert!(0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&wallet(v0, arg3).unverified_presign_caps) < 100, 0);
        let (v1, v2) = withdraw_payment_coins(v0, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = wallet_mut(v0, arg3);
        let v6 = random_session_identifier(arg1, arg4);
        0x1::vector::push_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v5.unverified_presign_caps, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg1, v5.dwallet_network_encryption_key_id, v5.curve, v5.signature_algorithm, v6, &mut v4, &mut v3, arg4));
        0x2efb658c5e588022dcb78e24bc36daa083057976652546c5bc05f4f6c0fca3db::events::emit_presign_added(arg2, v5.dwallet, 0x2::object::id_address<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v5.dwallet_cap), 0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&v5.unverified_presign_caps));
        return_payment_coins(v0, v4, v3);
        v5.dwallet
    }

    public(friend) fun add_sui_balance(arg0: &mut StateV1, arg1: 0x1::type_name::TypeName, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = app_state_mut(arg0, arg1);
        assert!(!v0.paused, 14);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.sui_balance, arg2);
    }

    public(friend) fun add_wallet(arg0: &mut StateV1, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u32, arg9: u32, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) : (u64, address) {
        let v0 = app_state_mut(arg0, arg2);
        assert!(!v0.paused, 14);
        let (v1, v2) = withdraw_payment_coins(v0, arg11);
        let v3 = v2;
        let v4 = v1;
        let (v5, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg1, arg3, arg8, arg4, arg5, arg6, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, arg7, arg11), &mut v4, &mut v3, arg11);
        let v7 = v5;
        let v8 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v7);
        let v9 = 0x2::object::id_to_address(&v8);
        let v10 = Wallet{
            id                                : 0x2::object::new(arg11),
            dwallet_cap                       : v7,
            dwallet_network_encryption_key_id : arg3,
            dwallet                           : v9,
            curve                             : arg8,
            hash_scheme                       : arg9,
            signature_algorithm               : arg10,
            unverified_presign_caps           : 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(),
        };
        let v11 = v0.wallet_count;
        0x2efb658c5e588022dcb78e24bc36daa083057976652546c5bc05f4f6c0fca3db::events::emit_wallet_added(arg2, v10.dwallet, 0x2::object::id_address<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v10.dwallet_cap), arg3, v11, arg8, arg9, arg10);
        0x2::object_table::add<u64, Wallet>(&mut v0.wallets, v11, v10);
        v0.wallet_count = v0.wallet_count + 1;
        return_payment_coins(v0, v4, v3);
        (v11, v9)
    }

    fun app_state_mut(arg0: &mut StateV1, arg1: 0x1::type_name::TypeName) : &mut AppState {
        assert!(0x2::object_table::contains<0x1::type_name::TypeName, AppState>(&arg0.apps, arg1), 13);
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, AppState>(&mut arg0.apps, arg1)
    }

    fun chain(arg0: u8) : Chain {
        let v0 = &arg0;
        if (*v0 == 1) {
            Chain{pos0: arg0}
        } else {
            assert!(*v0 == 2, 10);
            Chain{pos0: arg0}
        }
    }

    public(friend) fun decrement_balance(arg0: &mut StateV1, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: u8, arg8: vector<u8>, arg9: u256, arg10: &mut 0x2::tx_context::TxContext) : (u256, 0x2::object::ID) {
        let v0 = app_state_mut(arg0, arg2);
        assert!(!v0.paused, 14);
        assert!(arg3 < v0.wallet_count, 8);
        let v1 = subtract_balance(v0, arg3, arg6, arg7, arg8, arg9);
        let (v2, v3) = withdraw_payment_coins(v0, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = &mut v5;
        let v7 = &mut v4;
        let v8 = wallet_mut(v0, arg3);
        assert!(!0x1::vector::is_empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&v8.unverified_presign_caps), 7);
        let v9 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, 0x1::vector::swap_remove<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut v8.unverified_presign_caps, 0), arg10);
        let v10 = random_session_identifier(arg1, arg10);
        let v11 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_partial_user_signature_cap(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_future_sign(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v8.dwallet_cap), v9, arg5, v8.hash_scheme, arg4, v10, v6, v7, arg10), arg10);
        let v12 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, &v8.dwallet_cap, v8.signature_algorithm, v8.hash_scheme, arg5);
        let v13 = random_session_identifier(arg1, arg10);
        let v14 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_with_partial_user_signature_and_return_id(arg1, v11, v12, v13, v6, v7, arg10);
        0x2efb658c5e588022dcb78e24bc36daa083057976652546c5bc05f4f6c0fca3db::events::emit_decrement_balance(arg2, arg3, arg6, arg7, arg8, arg9, v1, arg4, arg5, v14, v8.dwallet, 0x2::object::id_address<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v8.dwallet_cap));
        return_payment_coins(v0, v5, v4);
        (v1, v14)
    }

    fun get_or_create_balance_mut(arg0: &mut AppState, arg1: u8, arg2: address, arg3: vector<u8>) : &mut u256 {
        let v0 = user_balance_key(arg2, arg1, arg3);
        if (!0x2::table::contains<UserBalanceKey, u256>(&arg0.balances, v0)) {
            0x2::table::add<UserBalanceKey, u256>(&mut arg0.balances, v0, 0);
        };
        0x2::table::borrow_mut<UserBalanceKey, u256>(&mut arg0.balances, v0)
    }

    public(friend) fun increment_balance(arg0: &mut StateV1, arg1: 0x1::type_name::TypeName, arg2: vector<u8>, arg3: u64, arg4: address, arg5: u8, arg6: vector<u8>, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) : u256 {
        assert!(0x2::vec_set::contains<u8>(&arg0.allowed_chains, &arg5), 1);
        assert!(arg7 > 0, 2);
        let v0 = app_state_mut(arg0, arg1);
        assert!(!v0.paused, 14);
        assert!(arg3 < v0.wallet_count, 8);
        let v1 = Digest{
            pos0 : chain(arg5),
            pos1 : arg2,
        };
        assert!(!0x2::table::contains<Digest, bool>(&v0.consumed_digests, v1), 11);
        0x2::table::add<Digest, bool>(&mut v0.consumed_digests, v1, true);
        let v2 = get_or_create_balance_mut(v0, arg5, arg4, arg6);
        let v3 = *v2 + arg7;
        *v2 = v3;
        let v4 = wallet(v0, arg3);
        0x2efb658c5e588022dcb78e24bc36daa083057976652546c5bc05f4f6c0fca3db::events::emit_increment_balance(arg1, arg2, arg3, arg4, arg5, arg6, arg7, v3, v4.dwallet, 0x2::object::id_address<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v4.dwallet_cap));
        v3
    }

    public(friend) fun init_app(arg0: &mut StateV1, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::object_table::contains<0x1::type_name::TypeName, AppState>(&arg0.apps, arg1), 12);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.registered_apps) < 50, 15);
        let v0 = AppState{
            id               : 0x2::object::new(arg2),
            wallets          : 0x2::object_table::new<u64, Wallet>(arg2),
            balances         : 0x2::table::new<UserBalanceKey, u256>(arg2),
            consumed_digests : 0x2::table::new<Digest, bool>(arg2),
            ika_balance      : 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(),
            sui_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            wallet_count     : 0,
            paused           : true,
        };
        0x2::object_table::add<0x1::type_name::TypeName, AppState>(&mut arg0.apps, arg1, v0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.registered_apps, arg1);
        0x2efb658c5e588022dcb78e24bc36daa083057976652546c5bc05f4f6c0fca3db::events::emit_app_initialized(arg1);
    }

    public(friend) fun new_state_v1(arg0: &mut 0x2::tx_context::TxContext) : StateV1 {
        StateV1{
            id              : 0x2::object::new(arg0),
            apps            : 0x2::object_table::new<0x1::type_name::TypeName, AppState>(arg0),
            allowed_chains  : 0x2::vec_set::empty<u8>(),
            registered_apps : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun pause_app(arg0: &mut StateV1, arg1: 0x1::type_name::TypeName) {
        app_state_mut(arg0, arg1).paused = true;
    }

    fun random_session_identifier(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg0, 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg1)), arg1)
    }

    public(friend) fun remove_allowed_chain(arg0: &mut StateV1, arg1: u8) {
        0x2::vec_set::remove<u8>(&mut arg0.allowed_chains, &arg1);
    }

    fun return_payment_coins(arg0: &mut AppState, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun subtract_balance(arg0: &mut AppState, arg1: u64, arg2: address, arg3: u8, arg4: vector<u8>, arg5: u256) : u256 {
        assert!(arg1 < arg0.wallet_count, 8);
        assert!(arg5 > 0, 2);
        let v0 = user_balance_key(arg2, arg3, arg4);
        assert!(0x2::table::contains<UserBalanceKey, u256>(&arg0.balances, v0), 3);
        let v1 = 0x2::table::borrow_mut<UserBalanceKey, u256>(&mut arg0.balances, v0);
        assert!(*v1 >= arg5, 4);
        let v2 = *v1 - arg5;
        *v1 = v2;
        v2
    }

    fun token(arg0: u8, arg1: vector<u8>) : Token {
        let v0 = chain(arg0);
        let v1 = v0.pos0;
        let v2 = &v1;
        let v3 = if (*v2 == 1) {
            32
        } else {
            assert!(*v2 == 2, 10);
            20
        };
        assert!(0x1::vector::length<u8>(&arg1) == v3, 5);
        Token{
            pos0 : v0,
            pos1 : arg1,
        }
    }

    public(friend) fun unpause_app(arg0: &mut StateV1, arg1: 0x1::type_name::TypeName) {
        app_state_mut(arg0, arg1).paused = false;
    }

    public(friend) fun user_balance(arg0: &StateV1, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u8, arg4: vector<u8>) : 0x1::option::Option<u256> {
        if (!0x2::object_table::contains<0x1::type_name::TypeName, AppState>(&arg0.apps, arg1)) {
            return 0x1::option::none<u256>()
        };
        let v0 = 0x2::object_table::borrow<0x1::type_name::TypeName, AppState>(&arg0.apps, arg1);
        let v1 = user_balance_key(arg2, arg3, arg4);
        if (!0x2::table::contains<UserBalanceKey, u256>(&v0.balances, v1)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::some<u256>(*0x2::table::borrow<UserBalanceKey, u256>(&v0.balances, v1))
    }

    fun user_balance_key(arg0: address, arg1: u8, arg2: vector<u8>) : UserBalanceKey {
        UserBalanceKey{
            pos0 : arg0,
            pos1 : token(arg1, arg2),
        }
    }

    fun wallet(arg0: &AppState, arg1: u64) : &Wallet {
        0x2::object_table::borrow<u64, Wallet>(&arg0.wallets, arg1)
    }

    fun wallet_mut(arg0: &mut AppState, arg1: u64) : &mut Wallet {
        0x2::object_table::borrow_mut<u64, Wallet>(&mut arg0.wallets, arg1)
    }

    fun withdraw_payment_coins(arg0: &mut AppState, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg1))
    }

    // decompiled from Move bytecode v6
}

