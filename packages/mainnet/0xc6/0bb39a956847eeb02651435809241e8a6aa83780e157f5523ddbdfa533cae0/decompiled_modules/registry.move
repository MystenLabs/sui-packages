module 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        operators: 0x2::vec_set::VecSet<address>,
        dwallet_network_encryption_key_id: 0x1::option::Option<0x2::object::ID>,
        dwallet_caps: 0x2::table::Table<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>,
        owners: 0x2::table::Table<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>,
        sessions: 0x2::table::Table<SessionKey, Session>,
        presigns: 0x2::table::Table<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>,
        ika_balance: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SessionKey has copy, drop, store {
        dwallet_id: 0x2::object::ID,
        key: vector<u8>,
    }

    struct Session has drop, store {
        until_ms: u64,
        remaining: u64,
    }

    struct PresignAdded has copy, drop {
        presign_cap_id: 0x2::object::ID,
    }

    struct PresignDiscarded has copy, drop {
        presign_cap_id: 0x2::object::ID,
    }

    struct DWalletCreated has copy, drop {
        dwallet_id: 0x2::object::ID,
        dwallet_cap_id: 0x2::object::ID,
        sign_id: 0x2::object::ID,
        presign_cap_id: 0x2::object::ID,
        owner_chain: u8,
        owner_address: vector<u8>,
    }

    struct SessionStarted has copy, drop {
        dwallet_id: 0x2::object::ID,
        key: vector<u8>,
        until_ms: u64,
        signatures: u64,
    }

    struct SessionEnded has copy, drop {
        dwallet_id: 0x2::object::ID,
        key: vector<u8>,
    }

    struct SignRequested has copy, drop {
        dwallet_id: 0x2::object::ID,
        sign_id: 0x2::object::ID,
        presign_cap_id: 0x2::object::ID,
    }

    public fun add_operator(arg0: &mut Registry, arg1: &AdminCap, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg0.operators, &arg2), 8);
        0x2::vec_set::insert<address>(&mut arg0.operators, arg2);
    }

    fun add_presign(arg0: &mut Registry, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap) {
        let v0 = 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg1);
        0x2::table::add<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg0.presigns, v0, arg1);
        let v1 = PresignAdded{presign_cap_id: v0};
        0x2::event::emit<PresignAdded>(v1);
    }

    public fun add_presigns(arg0: &mut Registry, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg0, arg3);
        assert!(arg2 > 0 && arg2 <= 50, 7);
        let v0 = network_encryption_key_id(arg0);
        let (v1, v2) = withdraw_payment_coins(arg0, arg3);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0;
        while (v5 < arg2) {
            let v6 = random_session(arg1, arg3);
            add_presign(arg0, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg1, v0, 2, 0, v6, &mut v4, &mut v3, arg3));
            v5 = v5 + 1;
        };
        return_payment_coins(arg0, v4, v3);
    }

    fun assert_operator(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(!arg0.paused, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 0);
    }

    fun assert_owner_approved(arg0: &Registry, arg1: 0x2::object::ID, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) {
        assert!(0x2::table::contains<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg1), 5);
        let v0 = 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::footer(registry_bytes(arg0), b"dWallet", 0x2::object::id_to_bytes(&arg1), arg2);
        assert!(0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::approves_footer(0x2::table::borrow<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg1), arg3, arg4, &v0), 11);
    }

    public fun create_dwallet_and_sign(arg0: &mut Registry, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u8, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: vector<u8>, arg16: vector<u8>, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert_operator(arg0, arg20);
        let v0 = 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::new(arg11, arg12);
        let v1 = x"00";
        0x1::vector::append<u8>(&mut v1, arg8);
        let v2 = if (0x1::vector::length<u8>(&arg8) == 32) {
            if (arg6 == 0x2::address::from_bytes(0x2::hash::blake2b256(&v1))) {
                let v3 = 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::binding_payload(&v0, registry_bytes(arg0), &arg3);
                0x2::ed25519::ed25519_verify(&arg15, &arg8, &v3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 17);
        let v4 = 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::footer(registry_bytes(arg0), b"signer", arg8, &arg9);
        if (!0x1::vector::is_empty<u8>(&arg16)) {
            0x1::vector::append<u8>(&mut v4, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::session_lines(arg16, arg17, arg18));
        };
        assert!(0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::approves_footer(&v0, &arg13, &arg14, &v4), 11);
        let v5 = network_encryption_key_id(arg0);
        let (v6, v7) = withdraw_payment_coins(arg0, arg20);
        let v8 = v7;
        let v9 = v6;
        let v10 = take_presign(arg0, arg2);
        let (v11, v12) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg(arg1, v5, 2, arg4, arg5, arg6, arg7, arg8, 0x1::option::some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::sign_during_dkg_request(arg1, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, v10, arg20), 0, arg9, arg10)), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, arg3, arg20), &mut v9, &mut v8, arg20);
        let v13 = v12;
        let v14 = v11;
        assert!(0x1::option::is_some<0x2::object::ID>(&v13), 10);
        let v15 = 0x1::option::extract<0x2::object::ID>(&mut v13);
        let v16 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v14);
        assert!(!0x2::table::contains<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.dwallet_caps, v16), 6);
        let v17 = DWalletCreated{
            dwallet_id     : v16,
            dwallet_cap_id : 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v14),
            sign_id        : v15,
            presign_cap_id : arg2,
            owner_chain    : 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::chain(&v0),
            owner_address  : 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::addr(&v0),
        };
        0x2::event::emit<DWalletCreated>(v17);
        0x2::table::add<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.dwallet_caps, v16, v14);
        0x2::table::add<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&mut arg0.owners, v16, v0);
        if (!0x1::vector::is_empty<u8>(&arg16)) {
            start_session(arg0, v16, arg16, arg17, arg18, arg19);
        };
        return_payment_coins(arg0, v9, v8);
        (v16, v15)
    }

    public fun deposit_ika(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
    }

    public fun deposit_sui(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun discard_presign(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        assert_operator(arg0, arg2);
        let v0 = PresignDiscarded{presign_cap_id: arg1};
        0x2::event::emit<PresignDiscarded>(v0);
        take_presign(arg0, arg1)
    }

    public fun dwallet_count(arg0: &Registry) : u64 {
        0x2::table::length<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.dwallet_caps)
    }

    public fun end_session(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = SessionKey{
            dwallet_id : arg1,
            key        : arg2,
        };
        assert!(0x2::table::contains<SessionKey, Session>(&arg0.sessions, v0), 14);
        let v1 = x"496b61204163636f756e747320656e642073657373696f6e0a52656769737472793a203078";
        0x1::vector::append<u8>(&mut v1, 0x2::hex::encode(registry_bytes(arg0)));
        0x1::vector::append<u8>(&mut v1, x"0a6457616c6c65743a203078");
        0x1::vector::append<u8>(&mut v1, 0x2::hex::encode(0x2::object::id_to_bytes(&arg1)));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v0.key, &v1), 16);
        0x2::table::borrow_mut<SessionKey, Session>(&mut arg0.sessions, v0).remaining = 0;
        let v2 = SessionEnded{
            dwallet_id : arg1,
            key        : v0.key,
        };
        0x2::event::emit<SessionEnded>(v2);
    }

    public fun end_session_by_owner(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = SessionKey{
            dwallet_id : arg1,
            key        : arg2,
        };
        assert!(0x2::table::contains<SessionKey, Session>(&arg0.sessions, v0) && 0x2::table::contains<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg1), 14);
        let v1 = 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::end_session_footer(registry_bytes(arg0), 0x2::object::id_to_bytes(&arg1), v0.key);
        assert!(0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::approves_footer(0x2::table::borrow<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg1), &arg3, &arg4, &v1), 11);
        0x2::table::borrow_mut<SessionKey, Session>(&mut arg0.sessions, v0).remaining = 0;
        let v2 = SessionEnded{
            dwallet_id : arg1,
            key        : v0.key,
        };
        0x2::event::emit<SessionEnded>(v2);
    }

    public fun has_dwallet(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.dwallet_caps, arg1)
    }

    public fun has_presign(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns, arg1)
    }

    public fun ika_balance(arg0: &Registry) : u64 {
        0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.ika_balance)
    }

    public fun import_presigns(arg0: &mut Registry, arg1: vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>, arg2: &0x2::tx_context::TxContext) {
        assert_operator(arg0, arg2);
        0x1::vector::reverse<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg1)) {
            add_presign(arg0, 0x1::vector::pop_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(new_registry(arg0));
    }

    public fun is_operator(arg0: &Registry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public fun is_presign_ready(arg0: &Registry, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns, arg2) && 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::is_presign_valid(arg1, 0x2::table::borrow<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns, arg2))
    }

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg0.version < 1, 2);
        arg0.version = 1;
    }

    fun network_encryption_key_id(arg0: &Registry) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.dwallet_network_encryption_key_id), 3);
        *0x1::option::borrow<0x2::object::ID>(&arg0.dwallet_network_encryption_key_id)
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id                                : 0x2::object::new(arg0),
            version                           : 1,
            paused                            : false,
            operators                         : 0x2::vec_set::empty<address>(),
            dwallet_network_encryption_key_id : 0x1::option::none<0x2::object::ID>(),
            dwallet_caps                      : 0x2::table::new<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg0),
            owners                            : 0x2::table::new<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(arg0),
            sessions                          : 0x2::table::new<SessionKey, Session>(arg0),
            presigns                          : 0x2::table::new<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(arg0),
            ika_balance                       : 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(),
            sui_balance                       : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun owner_of(arg0: &Registry, arg1: 0x2::object::ID) : (u8, vector<u8>) {
        assert!(0x2::table::contains<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg1), 5);
        let v0 = 0x2::table::borrow<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg1);
        (0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::chain(v0), 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::addr(v0))
    }

    public fun presign_count(arg0: &Registry) : u64 {
        0x2::table::length<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns)
    }

    fun random_session(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg0, 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg1)), arg1)
    }

    fun registry_bytes(arg0: &Registry) : vector<u8> {
        let v0 = 0x2::object::id<Registry>(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    public fun remove_operator(arg0: &mut Registry, arg1: &AdminCap, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &arg2), 9);
        0x2::vec_set::remove<address>(&mut arg0.operators, &arg2);
    }

    fun request_sign(arg0: &Registry, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::VerifiedPresignCap, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, 0x2::table::borrow<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.dwallet_caps, arg2), 0, 0, arg4);
        let v1 = random_session(arg1, arg8);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg1, arg3, v0, arg5, v1, arg6, arg7, arg8)
    }

    fun return_payment_coins(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun session(arg0: &Registry, arg1: 0x2::object::ID, arg2: vector<u8>) : (u64, u64) {
        let v0 = SessionKey{
            dwallet_id : arg1,
            key        : arg2,
        };
        assert!(0x2::table::contains<SessionKey, Session>(&arg0.sessions, v0), 14);
        let v1 = 0x2::table::borrow<SessionKey, Session>(&arg0.sessions, v0);
        (v1.until_ms, v1.remaining)
    }

    public fun set_network_encryption_key(arg0: &mut Registry, arg1: &AdminCap, arg2: 0x2::object::ID) {
        arg0.dwallet_network_encryption_key_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public fun set_paused(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun sign(arg0: &mut Registry, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_operator(arg0, arg12);
        assert!(0x2::table::contains<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg2), 5);
        let v0 = 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::footer(registry_bytes(arg0), b"dWallet", 0x2::object::id_to_bytes(&arg2), &arg4);
        if (!0x1::vector::is_empty<u8>(&arg8)) {
            0x1::vector::append<u8>(&mut v0, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::session_lines(arg8, arg9, arg10));
        };
        assert!(0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::approves_footer(0x2::table::borrow<0x2::object::ID, 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::Owner>(&arg0.owners, arg2), &arg6, &arg7, &v0), 11);
        if (!0x1::vector::is_empty<u8>(&arg8)) {
            start_session(arg0, arg2, arg8, arg9, arg10, arg11);
        };
        let (v1, v2) = withdraw_payment_coins(arg0, arg12);
        let v3 = v2;
        let v4 = v1;
        let v5 = take_presign(arg0, arg3);
        let v6 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, v5, arg12);
        let v7 = &mut v4;
        let v8 = &mut v3;
        let v9 = request_sign(arg0, arg1, arg2, v6, arg4, arg5, v7, v8, arg12);
        let v10 = SignRequested{
            dwallet_id     : arg2,
            sign_id        : v9,
            presign_cap_id : arg3,
        };
        0x2::event::emit<SignRequested>(v10);
        return_payment_coins(arg0, v4, v3);
        v9
    }

    public fun sign_permissionless(arg0: &Registry, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg9: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_owner_approved(arg0, arg2, &arg4, &arg6, &arg7);
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, arg3, arg10);
        let v1 = request_sign(arg0, arg1, arg2, v0, arg4, arg5, arg8, arg9, arg10);
        let v2 = SignRequested{
            dwallet_id     : arg2,
            sign_id        : v1,
            presign_cap_id : 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg3),
        };
        0x2::event::emit<SignRequested>(v2);
        v1
    }

    public fun sign_with_session(arg0: &mut Registry, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_operator(arg0, arg9);
        use_session(arg0, arg2, arg6, &arg7, &arg4, arg8);
        let (v0, v1) = withdraw_payment_coins(arg0, arg9);
        let v2 = v1;
        let v3 = v0;
        let v4 = take_presign(arg0, arg3);
        let v5 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, v4, arg9);
        let v6 = &mut v3;
        let v7 = &mut v2;
        let v8 = request_sign(arg0, arg1, arg2, v5, arg4, arg5, v6, v7, arg9);
        let v9 = SignRequested{
            dwallet_id     : arg2,
            sign_id        : v8,
            presign_cap_id : arg3,
        };
        0x2::event::emit<SignRequested>(v9);
        return_payment_coins(arg0, v3, v2);
        v8
    }

    fun start_session(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (0x1::vector::length<u8>(&arg2) == 32) {
            if (arg3 > v0) {
                if (arg3 - v0 <= 86400000) {
                    if (arg4 > 0) {
                        arg4 <= 1000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 12);
        let v2 = SessionKey{
            dwallet_id : arg1,
            key        : arg2,
        };
        assert!(!0x2::table::contains<SessionKey, Session>(&arg0.sessions, v2), 13);
        let v3 = SessionStarted{
            dwallet_id : arg1,
            key        : v2.key,
            until_ms   : arg3,
            signatures : arg4,
        };
        0x2::event::emit<SessionStarted>(v3);
        let v4 = Session{
            until_ms  : arg3,
            remaining : arg4,
        };
        0x2::table::add<SessionKey, Session>(&mut arg0.sessions, v2, v4);
    }

    public fun sui_balance(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    fun take_presign(arg0: &mut Registry, arg1: 0x2::object::ID) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        assert!(0x2::table::contains<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns, arg1), 4);
        0x2::table::remove<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg0.presigns, arg1)
    }

    fun use_session(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = SessionKey{
            dwallet_id : arg1,
            key        : arg2,
        };
        assert!(0x2::table::contains<SessionKey, Session>(&arg0.sessions, v0), 14);
        let v1 = 0x2::table::borrow_mut<SessionKey, Session>(&mut arg0.sessions, v0);
        assert!(0x2::clock::timestamp_ms(arg5) < v1.until_ms && v1.remaining > 0, 15);
        let v2 = 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner::session_payload(registry_bytes(arg0), 0x2::object::id_to_bytes(&arg1), arg4);
        assert!(0x2::ed25519::ed25519_verify(arg3, &v0.key, &v2), 16);
        v1.remaining = v1.remaining - 1;
    }

    public fun withdraw_ika(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, arg2), arg3)
    }

    fun withdraw_payment_coins(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg1))
    }

    public fun withdraw_sui(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

