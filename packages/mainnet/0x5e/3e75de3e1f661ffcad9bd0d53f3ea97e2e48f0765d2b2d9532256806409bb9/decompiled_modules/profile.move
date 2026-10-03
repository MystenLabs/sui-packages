module 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile {
    struct ProfileRegistryV1 has key {
        id: 0x2::object::UID,
        version: u64,
        profile_count: u64,
        by_owner: 0x2::table::Table<address, 0x2::object::ID>,
        by_handle: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        by_index: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct PublicMetadataV1 has copy, drop, store {
        blob_object_id: 0x2::object::ID,
        blob_id: vector<u8>,
        sha256: vector<u8>,
        byte_length: u64,
    }

    struct WalletProfileV1 has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        owner: address,
        revision: u64,
        handle: 0x1::string::String,
        metadata: PublicMetadataV1,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ProfileRegistryCreatedV1 has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct ProfileCreatedV1 has copy, drop {
        registry_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        owner: address,
        index: u64,
        revision: u64,
        handle: 0x1::string::String,
        metadata: PublicMetadataV1,
        timestamp_ms: u64,
    }

    struct ProfileUpdatedV1 has copy, drop {
        registry_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        owner: address,
        revision: u64,
        previous_handle: 0x1::string::String,
        handle: 0x1::string::String,
        metadata: PublicMetadataV1,
        timestamp_ms: u64,
    }

    struct BookmarksHeadKeyV1 has copy, drop, store {
        version: u8,
        owner: address,
    }

    struct BookmarksCipherRefV1 has copy, drop, store {
        blob_object_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        sha256: vector<u8>,
        byte_length: u64,
    }

    struct BookmarksReceiptV1 has copy, drop, store {
        request_id: vector<u8>,
        revision: u64,
        ciphertext: BookmarksCipherRefV1,
    }

    struct BookmarksHeadV1 has copy, drop, store {
        version: u8,
        registry_id: 0x2::object::ID,
        owner: address,
        revision: u64,
        ciphertext: BookmarksCipherRefV1,
        receipts: vector<BookmarksReceiptV1>,
    }

    struct BookmarksSealScopeV1 has drop {
        domain: 0x1::string::String,
        version: u8,
        registry_id: 0x2::object::ID,
        owner: address,
    }

    fun assert_bookmarks_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 10);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 10);
    }

    fun assert_bookmarks_reference(arg0: &BookmarksCipherRefV1, arg1: &vector<u8>) {
        assert_bookmarks_hash(arg1);
        assert_bookmarks_hash(&arg0.sha256);
        let v0 = if (arg0.blob_object_id != 0x2::object::id_from_address(@0x0)) {
            if (arg0.byte_length > 0) {
                arg0.byte_length <= 16777216
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
        let v1 = 0x1::string::as_bytes(&arg0.blob_id);
        assert!(0x1::vector::length<u8>(v1) == 43, 10);
        let v2 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v1)) {
            assert!(0x1::vector::contains<u8>(&v2, 0x1::vector::borrow<u8>(v1, v3)), 10);
            v3 = v3 + 1;
        };
        let v4 = b"AEIMQUYcgkosw048";
        assert!(0x1::vector::contains<u8>(&v4, 0x1::vector::borrow<u8>(v1, 42)), 10);
    }

    fun assert_handle(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::is_empty<u8>(v0)) {
            return
        };
        assert!(0x1::vector::length<u8>(v0) >= 3 && 0x1::vector::length<u8>(v0) <= 30, 3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            let v3 = if (v2 >= 97 && v2 <= 122) {
                true
            } else if (v2 >= 48 && v2 <= 57) {
                true
            } else {
                v2 == 95
            };
            assert!(v3, 3);
            v1 = v1 + 1;
        };
        let v4 = if (*v0 != b"clawnews_bot") {
            if (*v0 != b"system") {
                if (*v0 != b"admin") {
                    *v0 != b"moderator"
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 4);
    }

    public fun bookmarks_head(arg0: &ProfileRegistryV1, arg1: address) : 0x1::option::Option<BookmarksHeadV1> {
        assert!(arg0.version == 1, 8);
        let v0 = BookmarksHeadKeyV1{
            version : 1,
            owner   : arg1,
        };
        if (!0x2::dynamic_field::exists<BookmarksHeadKeyV1>(&arg0.id, v0)) {
            return 0x1::option::none<BookmarksHeadV1>()
        };
        let v1 = 0x2::dynamic_field::borrow<BookmarksHeadKeyV1, BookmarksHeadV1>(&arg0.id, v0);
        let v2 = if (v1.version == 1) {
            if (v1.registry_id == 0x2::object::id<ProfileRegistryV1>(arg0)) {
                if (v1.owner == arg1) {
                    if (v1.revision > 0) {
                        if (0x1::vector::length<BookmarksReceiptV1>(&v1.receipts) > 0) {
                            0x1::vector::length<BookmarksReceiptV1>(&v1.receipts) <= 32
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
            }
        } else {
            false
        };
        assert!(v2, 9);
        0x1::option::some<BookmarksHeadV1>(*v1)
    }

    public fun bookmarks_receipt(arg0: &ProfileRegistryV1, arg1: address, arg2: vector<u8>) : 0x1::option::Option<BookmarksReceiptV1> {
        let v0 = bookmarks_head(arg0, arg1);
        if (0x1::option::is_none<BookmarksHeadV1>(&v0)) {
            return 0x1::option::none<BookmarksReceiptV1>()
        };
        let v1 = &0x1::option::borrow<BookmarksHeadV1>(&v0).receipts;
        let v2 = 0;
        while (v2 < 0x1::vector::length<BookmarksReceiptV1>(v1)) {
            if (0x1::vector::borrow<BookmarksReceiptV1>(v1, v2).request_id == arg2) {
                return 0x1::option::some<BookmarksReceiptV1>(*0x1::vector::borrow<BookmarksReceiptV1>(v1, v2))
            };
            v2 = v2 + 1;
        };
        0x1::option::none<BookmarksReceiptV1>()
    }

    public fun bookmarks_receipt_revision(arg0: &BookmarksReceiptV1) : u64 {
        arg0.revision
    }

    public fun bookmarks_revision(arg0: &ProfileRegistryV1, arg1: address) : u64 {
        let v0 = bookmarks_head(arg0, arg1);
        if (0x1::option::is_some<BookmarksHeadV1>(&v0)) {
            0x1::option::borrow<BookmarksHeadV1>(&v0).revision
        } else {
            0
        }
    }

    public fun bookmarks_seal_id(arg0: &ProfileRegistryV1, arg1: address) : vector<u8> {
        assert!(arg0.version == 1, 8);
        let v0 = BookmarksSealScopeV1{
            domain      : 0x1::string::utf8(b"soulidity/private-bookmarks/seal-id/v1"),
            version     : 1,
            registry_id : 0x2::object::id<ProfileRegistryV1>(arg0),
            owner       : arg1,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BookmarksSealScopeV1>(&v0))
    }

    public fun commit_bookmarks(arg0: &mut ProfileRegistryV1, arg1: u64, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u64, arg7: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = bookmarks_head(arg0, v0);
        let v2 = BookmarksCipherRefV1{
            blob_object_id : arg3,
            blob_id        : arg4,
            sha256         : arg5,
            byte_length    : arg6,
        };
        if (0x1::option::is_some<BookmarksHeadV1>(&v1)) {
            let v3 = &0x1::option::borrow<BookmarksHeadV1>(&v1).receipts;
            let v4 = 0;
            while (v4 < 0x1::vector::length<BookmarksReceiptV1>(v3)) {
                if (0x1::vector::borrow<BookmarksReceiptV1>(v3, v4).request_id == arg2) {
                    assert!(0x1::vector::borrow<BookmarksReceiptV1>(v3, v4).ciphertext == v2, 11);
                    return 0x1::vector::borrow<BookmarksReceiptV1>(v3, v4).revision
                };
                v4 = v4 + 1;
            };
        };
        let v5 = if (0x1::option::is_some<BookmarksHeadV1>(&v1)) {
            0x1::option::borrow<BookmarksHeadV1>(&v1).revision
        } else {
            0
        };
        assert!(v5 == arg1 && v5 < 18446744073709551615, 6);
        assert_bookmarks_reference(&v2, &arg2);
        let v6 = v5 + 1;
        let v7 = if (0x1::option::is_some<BookmarksHeadV1>(&v1)) {
            0x1::option::borrow<BookmarksHeadV1>(&v1).receipts
        } else {
            0x1::vector::empty<BookmarksReceiptV1>()
        };
        let v8 = v7;
        if (0x1::vector::length<BookmarksReceiptV1>(&v8) == 32) {
            0x1::vector::remove<BookmarksReceiptV1>(&mut v8, 0);
        };
        let v9 = BookmarksReceiptV1{
            request_id : arg2,
            revision   : v6,
            ciphertext : v2,
        };
        0x1::vector::push_back<BookmarksReceiptV1>(&mut v8, v9);
        let v10 = BookmarksHeadKeyV1{
            version : 1,
            owner   : v0,
        };
        let v11 = BookmarksHeadV1{
            version     : 1,
            registry_id : 0x2::object::id<ProfileRegistryV1>(arg0),
            owner       : v0,
            revision    : v6,
            ciphertext  : v2,
            receipts    : v8,
        };
        if (0x1::option::is_some<BookmarksHeadV1>(&v1)) {
            *0x2::dynamic_field::borrow_mut<BookmarksHeadKeyV1, BookmarksHeadV1>(&mut arg0.id, v10) = v11;
        } else {
            0x2::dynamic_field::add<BookmarksHeadKeyV1, BookmarksHeadV1>(&mut arg0.id, v10, v11);
        };
        v6
    }

    public fun contains_handle(arg0: &ProfileRegistryV1, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.by_handle, arg1)
    }

    public fun contains_owner(arg0: &ProfileRegistryV1, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.by_owner, arg1)
    }

    public fun create_profile(arg0: &mut ProfileRegistryV1, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.version == 1, 8);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.by_owner, v0), 2);
        assert_handle(&arg1);
        assert!(0x1::string::is_empty(&arg1) || !0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.by_handle, arg1), 5);
        let v1 = metadata_ref(arg2, arg3, arg4, arg5);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = WalletProfileV1{
            id            : 0x2::object::new(arg7),
            version       : 1,
            registry_id   : 0x2::object::id<ProfileRegistryV1>(arg0),
            owner         : v0,
            revision      : 0,
            handle        : arg1,
            metadata      : v1,
            created_at_ms : v2,
            updated_at_ms : v2,
        };
        let v4 = 0x2::object::id<WalletProfileV1>(&v3);
        let v5 = arg0.profile_count;
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.by_owner, v0, v4);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.by_index, v5, v4);
        if (!0x1::string::is_empty(&arg1)) {
            0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.by_handle, arg1, v4);
        };
        arg0.profile_count = v5 + 1;
        let v6 = ProfileCreatedV1{
            registry_id  : 0x2::object::id<ProfileRegistryV1>(arg0),
            profile_id   : v4,
            owner        : v0,
            index        : v5,
            revision     : 0,
            handle       : arg1,
            metadata     : v1,
            timestamp_ms : v2,
        };
        0x2::event::emit<ProfileCreatedV1>(v6);
        0x2::transfer::transfer<WalletProfileV1>(v3, v0);
        v4
    }

    public fun handle(arg0: &WalletProfileV1) : &0x1::string::String {
        &arg0.handle
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileRegistryV1{
            id            : 0x2::object::new(arg0),
            version       : 1,
            profile_count : 0,
            by_owner      : 0x2::table::new<address, 0x2::object::ID>(arg0),
            by_handle     : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            by_index      : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        let v1 = ProfileRegistryCreatedV1{registry_id: 0x2::object::id<ProfileRegistryV1>(&v0)};
        0x2::event::emit<ProfileRegistryCreatedV1>(v1);
        0x2::transfer::share_object<ProfileRegistryV1>(v0);
    }

    public(friend) fun is_registered_profile(arg0: &ProfileRegistryV1, arg1: address, arg2: 0x2::object::ID) : bool {
        assert!(arg0.version == 1, 8);
        0x2::table::contains<address, 0x2::object::ID>(&arg0.by_owner, arg1) && *0x2::table::borrow<address, 0x2::object::ID>(&arg0.by_owner, arg1) == arg2
    }

    public fun metadata(arg0: &WalletProfileV1) : &PublicMetadataV1 {
        &arg0.metadata
    }

    public fun metadata_blob_id(arg0: &PublicMetadataV1) : &vector<u8> {
        &arg0.blob_id
    }

    public fun metadata_blob_object_id(arg0: &PublicMetadataV1) : 0x2::object::ID {
        arg0.blob_object_id
    }

    public fun metadata_byte_length(arg0: &PublicMetadataV1) : u64 {
        arg0.byte_length
    }

    fun metadata_ref(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : PublicMetadataV1 {
        let v0 = if (arg0 != 0x2::object::id_from_address(@0x0)) {
            if (0x1::vector::length<u8>(&arg1) == 32) {
                if (0x1::vector::length<u8>(&arg2) == 32) {
                    if (arg3 > 0) {
                        arg3 <= 65536
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
        assert!(v0, 7);
        PublicMetadataV1{
            blob_object_id : arg0,
            blob_id        : arg1,
            sha256         : arg2,
            byte_length    : arg3,
        }
    }

    public fun metadata_sha256(arg0: &PublicMetadataV1) : &vector<u8> {
        &arg0.sha256
    }

    public fun owner(arg0: &WalletProfileV1) : address {
        arg0.owner
    }

    public fun profile_at_index(arg0: &ProfileRegistryV1, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.by_index, arg1)
    }

    public fun profile_count(arg0: &ProfileRegistryV1) : u64 {
        arg0.profile_count
    }

    public fun profile_for_handle(arg0: &ProfileRegistryV1, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.by_handle, arg1)
    }

    public fun profile_for_owner(arg0: &ProfileRegistryV1, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.by_owner, arg1)
    }

    public fun registry_id(arg0: &ProfileRegistryV1) : 0x2::object::ID {
        0x2::object::id<ProfileRegistryV1>(arg0)
    }

    public fun revision(arg0: &WalletProfileV1) : u64 {
        arg0.revision
    }

    public fun seal_approve_bookmarks(arg0: vector<u8>, arg1: &ProfileRegistryV1, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == bookmarks_seal_id(arg1, 0x2::tx_context::sender(arg2)), 12);
    }

    public fun update_profile(arg0: &mut ProfileRegistryV1, arg1: &mut WalletProfileV1, arg2: u64, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1 && arg1.version == 1, 8);
        assert!(arg1.registry_id == 0x2::object::id<ProfileRegistryV1>(arg0), 0);
        assert!(arg1.owner == 0x2::tx_context::sender(arg9), 1);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.by_owner, arg1.owner) && *0x2::table::borrow<address, 0x2::object::ID>(&arg0.by_owner, arg1.owner) == 0x2::object::id<WalletProfileV1>(arg1), 0);
        assert!(arg1.revision == arg2, 6);
        assert_handle(&arg3);
        let v0 = metadata_ref(arg4, arg5, arg6, arg7);
        let v1 = arg1.handle;
        if (arg3 != v1) {
            assert!(0x1::string::is_empty(&arg3) || !0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.by_handle, arg3), 5);
            if (!0x1::string::is_empty(&v1)) {
                assert!(0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.by_handle, v1) == 0x2::object::id<WalletProfileV1>(arg1), 0);
            };
            if (!0x1::string::is_empty(&arg3)) {
                0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.by_handle, arg3, 0x2::object::id<WalletProfileV1>(arg1));
            };
        };
        arg1.handle = arg3;
        arg1.metadata = v0;
        arg1.revision = arg1.revision + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg8);
        let v2 = ProfileUpdatedV1{
            registry_id     : 0x2::object::id<ProfileRegistryV1>(arg0),
            profile_id      : 0x2::object::id<WalletProfileV1>(arg1),
            owner           : arg1.owner,
            revision        : arg1.revision,
            previous_handle : v1,
            handle          : arg3,
            metadata        : v0,
            timestamp_ms    : arg1.updated_at_ms,
        };
        0x2::event::emit<ProfileUpdatedV1>(v2);
    }

    // decompiled from Move bytecode v7
}

