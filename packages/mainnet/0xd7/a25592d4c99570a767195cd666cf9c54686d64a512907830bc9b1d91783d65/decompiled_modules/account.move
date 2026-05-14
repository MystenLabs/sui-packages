module 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::account {
    struct Account has key {
        id: 0x2::object::UID,
    }

    struct DWalletKey has copy, drop, store {
        dwallet_id: 0x2::object::ID,
    }

    struct SharedDWalletKey has copy, drop, store {
        dwallet_id: 0x2::object::ID,
    }

    struct ImportedKeyDWalletKey has copy, drop, store {
        dwallet_id: 0x2::object::ID,
    }

    struct StoredDWallet has store, key {
        id: 0x2::object::UID,
        cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
    }

    struct StoredSharedDWallet has store, key {
        id: 0x2::object::UID,
        cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
        credentials: 0x2::vec_set::VecSet<vector<u8>>,
        threshold: u64,
        nonce: u64,
    }

    struct StoredImportedKeyDWallet has store, key {
        id: 0x2::object::UID,
        cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap,
    }

    public fun add_credential(arg0: &mut Account, arg1: 0x2::object::ID, arg2: 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential, arg3: vector<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::Credential>, arg4: &0x2::tx_context::TxContext) {
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::assert_pubkey_length(&arg2);
        let v0 = borrow_shared_mut(arg0, arg1);
        assert!(0x2::vec_set::length<vector<u8>>(&v0.credentials) < 16, 2);
        assert!(!0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::is_already_registered(&arg2, &v0.credentials), 1);
        let v1 = 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::new_credential_id_bytes(&arg2);
        let v2 = wrapper_uid_bytes(v0);
        let v3 = 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::challenges::add_credential(&v2, v0.nonce, &v1);
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::verify_threshold(arg3, &v0.credentials, &v3, v0.threshold, arg4);
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::insert_credential(arg2, &mut v0.credentials);
        v0.nonce = v0.nonce + 1;
    }

    public(friend) fun authorize_shared_and_bump_nonce(arg0: &mut Account, arg1: 0x2::object::ID, arg2: vector<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::Credential>, arg3: &vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = borrow_shared_mut(arg0, arg1);
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::verify_threshold(arg2, &v0.credentials, arg3, v0.threshold, arg4);
        v0.nonce = v0.nonce + 1;
    }

    fun borrow_shared(arg0: &Account, arg1: 0x2::object::ID) : &StoredSharedDWallet {
        let v0 = SharedDWalletKey{dwallet_id: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<SharedDWalletKey, StoredSharedDWallet>(&arg0.id, v0), 8);
        0x2::dynamic_object_field::borrow<SharedDWalletKey, StoredSharedDWallet>(&arg0.id, v0)
    }

    fun borrow_shared_mut(arg0: &mut Account, arg1: 0x2::object::ID) : &mut StoredSharedDWallet {
        let v0 = SharedDWalletKey{dwallet_id: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<SharedDWalletKey, StoredSharedDWallet>(&arg0.id, v0), 8);
        0x2::dynamic_object_field::borrow_mut<SharedDWalletKey, StoredSharedDWallet>(&mut arg0.id, v0)
    }

    fun build_initial_roster(arg0: vector<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential>, arg1: u64) : 0x2::vec_set::VecSet<vector<u8>> {
        let v0 = 0x1::vector::length<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential>(&arg0);
        assert!(v0 > 0, 9);
        assert!(v0 <= 16, 2);
        assert!(arg1 >= 1, 4);
        assert!(arg1 <= v0, 6);
        let v1 = 0x2::vec_set::empty<vector<u8>>();
        while (!0x1::vector::is_empty<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential>(&mut arg0);
            0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::assert_pubkey_length(&v2);
            assert!(!0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::is_already_registered(&v2, &v1), 1);
            0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::insert_credential(v2, &mut v1);
        };
        0x1::vector::destroy_empty<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential>(arg0);
        v1
    }

    public(friend) fun dwallet_cap(arg0: &Account, arg1: 0x2::object::ID) : &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        let v0 = DWalletKey{dwallet_id: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<DWalletKey, StoredDWallet>(&arg0.id, v0), 8);
        &0x2::dynamic_object_field::borrow<DWalletKey, StoredDWallet>(&arg0.id, v0).cap
    }

    public fun has_dwallet(arg0: &Account, arg1: 0x2::object::ID) : bool {
        let v0 = DWalletKey{dwallet_id: arg1};
        0x2::dynamic_object_field::exists_with_type<DWalletKey, StoredDWallet>(&arg0.id, v0)
    }

    public fun has_imported_key_dwallet(arg0: &Account, arg1: 0x2::object::ID) : bool {
        let v0 = ImportedKeyDWalletKey{dwallet_id: arg1};
        0x2::dynamic_object_field::exists_with_type<ImportedKeyDWalletKey, StoredImportedKeyDWallet>(&arg0.id, v0)
    }

    public fun has_shared_dwallet(arg0: &Account, arg1: 0x2::object::ID) : bool {
        let v0 = SharedDWalletKey{dwallet_id: arg1};
        0x2::dynamic_object_field::exists_with_type<SharedDWalletKey, StoredSharedDWallet>(&arg0.id, v0)
    }

    public(friend) fun imported_key_cap(arg0: &Account, arg1: 0x2::object::ID) : &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap {
        let v0 = ImportedKeyDWalletKey{dwallet_id: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<ImportedKeyDWalletKey, StoredImportedKeyDWallet>(&arg0.id, v0), 8);
        &0x2::dynamic_object_field::borrow<ImportedKeyDWalletKey, StoredImportedKeyDWallet>(&arg0.id, v0).cap
    }

    public fun register_account(arg0: &0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::acl::OperatorCap, arg1: &mut 0x2::tx_context::TxContext) : Account {
        Account{id: 0x2::object::new(arg1)}
    }

    public fun remove_credential(arg0: &mut Account, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::Credential>, arg4: &0x2::tx_context::TxContext) {
        let v0 = borrow_shared_mut(arg0, arg1);
        assert!(0x2::vec_set::contains<vector<u8>>(&v0.credentials, &arg2), 3);
        assert!(0x2::vec_set::length<vector<u8>>(&v0.credentials) > v0.threshold, 5);
        let v1 = wrapper_uid_bytes(v0);
        let v2 = 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::challenges::remove_credential(&v1, v0.nonce, &arg2);
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::verify_threshold(arg3, &v0.credentials, &v2, v0.threshold, arg4);
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::remove_credential(arg2, &mut v0.credentials);
        v0.nonce = v0.nonce + 1;
    }

    public fun set_threshold(arg0: &mut Account, arg1: 0x2::object::ID, arg2: u64, arg3: vector<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::Credential>, arg4: &0x2::tx_context::TxContext) {
        let v0 = borrow_shared_mut(arg0, arg1);
        assert!(arg2 >= 1, 4);
        assert!(arg2 <= 0x2::vec_set::length<vector<u8>>(&v0.credentials), 6);
        let v1 = wrapper_uid_bytes(v0);
        let v2 = 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::challenges::set_threshold(&v1, v0.nonce, arg2);
        0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::verify_threshold(arg3, &v0.credentials, &v2, v0.threshold, arg4);
        v0.threshold = arg2;
        v0.nonce = v0.nonce + 1;
    }

    public fun share_account(arg0: Account) {
        0x2::transfer::share_object<Account>(arg0);
    }

    public fun shared_credential_count(arg0: &Account, arg1: 0x2::object::ID) : u64 {
        0x2::vec_set::length<vector<u8>>(&borrow_shared(arg0, arg1).credentials)
    }

    public(friend) fun shared_dwallet_cap(arg0: &Account, arg1: 0x2::object::ID) : &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        &borrow_shared(arg0, arg1).cap
    }

    public fun shared_nonce(arg0: &Account, arg1: 0x2::object::ID) : u64 {
        borrow_shared(arg0, arg1).nonce
    }

    public fun shared_threshold(arg0: &Account, arg1: 0x2::object::ID) : u64 {
        borrow_shared(arg0, arg1).threshold
    }

    public(friend) fun store_dwallet_cap(arg0: &mut Account, arg1: 0x2::object::ID, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DWalletKey{dwallet_id: arg1};
        assert!(!0x2::dynamic_object_field::exists_with_type<DWalletKey, StoredDWallet>(&arg0.id, v0), 7);
        let v1 = StoredDWallet{
            id  : 0x2::object::new(arg3),
            cap : arg2,
        };
        0x2::dynamic_object_field::add<DWalletKey, StoredDWallet>(&mut arg0.id, v0, v1);
    }

    public(friend) fun store_imported_key_cap(arg0: &mut Account, arg1: 0x2::object::ID, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ImportedKeyDWalletKey{dwallet_id: arg1};
        assert!(!0x2::dynamic_object_field::exists_with_type<ImportedKeyDWalletKey, StoredImportedKeyDWallet>(&arg0.id, v0), 7);
        let v1 = StoredImportedKeyDWallet{
            id  : 0x2::object::new(arg3),
            cap : arg2,
        };
        0x2::dynamic_object_field::add<ImportedKeyDWalletKey, StoredImportedKeyDWallet>(&mut arg0.id, v0, v1);
    }

    public(friend) fun store_shared_dwallet_cap(arg0: &mut Account, arg1: 0x2::object::ID, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg3: vector<0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::auth::NewCredential>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedDWalletKey{dwallet_id: arg1};
        assert!(!0x2::dynamic_object_field::exists_with_type<SharedDWalletKey, StoredSharedDWallet>(&arg0.id, v0), 7);
        let v1 = StoredSharedDWallet{
            id          : 0x2::object::new(arg5),
            cap         : arg2,
            credentials : build_initial_roster(arg3, arg4),
            threshold   : arg4,
            nonce       : 0,
        };
        0x2::dynamic_object_field::add<SharedDWalletKey, StoredSharedDWallet>(&mut arg0.id, v0, v1);
    }

    public(friend) fun stored_shared_nonce(arg0: &Account, arg1: 0x2::object::ID) : u64 {
        borrow_shared(arg0, arg1).nonce
    }

    public(friend) fun stored_shared_uid_bytes(arg0: &Account, arg1: 0x2::object::ID) : vector<u8> {
        wrapper_uid_bytes(borrow_shared(arg0, arg1))
    }

    fun wrapper_uid_bytes(arg0: &StoredSharedDWallet) : vector<u8> {
        0x2::address::to_bytes(0x2::object::id_address<StoredSharedDWallet>(arg0))
    }

    // decompiled from Move bytecode v6
}

