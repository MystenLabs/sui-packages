module 0xcaeb04d2aa1ed998d91c3f1d00b45c285b025994f0685643e35cb9abe8a88dd1::account {
    struct Account has key {
        id: 0x2::object::UID,
        header: vector<u8>,
        header_revision: u64,
        recovery_public_key: vector<u8>,
        recovery_delay_ms: u64,
        recovery_nonce: u64,
        keyring: vector<u8>,
        keyring_revision: u64,
        tier1_count: u64,
    }

    struct Scope has copy, drop, store {
        kind: u8,
        tag: vector<u8>,
    }

    struct ProductKey has copy, drop, store {
        tag: vector<u8>,
    }

    struct ProductEntry has drop, store {
        sealed_share_private: vector<u8>,
        objects: vector<u8>,
        revision: u64,
    }

    struct ShareKey has copy, drop, store {
        product: vector<u8>,
    }

    struct SharePublic has drop, store {
        key: vector<u8>,
    }

    struct GrantKey has copy, drop, store {
        id: vector<u8>,
    }

    struct Grant has drop, store {
        kind: u8,
        scheme: u8,
        public_key: vector<u8>,
        address: address,
        tier: u8,
        scope: vector<Scope>,
        delegate: bool,
        expires_ms: u64,
        granted_by: vector<u8>,
        created_ms: u64,
    }

    struct AppKey has copy, drop, store {
        tag: vector<u8>,
    }

    struct AppEntry has drop, store {
        data: vector<u8>,
        revision: u64,
    }

    struct DeliveryKey has copy, drop, store {
        grant: vector<u8>,
    }

    struct Delivery has drop, store {
        data: vector<u8>,
    }

    struct RecoveryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingRecovery has drop, store {
        scheme: u8,
        public_key: vector<u8>,
        nonce: u64,
        requested_ms: u64,
        ready_ms: u64,
    }

    struct AccountCreated has copy, drop {
        account: 0x2::object::ID,
        grant: vector<u8>,
    }

    struct HeaderReplaced has copy, drop {
        account: 0x2::object::ID,
        header_revision: u64,
    }

    struct KeyringChanged has copy, drop {
        account: 0x2::object::ID,
        keyring_revision: u64,
    }

    struct ProductEntryChanged has copy, drop {
        account: 0x2::object::ID,
        tag: vector<u8>,
        revision: u64,
    }

    struct SharePublicChanged has copy, drop {
        account: 0x2::object::ID,
        product: vector<u8>,
    }

    struct AppEntryChanged has copy, drop {
        account: 0x2::object::ID,
        tag: vector<u8>,
        revision: u64,
    }

    struct GrantAdded has copy, drop {
        account: 0x2::object::ID,
        grant: vector<u8>,
        kind: u8,
        tier: u8,
        granted_by: vector<u8>,
    }

    struct GrantRevoked has copy, drop {
        account: 0x2::object::ID,
        grant: vector<u8>,
        by: vector<u8>,
    }

    struct DeliveryAcked has copy, drop {
        account: 0x2::object::ID,
        grant: vector<u8>,
    }

    struct RecoveryRequested has copy, drop {
        account: 0x2::object::ID,
        grant: vector<u8>,
        ready_ms: u64,
    }

    struct RecoveryCancelled has copy, drop {
        account: 0x2::object::ID,
        by: vector<u8>,
    }

    struct RecoveryCompleted has copy, drop {
        account: 0x2::object::ID,
        grant: vector<u8>,
    }

    public fun account_bytes(arg0: &Account) : vector<u8> {
        0x1::bcs::to_bytes<Account>(arg0)
    }

    public fun account_id(arg0: &Account) : 0x2::object::ID {
        0x2::object::id<Account>(arg0)
    }

    fun account_scope() : Scope {
        Scope{
            kind : 0,
            tag  : b"",
        }
    }

    public fun account_tail_bytes(arg0: &Account) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<Account>(arg0);
        let v1 = b"";
        let v2 = 32;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun ack_delivery(arg0: &mut Account, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        authorize(arg0, &arg1, arg2, arg3);
        let v0 = DeliveryKey{grant: arg1};
        assert!(0x2::dynamic_field::exists<DeliveryKey>(&arg0.id, v0), 8);
        let v1 = DeliveryKey{grant: arg1};
        0x2::dynamic_field::remove<DeliveryKey, Delivery>(&mut arg0.id, v1);
        let v2 = DeliveryAcked{
            account : 0x2::object::id<Account>(arg0),
            grant   : arg1,
        };
        0x2::event::emit<DeliveryAcked>(v2);
    }

    public fun add_grant(arg0: &mut Account, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: bool, arg9: u64, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg11);
        let v1 = Grant{
            kind       : arg2,
            scheme     : arg3,
            public_key : arg4,
            address    : derive_address(arg3, &arg4),
            tier       : arg5,
            scope      : scopes_from_parts(&arg6, &arg7),
            delegate   : arg8,
            expires_ms : arg9,
            granted_by : arg1,
            created_ms : v0,
        };
        check_grant_shape(&v1, v0);
        let v2 = grant_id(v1.scheme, &v1.public_key);
        let v3 = GrantKey{id: v2};
        assert!(!0x2::dynamic_field::exists<GrantKey>(&arg0.id, v3), 7);
        let v4 = authorize(arg0, &arg1, arg11, arg12);
        assert!(v4.delegate, 3);
        assert!(v1.tier >= v4.tier, 3);
        assert!(!v1.delegate || v1.tier <= 2, 3);
        if (v4.expires_ms != 0) {
            assert!(v1.expires_ms != 0 && v1.expires_ms <= v4.expires_ms, 3);
        };
        assert!(scopes_covered(&v4.scope, &v1.scope), 3);
        if (arg2 == 2) {
            assert!(0x1::vector::is_empty<u8>(&arg10), 9);
        } else {
            assert!(0x1::vector::length<u8>(&arg10) >= 72 && 0x1::vector::length<u8>(&arg10) <= 4096, 9);
        };
        let v5 = GrantKey{id: v2};
        0x2::dynamic_field::add<GrantKey, Grant>(&mut arg0.id, v5, v1);
        if (arg5 == 1) {
            arg0.tier1_count = arg0.tier1_count + 1;
        };
        if (!0x1::vector::is_empty<u8>(&arg10)) {
            let v6 = DeliveryKey{grant: v2};
            let v7 = Delivery{data: arg10};
            0x2::dynamic_field::add<DeliveryKey, Delivery>(&mut arg0.id, v6, v7);
        };
        let v8 = GrantAdded{
            account    : 0x2::object::id<Account>(arg0),
            grant      : v2,
            kind       : arg2,
            tier       : arg5,
            granted_by : arg1,
        };
        0x2::event::emit<GrantAdded>(v8);
    }

    public fun app_entry_bcs(arg0: vector<u8>, arg1: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) >= 40 && 0x1::vector::length<u8>(&arg0) <= 65576, 6);
        let v0 = AppEntry{
            data     : arg0,
            revision : arg1,
        };
        0x1::bcs::to_bytes<AppEntry>(&v0)
    }

    public fun app_entry_bytes(arg0: &Account, arg1: vector<u8>) : vector<u8> {
        let v0 = AppKey{tag: arg1};
        0x1::bcs::to_bytes<AppEntry>(0x2::dynamic_field::borrow<AppKey, AppEntry>(&arg0.id, v0))
    }

    public fun app_key_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = AppKey{tag: arg0};
        0x1::bcs::to_bytes<AppKey>(&v0)
    }

    fun approved_by(arg0: &Account, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = GrantKey{id: *arg1};
        let v1 = 0x2::dynamic_field::borrow<GrantKey, Grant>(&arg0.id, v0).granted_by;
        let v2 = 0;
        while (!0x1::vector::is_empty<u8>(&v1)) {
            assert!(v2 < 8, 3);
            if (v1 == *arg2) {
                return true
            };
            let v3 = if (0x1::vector::length<u8>(&v1) == 16) {
                let v4 = GrantKey{id: v1};
                0x2::dynamic_field::exists<GrantKey>(&arg0.id, v4)
            } else {
                false
            };
            assert!(v3, 3);
            let v5 = GrantKey{id: v1};
            v1 = 0x2::dynamic_field::borrow<GrantKey, Grant>(&arg0.id, v5).granted_by;
            v2 = v2 + 1;
        };
        false
    }

    fun authorize(arg0: &Account, arg1: &vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : &Grant {
        assert!(0x1::vector::length<u8>(arg1) == 16, 6);
        let v0 = *arg1;
        let v1 = GrantKey{id: v0};
        assert!(0x2::dynamic_field::exists<GrantKey>(&arg0.id, v1), 0);
        let v2 = GrantKey{id: v0};
        let v3 = 0x2::dynamic_field::borrow<GrantKey, Grant>(&arg0.id, v2);
        assert!(v3.address == 0x2::tx_context::sender(arg3), 1);
        assert!(v3.expires_ms == 0 || 0x2::clock::timestamp_ms(arg2) < v3.expires_ms, 2);
        v3
    }

    public fun cancel_recovery(arg0: &mut Account, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(authorize(arg0, &arg1, arg2, arg3).tier == 1, 3);
        let v0 = RecoveryKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecoveryKey>(&arg0.id, v0), 12);
        let v1 = RecoveryKey{dummy_field: false};
        0x2::dynamic_field::remove<RecoveryKey, PendingRecovery>(&mut arg0.id, v1);
        let v2 = RecoveryCancelled{
            account : 0x2::object::id<Account>(arg0),
            by      : arg1,
        };
        0x2::event::emit<RecoveryCancelled>(v2);
    }

    fun check_grant_shape(arg0: &Grant, arg1: u64) {
        assert!(arg0.kind <= 2, 4);
        check_public_key(arg0.scheme, &arg0.public_key);
        assert!(arg0.address == derive_address(arg0.scheme, &arg0.public_key), 4);
        assert!(arg0.tier >= 1 && arg0.tier <= 3, 4);
        assert!(0x1::vector::length<Scope>(&arg0.scope) >= 1 && 0x1::vector::length<Scope>(&arg0.scope) <= 8, 4);
        check_scopes(&arg0.scope);
        assert!(0x1::vector::is_empty<u8>(&arg0.granted_by) || 0x1::vector::length<u8>(&arg0.granted_by) == 16, 4);
        if (arg0.tier == 1) {
            assert!(0x1::vector::length<Scope>(&arg0.scope) == 1 && is_account_scope(0x1::vector::borrow<Scope>(&arg0.scope, 0)), 4);
        } else {
            let v0 = b"";
            assert!(!has_scope(&arg0.scope, 0, &v0), 4);
        };
        let v1 = arg0.kind == 2;
        let v2 = 0x1::vector::length<Scope>(&arg0.scope) == 1 && is_relay_scope(0x1::vector::borrow<Scope>(&arg0.scope, 0));
        assert!(v1 == v2, 4);
        if (v1) {
            assert!(arg0.tier == 3 && !arg0.delegate, 4);
        };
        if (arg0.kind == 1) {
            assert!(arg0.tier == 2 || arg0.tier == 3, 4);
        };
        assert!(!arg0.delegate || arg0.tier <= 2, 4);
        assert!(arg0.expires_ms == 0 || arg0.expires_ms > arg1, 4);
    }

    fun check_header(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 1 && 0x1::vector::length<u8>(arg0) <= 2048, 6);
    }

    fun check_keyring(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 40 && 0x1::vector::length<u8>(arg0) <= 12040, 6);
    }

    fun check_public_key(arg0: u8, arg1: &vector<u8>) {
        assert!(arg0 == 0 || arg0 == 1, 4);
        let v0 = if (arg0 == 0) {
            32
        } else {
            33
        };
        assert!(0x1::vector::length<u8>(arg1) == v0, 4);
    }

    fun check_scopes(arg0: &vector<Scope>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Scope>(arg0)) {
            let v1 = 0x1::vector::borrow<Scope>(arg0, v0);
            assert!(valid_scope(v1), 4);
            let v2 = v0 + 1;
            while (v2 < 0x1::vector::length<Scope>(arg0)) {
                assert!(!scope_equal(v1, 0x1::vector::borrow<Scope>(arg0, v2)), 4);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun check_tag(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 16, 6);
    }

    public fun complete_recovery(arg0: &mut Account, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = RecoveryKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecoveryKey>(&arg0.id, v0), 12);
        let v1 = RecoveryKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<RecoveryKey, PendingRecovery>(&arg0.id, v1);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2.ready_ms, 13);
        assert!(derive_address(v2.scheme, &v2.public_key) == 0x2::tx_context::sender(arg2), 14);
        let v3 = GrantKey{id: grant_id(v2.scheme, &v2.public_key)};
        assert!(!0x2::dynamic_field::exists<GrantKey>(&arg0.id, v3), 7);
        let v4 = RecoveryKey{dummy_field: false};
        let PendingRecovery {
            scheme       : v5,
            public_key   : v6,
            nonce        : _,
            requested_ms : _,
            ready_ms     : _,
        } = 0x2::dynamic_field::remove<RecoveryKey, PendingRecovery>(&mut arg0.id, v4);
        let v10 = v6;
        let v11 = grant_id(v5, &v10);
        let v12 = 0x1::vector::empty<Scope>();
        0x1::vector::push_back<Scope>(&mut v12, account_scope());
        let v13 = Grant{
            kind       : 0,
            scheme     : v5,
            public_key : v10,
            address    : 0x2::tx_context::sender(arg2),
            tier       : 1,
            scope      : v12,
            delegate   : true,
            expires_ms : 0,
            granted_by : b"",
            created_ms : 0x2::clock::timestamp_ms(arg1),
        };
        check_grant_shape(&v13, 0x2::clock::timestamp_ms(arg1));
        let v14 = GrantKey{id: v11};
        0x2::dynamic_field::add<GrantKey, Grant>(&mut arg0.id, v14, v13);
        arg0.tier1_count = arg0.tier1_count + 1;
        let v15 = RecoveryCompleted{
            account : 0x2::object::id<Account>(arg0),
            grant   : v11,
        };
        0x2::event::emit<RecoveryCompleted>(v15);
    }

    public fun create_account(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_header(&arg0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 6);
        check_keyring(&arg2);
        assert!(derive_address(arg3, &arg4) == 0x2::tx_context::sender(arg6), 1);
        let v0 = 0x1::vector::empty<Scope>();
        0x1::vector::push_back<Scope>(&mut v0, account_scope());
        let v1 = Grant{
            kind       : 0,
            scheme     : arg3,
            public_key : arg4,
            address    : 0x2::tx_context::sender(arg6),
            tier       : 1,
            scope      : v0,
            delegate   : true,
            expires_ms : 0,
            granted_by : b"",
            created_ms : 0x2::clock::timestamp_ms(arg5),
        };
        check_grant_shape(&v1, 0);
        let v2 = grant_id(v1.scheme, &v1.public_key);
        let v3 = Account{
            id                  : 0x2::object::new(arg6),
            header              : arg0,
            header_revision     : 1,
            recovery_public_key : arg1,
            recovery_delay_ms   : 86400000,
            recovery_nonce      : 0,
            keyring             : arg2,
            keyring_revision    : 1,
            tier1_count         : 1,
        };
        let v4 = GrantKey{id: v2};
        0x2::dynamic_field::add<GrantKey, Grant>(&mut v3.id, v4, v1);
        let v5 = AccountCreated{
            account : 0x2::object::id<Account>(&v3),
            grant   : v2,
        };
        0x2::event::emit<AccountCreated>(v5);
        0x2::transfer::share_object<Account>(v3);
    }

    public fun delivery_bcs(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) >= 72 && 0x1::vector::length<u8>(&arg0) <= 4096, 6);
        let v0 = Delivery{data: arg0};
        0x1::bcs::to_bytes<Delivery>(&v0)
    }

    public fun delivery_bytes(arg0: &Account, arg1: vector<u8>) : vector<u8> {
        let v0 = DeliveryKey{grant: arg1};
        0x1::bcs::to_bytes<Delivery>(0x2::dynamic_field::borrow<DeliveryKey, Delivery>(&arg0.id, v0))
    }

    public fun delivery_key_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = DeliveryKey{grant: arg0};
        0x1::bcs::to_bytes<DeliveryKey>(&v0)
    }

    public fun derive_address(arg0: u8, arg1: &vector<u8>) : address {
        check_public_key(arg0, arg1);
        let v0 = if (arg0 == 0) {
            0
        } else {
            2
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, *arg1);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    fun first_16(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) >= 16, 4);
        let v0 = b"";
        let v1 = 0;
        while (v1 < 16) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun grant_bcs(arg0: u8, arg1: u8, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: bool, arg7: u64, arg8: vector<u8>, arg9: u64) : vector<u8> {
        let v0 = Grant{
            kind       : arg0,
            scheme     : arg1,
            public_key : arg2,
            address    : derive_address(arg1, &arg2),
            tier       : arg3,
            scope      : scopes_from_parts(&arg4, &arg5),
            delegate   : arg6,
            expires_ms : arg7,
            granted_by : arg8,
            created_ms : arg9,
        };
        check_grant_shape(&v0, 0);
        0x1::bcs::to_bytes<Grant>(&v0)
    }

    public fun grant_bytes(arg0: &Account, arg1: vector<u8>) : vector<u8> {
        let v0 = GrantKey{id: arg1};
        0x1::bcs::to_bytes<Grant>(0x2::dynamic_field::borrow<GrantKey, Grant>(&arg0.id, v0))
    }

    public fun grant_id(arg0: u8, arg1: &vector<u8>) : vector<u8> {
        check_public_key(arg0, arg1);
        let v0 = b"meeru-account-grant-id-v1";
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        let v1 = 0x1::hash::sha2_256(v0);
        first_16(&v1)
    }

    public fun grant_key_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = GrantKey{id: arg0};
        0x1::bcs::to_bytes<GrantKey>(&v0)
    }

    public fun has_delivery(arg0: &Account, arg1: vector<u8>) : bool {
        let v0 = DeliveryKey{grant: arg1};
        0x2::dynamic_field::exists<DeliveryKey>(&arg0.id, v0)
    }

    public fun has_grant(arg0: &Account, arg1: vector<u8>) : bool {
        let v0 = GrantKey{id: arg1};
        0x2::dynamic_field::exists<GrantKey>(&arg0.id, v0)
    }

    fun has_scope(arg0: &vector<Scope>, arg1: u8, arg2: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Scope>(arg0)) {
            let v1 = 0x1::vector::borrow<Scope>(arg0, v0);
            if (v1.kind == arg1 && &v1.tag == arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun header_message(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        let v0 = b"meeru-account-header-change-v1";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg3));
        v0
    }

    public fun header_revision(arg0: &Account) : u64 {
        arg0.header_revision
    }

    fun is_account_scope(arg0: &Scope) : bool {
        arg0.kind == 0 && 0x1::vector::is_empty<u8>(&arg0.tag)
    }

    fun is_product_name(arg0: &vector<u8>) : bool {
        if (0x1::vector::is_empty<u8>(arg0) || 0x1::vector::length<u8>(arg0) > 32) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = if (v1 >= 97 && v1 <= 122) {
                true
            } else if (v1 >= 48 && v1 <= 57) {
                true
            } else {
                v1 == 45
            };
            if (!v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun is_relay_scope(arg0: &Scope) : bool {
        arg0.kind == 4 && 0x1::vector::is_empty<u8>(&arg0.tag)
    }

    fun join_chunks(arg0: vector<vector<u8>>) : vector<u8> {
        assert!(!0x1::vector::is_empty<vector<u8>>(&arg0), 6);
        let v0 = 0x1::vector::remove<vector<u8>>(&mut arg0, 0);
        assert!(0x1::vector::length<u8>(&v0) <= 16000, 6);
        while (!0x1::vector::is_empty<vector<u8>>(&arg0)) {
            let v1 = 0x1::vector::remove<vector<u8>>(&mut arg0, 0);
            assert!(0x1::vector::length<u8>(&v1) <= 16000, 6);
            0x1::vector::append<u8>(&mut v0, v1);
        };
        v0
    }

    public fun keyring_revision(arg0: &Account) : u64 {
        arg0.keyring_revision
    }

    public fun product_entry_bcs(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 72, 6);
        check_keyring(&arg1);
        let v0 = ProductEntry{
            sealed_share_private : arg0,
            objects              : arg1,
            revision             : arg2,
        };
        0x1::bcs::to_bytes<ProductEntry>(&v0)
    }

    public fun product_entry_bytes(arg0: &Account, arg1: vector<u8>) : vector<u8> {
        let v0 = ProductKey{tag: arg1};
        0x1::bcs::to_bytes<ProductEntry>(0x2::dynamic_field::borrow<ProductKey, ProductEntry>(&arg0.id, v0))
    }

    public fun product_key_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = ProductKey{tag: arg0};
        0x1::bcs::to_bytes<ProductKey>(&v0)
    }

    public fun recovery_message(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: vector<u8>) : vector<u8> {
        let v0 = b"meeru-account-recovery-request-v1";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg3));
        v0
    }

    public fun recovery_nonce(arg0: &Account) : u64 {
        arg0.recovery_nonce
    }

    public fun replace_header(arg0: &mut Account, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(authorize(arg0, &arg1, arg6, arg7).tier == 1, 3);
        assert!(arg0.header_revision == arg2, 5);
        check_header(&arg3);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 6);
        let v0 = header_message(0x2::object::id<Account>(arg0), arg0.recovery_nonce, arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.recovery_public_key, &v0), 10);
        arg0.header = arg3;
        arg0.recovery_public_key = arg4;
        arg0.header_revision = arg0.header_revision + 1;
        arg0.recovery_nonce = arg0.recovery_nonce + 1;
        let v1 = RecoveryKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RecoveryKey>(&arg0.id, v1)) {
            let v2 = RecoveryKey{dummy_field: false};
            0x2::dynamic_field::remove<RecoveryKey, PendingRecovery>(&mut arg0.id, v2);
        };
        let v3 = HeaderReplaced{
            account         : 0x2::object::id<Account>(arg0),
            header_revision : arg0.header_revision,
        };
        0x2::event::emit<HeaderReplaced>(v3);
    }

    public fun request_recovery(arg0: &mut Account, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        let v0 = RecoveryKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RecoveryKey>(&arg0.id, v0), 11);
        let v1 = grant_id(arg1, &arg2);
        let v2 = GrantKey{id: v1};
        assert!(!0x2::dynamic_field::exists<GrantKey>(&arg0.id, v2), 7);
        let v3 = arg0.recovery_nonce;
        let v4 = recovery_message(0x2::object::id<Account>(arg0), v3, arg1, arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.recovery_public_key, &v4), 10);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        let v6 = if (arg0.tier1_count == 0) {
            v5
        } else {
            v5 + arg0.recovery_delay_ms
        };
        let v7 = RecoveryKey{dummy_field: false};
        let v8 = PendingRecovery{
            scheme       : arg1,
            public_key   : arg2,
            nonce        : v3,
            requested_ms : v5,
            ready_ms     : v6,
        };
        0x2::dynamic_field::add<RecoveryKey, PendingRecovery>(&mut arg0.id, v7, v8);
        arg0.recovery_nonce = arg0.recovery_nonce + 1;
        let v9 = RecoveryRequested{
            account  : 0x2::object::id<Account>(arg0),
            grant    : v1,
            ready_ms : v6,
        };
        0x2::event::emit<RecoveryRequested>(v9);
    }

    public fun revoke_grant(arg0: &mut Account, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 16, 6);
        let v0 = GrantKey{id: arg2};
        assert!(0x2::dynamic_field::exists<GrantKey>(&arg0.id, v0), 8);
        let v1 = authorize(arg0, &arg1, arg3, arg4).tier;
        if (!(arg1 == arg2) && v1 != 1) {
            assert!(v1 == 2 && approved_by(arg0, &arg2, &arg1), 3);
        };
        let v2 = GrantKey{id: arg2};
        let v3 = 0x2::dynamic_field::remove<GrantKey, Grant>(&mut arg0.id, v2);
        if (v3.tier == 1) {
            arg0.tier1_count = arg0.tier1_count - 1;
        };
        let v4 = DeliveryKey{grant: arg2};
        if (0x2::dynamic_field::exists<DeliveryKey>(&arg0.id, v4)) {
            let v5 = DeliveryKey{grant: arg2};
            0x2::dynamic_field::remove<DeliveryKey, Delivery>(&mut arg0.id, v5);
        };
        let v6 = GrantRevoked{
            account : 0x2::object::id<Account>(arg0),
            grant   : arg2,
            by      : arg1,
        };
        0x2::event::emit<GrantRevoked>(v6);
    }

    fun scope_equal(arg0: &Scope, arg1: &Scope) : bool {
        arg0.kind == arg1.kind && arg0.tag == arg1.tag
    }

    fun scopes_covered(arg0: &vector<Scope>, arg1: &vector<Scope>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Scope>(arg1)) {
            let v1 = 0x1::vector::borrow<Scope>(arg1, v0);
            let v2 = false;
            let v3 = 0;
            while (v3 < 0x1::vector::length<Scope>(arg0)) {
                let v4 = 0x1::vector::borrow<Scope>(arg0, v3);
                if (is_account_scope(v4) || scope_equal(v4, v1)) {
                    v2 = true;
                };
                v3 = v3 + 1;
            };
            if (!v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun scopes_from_parts(arg0: &vector<u8>, arg1: &vector<vector<u8>>) : vector<Scope> {
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<vector<u8>>(arg1), 4);
        let v0 = 0x1::vector::empty<Scope>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = Scope{
                kind : *0x1::vector::borrow<u8>(arg0, v1),
                tag  : *0x1::vector::borrow<vector<u8>>(arg1, v1),
            };
            0x1::vector::push_back<Scope>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun set_app_entry(arg0: &mut Account, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = authorize(arg0, &arg1, arg5, arg6);
        assert!(v0.tier == 1 || has_scope(&v0.scope, 3, &arg2), 3);
        check_tag(&arg2);
        let v1 = join_chunks(arg4);
        assert!(0x1::vector::length<u8>(&v1) >= 40 && 0x1::vector::length<u8>(&v1) <= 65576, 6);
        let v2 = AppKey{tag: arg2};
        let v3 = write_app_entry(arg0, v2, arg3, v1);
        let v4 = AppEntryChanged{
            account  : 0x2::object::id<Account>(arg0),
            tag      : arg2,
            revision : v3,
        };
        0x2::event::emit<AppEntryChanged>(v4);
    }

    public fun set_keyring(arg0: &mut Account, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(authorize(arg0, &arg1, arg4, arg5).tier == 1, 3);
        assert!(arg0.keyring_revision == arg2, 5);
        check_keyring(&arg3);
        arg0.keyring = arg3;
        arg0.keyring_revision = arg0.keyring_revision + 1;
        let v0 = KeyringChanged{
            account          : 0x2::object::id<Account>(arg0),
            keyring_revision : arg0.keyring_revision,
        };
        0x2::event::emit<KeyringChanged>(v0);
    }

    public fun set_product_entry(arg0: &mut Account, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = authorize(arg0, &arg1, arg6, arg7);
        assert!(v0.tier == 1 || has_scope(&v0.scope, 1, &arg2), 3);
        check_tag(&arg2);
        assert!(0x1::vector::length<u8>(&arg4) == 72, 6);
        check_keyring(&arg5);
        let v1 = ProductKey{tag: arg2};
        let v2 = write_product_entry(arg0, v1, arg3, arg4, arg5);
        let v3 = ProductEntryChanged{
            account  : 0x2::object::id<Account>(arg0),
            tag      : arg2,
            revision : v2,
        };
        0x2::event::emit<ProductEntryChanged>(v3);
    }

    public fun set_share_public(arg0: &mut Account, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(authorize(arg0, &arg1, arg4, arg5).tier == 1, 3);
        assert!(is_product_name(&arg2), 15);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 6);
        let v0 = ShareKey{product: arg2};
        if (0x2::dynamic_field::exists<ShareKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<ShareKey, SharePublic>(&mut arg0.id, v0);
        };
        let v1 = SharePublic{key: arg3};
        0x2::dynamic_field::add<ShareKey, SharePublic>(&mut arg0.id, v0, v1);
        let v2 = SharePublicChanged{
            account : 0x2::object::id<Account>(arg0),
            product : arg2,
        };
        0x2::event::emit<SharePublicChanged>(v2);
    }

    public fun share_key_bytes(arg0: vector<u8>) : vector<u8> {
        let v0 = ShareKey{product: arg0};
        0x1::bcs::to_bytes<ShareKey>(&v0)
    }

    public fun share_public_bcs(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 6);
        let v0 = SharePublic{key: arg0};
        0x1::bcs::to_bytes<SharePublic>(&v0)
    }

    public fun share_public_bytes(arg0: &Account, arg1: vector<u8>) : vector<u8> {
        let v0 = ShareKey{product: arg1};
        0x1::bcs::to_bytes<SharePublic>(0x2::dynamic_field::borrow<ShareKey, SharePublic>(&arg0.id, v0))
    }

    public fun tier1_count(arg0: &Account) : u64 {
        arg0.tier1_count
    }

    fun valid_scope(arg0: &Scope) : bool {
        if (arg0.kind == 0 || arg0.kind == 4) {
            0x1::vector::is_empty<u8>(&arg0.tag)
        } else {
            let v1 = if (arg0.kind == 1) {
                true
            } else if (arg0.kind == 2) {
                true
            } else {
                arg0.kind == 3
            };
            v1 && 0x1::vector::length<u8>(&arg0.tag) == 16
        }
    }

    fun write_app_entry(arg0: &mut Account, arg1: AppKey, arg2: u64, arg3: vector<u8>) : u64 {
        if (0x2::dynamic_field::exists<AppKey>(&arg0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow_mut<AppKey, AppEntry>(&mut arg0.id, arg1);
            assert!(v1.revision == arg2, 5);
            v1.data = arg3;
            v1.revision = v1.revision + 1;
            v1.revision
        } else {
            assert!(arg2 == 0, 5);
            let v2 = AppEntry{
                data     : arg3,
                revision : 1,
            };
            0x2::dynamic_field::add<AppKey, AppEntry>(&mut arg0.id, arg1, v2);
            1
        }
    }

    fun write_product_entry(arg0: &mut Account, arg1: ProductKey, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) : u64 {
        if (0x2::dynamic_field::exists<ProductKey>(&arg0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow_mut<ProductKey, ProductEntry>(&mut arg0.id, arg1);
            assert!(v1.revision == arg2, 5);
            v1.sealed_share_private = arg3;
            v1.objects = arg4;
            v1.revision = v1.revision + 1;
            v1.revision
        } else {
            assert!(arg2 == 0, 5);
            let v2 = ProductEntry{
                sealed_share_private : arg3,
                objects              : arg4,
                revision             : 1,
            };
            0x2::dynamic_field::add<ProductKey, ProductEntry>(&mut arg0.id, arg1, v2);
            1
        }
    }

    // decompiled from Move bytecode v7
}

