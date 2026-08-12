module 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::storage {
    struct BlobRef has copy, drop, store {
        blob_id: 0x1::string::String,
        size_bytes: u64,
        stored_epoch: u64,
        expiry_epoch: u64,
        encrypted: bool,
        seal_policy_id: 0x1::option::Option<0x2::object::ID>,
        content_hash: vector<u8>,
        content_type: 0x1::string::String,
        original_name: 0x1::string::String,
        quilt_blob_id: 0x1::option::Option<0x1::string::String>,
        seal_marker: 0x1::option::Option<vector<u8>>,
        folder: 0x1::option::Option<u64>,
    }

    struct Folder has store {
        name: 0x1::string::String,
        viewers: 0x2::vec_set::VecSet<address>,
        blob_count: u64,
        created_epoch: u64,
    }

    struct BlobStore has store, key {
        id: 0x2::object::UID,
        owner: address,
        blobs: 0x2::table::Table<0x1::string::String, BlobRef>,
        total_size_bytes: u64,
        total_blobs: u64,
        viewers: 0x2::vec_set::VecSet<address>,
        shares: 0x2::table::Table<vector<u8>, 0x2::vec_set::VecSet<address>>,
        share_markers: vector<vector<u8>>,
        folders: 0x2::table::Table<u64, Folder>,
        folder_ids: vector<u64>,
        next_folder_id: u64,
        marker_folder: 0x2::table::Table<vector<u8>, 0x1::option::Option<u64>>,
        folder_viewer_count: u64,
    }

    struct BlobRegistered has copy, drop {
        blob_id: 0x1::string::String,
        owner: address,
        size_bytes: u64,
        expiry_epoch: u64,
        encrypted: bool,
        epoch: u64,
    }

    struct BlobExtended has copy, drop {
        blob_id: 0x1::string::String,
        old_expiry: u64,
        new_expiry: u64,
        epoch: u64,
    }

    struct BlobReleased has copy, drop {
        blob_id: 0x1::string::String,
        owner: address,
        size_bytes: u64,
        epoch: u64,
    }

    struct ViewerAdded has copy, drop {
        store_id: 0x2::object::ID,
        owner: address,
        viewer: address,
        epoch: u64,
    }

    struct ViewerRemoved has copy, drop {
        store_id: 0x2::object::ID,
        owner: address,
        viewer: address,
        epoch: u64,
    }

    struct BlobStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        owner: address,
        epoch: u64,
    }

    struct AccountTransferred has copy, drop {
        from: address,
        to: address,
        account_id: 0x2::object::ID,
        subscription_id: 0x2::object::ID,
        store_id: 0x2::object::ID,
        epoch: u64,
    }

    struct QuiltRegistered has copy, drop {
        store_id: 0x2::object::ID,
        owner: address,
        quilt_blob_id: 0x1::string::String,
        patch_count: u64,
        total_size_bytes: u64,
        expiry_epoch: u64,
        epoch: u64,
    }

    struct BlobShareAdded has copy, drop {
        store_id: 0x2::object::ID,
        owner: address,
        seal_marker: vector<u8>,
        viewer: address,
        epoch: u64,
    }

    struct BlobShareRemoved has copy, drop {
        store_id: 0x2::object::ID,
        owner: address,
        seal_marker: vector<u8>,
        viewer: address,
        epoch: u64,
    }

    struct FolderCreated has copy, drop {
        store_id: 0x2::object::ID,
        owner: address,
        folder_id: u64,
        name: 0x1::string::String,
        epoch: u64,
    }

    struct FolderRenamed has copy, drop {
        store_id: 0x2::object::ID,
        folder_id: u64,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        epoch: u64,
    }

    struct FolderDeleted has copy, drop {
        store_id: 0x2::object::ID,
        folder_id: u64,
        epoch: u64,
    }

    struct BlobMovedToFolder has copy, drop {
        store_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        from_folder: 0x1::option::Option<u64>,
        to_folder: 0x1::option::Option<u64>,
        epoch: u64,
    }

    struct FolderViewerAdded has copy, drop {
        store_id: 0x2::object::ID,
        folder_id: u64,
        viewer: address,
        epoch: u64,
    }

    struct FolderViewerRemoved has copy, drop {
        store_id: 0x2::object::ID,
        folder_id: u64,
        viewer: address,
        epoch: u64,
    }

    public fun add_blob_share(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: vector<u8>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 407);
        assert!(arg3 != arg0.owner, 418);
        assert!(0x1::vector::length<u8>(&arg2) == 16, 422);
        if (!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.shares, arg2)) {
            0x2::table::add<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.shares, arg2, 0x2::vec_set::empty<address>());
            0x1::vector::push_back<vector<u8>>(&mut arg0.share_markers, arg2);
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.shares, arg2);
        assert!(0x2::vec_set::length<address>(v0) < 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::max_viewers_per_store(arg1), 417);
        assert!(!0x2::vec_set::contains<address>(v0, &arg3), 423);
        0x2::vec_set::insert<address>(v0, arg3);
        let v1 = BlobShareAdded{
            store_id    : 0x2::object::id<BlobStore>(arg0),
            owner       : arg0.owner,
            seal_marker : arg2,
            viewer      : arg3,
            epoch       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<BlobShareAdded>(v1);
    }

    public fun add_folder_viewer(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 407);
        assert!(arg3 != arg0.owner, 418);
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg2), 430);
        let v0 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, arg2);
        assert!(!0x2::vec_set::contains<address>(&v0.viewers, &arg3), 435);
        assert!(0x2::vec_set::length<address>(&v0.viewers) < 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::max_viewers_per_store(arg1), 417);
        0x2::vec_set::insert<address>(&mut v0.viewers, arg3);
        arg0.folder_viewer_count = arg0.folder_viewer_count + 1;
        let v1 = FolderViewerAdded{
            store_id  : 0x2::object::id<BlobStore>(arg0),
            folder_id : arg2,
            viewer    : arg3,
            epoch     : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<FolderViewerAdded>(v1);
    }

    public fun add_viewer(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 407);
        assert!(arg2 != arg0.owner, 418);
        assert!(!0x2::vec_set::contains<address>(&arg0.viewers, &arg2), 415);
        assert!(0x2::vec_set::length<address>(&arg0.viewers) < 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::max_viewers_per_store(arg1), 417);
        0x2::vec_set::insert<address>(&mut arg0.viewers, arg2);
        let v0 = ViewerAdded{
            store_id : 0x2::object::id<BlobStore>(arg0),
            owner    : arg0.owner,
            viewer   : arg2,
            epoch    : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<ViewerAdded>(v0);
    }

    fun assert_id_bound_to_store(arg0: &vector<u8>, arg1: &BlobStore) {
        let v0 = 0x2::object::id<BlobStore>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(arg0) >= v2, 409);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(arg0, v3) == *0x1::vector::borrow<u8>(&v1, v3), 409);
            v3 = v3 + 1;
        };
    }

    fun assert_valid_folder_name(arg0: &0x1::string::String) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0, 433);
        assert!(v0 <= 128, 432);
    }

    public fun blob_content_hash(arg0: &BlobRef) : &vector<u8> {
        &arg0.content_hash
    }

    public fun blob_content_type(arg0: &BlobRef) : 0x1::string::String {
        arg0.content_type
    }

    public fun blob_encrypted(arg0: &BlobRef) : bool {
        arg0.encrypted
    }

    public fun blob_expiry_epoch(arg0: &BlobRef) : u64 {
        arg0.expiry_epoch
    }

    public fun blob_folder(arg0: &BlobRef) : &0x1::option::Option<u64> {
        &arg0.folder
    }

    public fun blob_id(arg0: &BlobRef) : 0x1::string::String {
        arg0.blob_id
    }

    public fun blob_is_quilt_patch(arg0: &BlobRef) : bool {
        0x1::option::is_some<0x1::string::String>(&arg0.quilt_blob_id)
    }

    public fun blob_original_name(arg0: &BlobRef) : 0x1::string::String {
        arg0.original_name
    }

    public fun blob_quilt_blob_id(arg0: &BlobRef) : &0x1::option::Option<0x1::string::String> {
        &arg0.quilt_blob_id
    }

    public fun blob_seal_marker(arg0: &BlobRef) : &0x1::option::Option<vector<u8>> {
        &arg0.seal_marker
    }

    public fun blob_seal_policy(arg0: &BlobRef) : &0x1::option::Option<0x2::object::ID> {
        &arg0.seal_policy_id
    }

    public fun blob_size(arg0: &BlobRef) : u64 {
        arg0.size_bytes
    }

    public fun blob_stored_epoch(arg0: &BlobRef) : u64 {
        arg0.stored_epoch
    }

    public fun clear_blob_shares(arg0: &mut BlobStore, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 407);
        let v0 = 0;
        while (v0 < arg1 && !0x1::vector::is_empty<vector<u8>>(&arg0.share_markers)) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg0.share_markers);
            if (0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.shares, v1)) {
                0x2::vec_set::into_keys<address>(0x2::table::remove<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.shares, v1));
            };
            v0 = v0 + 1;
        };
    }

    public fun clear_folder_viewers(arg0: &mut BlobStore, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 407);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.folder_ids) && v1 < arg1) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.folder_ids, v0);
            if (0x2::table::contains<u64, Folder>(&arg0.folders, v2)) {
                let v3 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, v2);
                let v4 = 0x2::vec_set::length<address>(&v3.viewers);
                if (v4 > 0) {
                    v3.viewers = 0x2::vec_set::empty<address>();
                    let v5 = if (arg0.folder_viewer_count > v4) {
                        arg0.folder_viewer_count - v4
                    } else {
                        0
                    };
                    arg0.folder_viewer_count = v5;
                    v1 = v1 + 1;
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun contains_blob(arg0: &BlobStore, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, BlobRef>(&arg0.blobs, arg1)
    }

    public fun content_hash_len() : u64 {
        32
    }

    public fun create_blob_store(arg0: &mut 0x2::tx_context::TxContext) : BlobStore {
        let v0 = BlobStore{
            id                  : 0x2::object::new(arg0),
            owner               : 0x2::tx_context::sender(arg0),
            blobs               : 0x2::table::new<0x1::string::String, BlobRef>(arg0),
            total_size_bytes    : 0,
            total_blobs         : 0,
            viewers             : 0x2::vec_set::empty<address>(),
            shares              : 0x2::table::new<vector<u8>, 0x2::vec_set::VecSet<address>>(arg0),
            share_markers       : vector[],
            folders             : 0x2::table::new<u64, Folder>(arg0),
            folder_ids          : vector[],
            next_folder_id      : 0,
            marker_folder       : 0x2::table::new<vector<u8>, 0x1::option::Option<u64>>(arg0),
            folder_viewer_count : 0,
        };
        let v1 = BlobStoreCreated{
            store_id : 0x2::object::id<BlobStore>(&v0),
            owner    : 0x2::tx_context::sender(arg0),
            epoch    : 0x2::tx_context::epoch(arg0),
        };
        0x2::event::emit<BlobStoreCreated>(v1);
        v0
    }

    public fun create_folder(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) : u64 {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 407);
        assert_valid_folder_name(&arg2);
        assert!(0x1::vector::length<u64>(&arg0.folder_ids) < 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::max_folders_per_store(arg1), 434);
        let v0 = arg0.next_folder_id;
        arg0.next_folder_id = v0 + 1;
        let v1 = Folder{
            name          : arg2,
            viewers       : 0x2::vec_set::empty<address>(),
            blob_count    : 0,
            created_epoch : 0x2::tx_context::epoch(arg3),
        };
        0x2::table::add<u64, Folder>(&mut arg0.folders, v0, v1);
        0x1::vector::push_back<u64>(&mut arg0.folder_ids, v0);
        let v2 = FolderCreated{
            store_id  : 0x2::object::id<BlobStore>(arg0),
            owner     : arg0.owner,
            folder_id : v0,
            name      : arg2,
            epoch     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<FolderCreated>(v2);
        v0
    }

    public fun create_shared_blob_store(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<BlobStore>(create_blob_store(arg0));
    }

    public fun delete_folder(arg0: &mut BlobStore, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 407);
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg1), 430);
        assert!(0x2::table::borrow<u64, Folder>(&arg0.folders, arg1).blob_count == 0, 431);
        let Folder {
            name          : _,
            viewers       : v1,
            blob_count    : _,
            created_epoch : _,
        } = 0x2::table::remove<u64, Folder>(&mut arg0.folders, arg1);
        let v4 = v1;
        let v5 = 0x2::vec_set::length<address>(&v4);
        let v6 = if (arg0.folder_viewer_count > v5) {
            arg0.folder_viewer_count - v5
        } else {
            0
        };
        arg0.folder_viewer_count = v6;
        0x2::vec_set::into_keys<address>(v4);
        let (v7, v8) = 0x1::vector::index_of<u64>(&arg0.folder_ids, &arg1);
        if (v7) {
            0x1::vector::remove<u64>(&mut arg0.folder_ids, v8);
        };
        let v9 = FolderDeleted{
            store_id  : 0x2::object::id<BlobStore>(arg0),
            folder_id : arg1,
            epoch     : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<FolderDeleted>(v9);
    }

    public fun extend_blob(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::PlanRegistry, arg3: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::Subscription, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 407);
        assert!(arg5 > 0, 403);
        assert!(0x2::table::contains<0x1::string::String, BlobRef>(&arg0.blobs, arg4), 411);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::is_active(arg3, 0x2::tx_context::epoch(arg6)), 412);
        let v0 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_max_walrus_epochs(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::get_plan(arg2, 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::sub_tier(arg3)));
        let v1 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::max_storage_epochs(arg1);
        let v2 = if (v0 > 0 && v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0x2::table::borrow_mut<0x1::string::String, BlobRef>(&mut arg0.blobs, arg4);
        assert!(0x1::option::is_none<0x1::string::String>(&v3.quilt_blob_id), 427);
        assert!(arg5 <= v2, 410);
        let v4 = v3.expiry_epoch;
        let v5 = v4 + arg5;
        v3.expiry_epoch = v5;
        let v6 = BlobExtended{
            blob_id    : arg4,
            old_expiry : v4,
            new_expiry : v5,
            epoch      : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<BlobExtended>(v6);
    }

    public fun folder_blob_count(arg0: &BlobStore, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg1), 430);
        0x2::table::borrow<u64, Folder>(&arg0.folders, arg1).blob_count
    }

    public fun folder_can_view(arg0: &BlobStore, arg1: u64, arg2: address) : bool {
        0x2::table::contains<u64, Folder>(&arg0.folders, arg1) && 0x2::vec_set::contains<address>(&0x2::table::borrow<u64, Folder>(&arg0.folders, arg1).viewers, &arg2)
    }

    public fun folder_created_epoch(arg0: &BlobStore, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg1), 430);
        0x2::table::borrow<u64, Folder>(&arg0.folders, arg1).created_epoch
    }

    public fun folder_for_marker(arg0: &BlobStore, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (0x2::table::contains<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, arg1)) {
            *0x2::table::borrow<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, arg1)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun folder_name(arg0: &BlobStore, arg1: u64) : 0x1::string::String {
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg1), 430);
        0x2::table::borrow<u64, Folder>(&arg0.folders, arg1).name
    }

    public fun folder_viewers(arg0: &BlobStore, arg1: u64) : &0x2::vec_set::VecSet<address> {
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg1), 430);
        &0x2::table::borrow<u64, Folder>(&arg0.folders, arg1).viewers
    }

    public fun get_blob(arg0: &BlobStore, arg1: 0x1::string::String) : &BlobRef {
        assert!(0x2::table::contains<0x1::string::String, BlobRef>(&arg0.blobs, arg1), 411);
        0x2::table::borrow<0x1::string::String, BlobRef>(&arg0.blobs, arg1)
    }

    public fun marker_folder_grants(arg0: &BlobStore, arg1: vector<u8>, arg2: address) : bool {
        if (!0x2::table::contains<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, arg1)) {
            return false
        };
        let v0 = *0x2::table::borrow<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        let v1 = *0x1::option::borrow<u64>(&v0);
        if (!0x2::table::contains<u64, Folder>(&arg0.folders, v1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<u64, Folder>(&arg0.folders, v1).viewers, &arg2)
    }

    public fun marker_in_use(arg0: &BlobStore, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, arg1)
    }

    public fun max_folder_name_len() : u64 {
        128
    }

    public fun move_blob_to_folder(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 407);
        assert!(0x2::table::contains<0x1::string::String, BlobRef>(&arg0.blobs, arg2), 411);
        if (0x1::option::is_some<u64>(&arg3)) {
            let v0 = *0x1::option::borrow<u64>(&arg3);
            assert!(0x2::table::contains<u64, Folder>(&arg0.folders, v0), 430);
            if (0x2::vec_set::length<address>(&0x2::table::borrow<u64, Folder>(&arg0.folders, v0).viewers) > 0) {
                0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
            };
        };
        let v1 = 0x2::table::borrow_mut<0x1::string::String, BlobRef>(&mut arg0.blobs, arg2);
        let v2 = v1.folder;
        let v3 = v1.seal_marker;
        if (v2 == arg3) {
            return
        };
        v1.folder = arg3;
        if (0x1::option::is_some<u64>(&v2)) {
            let v4 = *0x1::option::borrow<u64>(&v2);
            if (0x2::table::contains<u64, Folder>(&arg0.folders, v4)) {
                let v5 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, v4);
                let v6 = if (v5.blob_count > 0) {
                    v5.blob_count - 1
                } else {
                    0
                };
                v5.blob_count = v6;
            };
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            let v7 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, *0x1::option::borrow<u64>(&arg3));
            v7.blob_count = v7.blob_count + 1;
        };
        if (0x1::option::is_some<vector<u8>>(&v3)) {
            let v8 = *0x1::option::borrow<vector<u8>>(&v3);
            if (0x2::table::contains<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, v8)) {
                *0x2::table::borrow_mut<vector<u8>, 0x1::option::Option<u64>>(&mut arg0.marker_folder, v8) = arg3;
            };
        };
        let v9 = BlobMovedToFolder{
            store_id    : 0x2::object::id<BlobStore>(arg0),
            blob_id     : arg2,
            from_folder : v2,
            to_folder   : arg3,
            epoch       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<BlobMovedToFolder>(v9);
    }

    public fun new_blob_ref(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: 0x1::option::Option<0x2::object::ID>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::option::Option<0x1::string::String>, arg10: 0x1::option::Option<vector<u8>>) : BlobRef {
        assert!(!0x1::string::is_empty(&arg0), 404);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 408);
        assert!(arg3 > arg2, 401);
        if (0x1::option::is_some<vector<u8>>(&arg10)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg10)) == 16, 422);
        };
        BlobRef{
            blob_id        : arg0,
            size_bytes     : arg1,
            stored_epoch   : arg2,
            expiry_epoch   : arg3,
            encrypted      : arg4,
            seal_policy_id : arg5,
            content_hash   : arg6,
            content_type   : arg7,
            original_name  : arg8,
            quilt_blob_id  : arg9,
            seal_marker    : arg10,
            folder         : 0x1::option::none<u64>(),
        }
    }

    public fun register_blob(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::PlanRegistry, arg3: &mut 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::UserAccount, arg4: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::Subscription, arg5: BlobRef, arg6: 0x1::option::Option<u64>, arg7: &0x2::tx_context::TxContext) {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 407);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::sub_owner(arg4) == 0x2::tx_context::sender(arg7), 407);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::account_owner(arg3) == 0x2::tx_context::sender(arg7), 407);
        assert!(!0x2::table::contains<0x1::string::String, BlobRef>(&arg0.blobs, arg5.blob_id), 406);
        let v0 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::sub_tier(arg4);
        let v1 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::get_plan(arg2, v0);
        if (arg5.encrypted) {
            assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_has_seal(v1), 421);
        };
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::account_total_bytes(arg3) + arg5.size_bytes <= 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::effective_storage_limit(arg3, arg2, v0), 428);
        let v2 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_max_total_files(v1);
        if (v2 > 0) {
            assert!(arg0.total_blobs + 1 <= v2, 420);
        };
        let v3 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_max_walrus_epochs(v1);
        if (v3 > 0) {
            assert!(arg5.expiry_epoch - arg5.stored_epoch <= v3, 410);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(0x2::table::contains<u64, Folder>(&arg0.folders, *0x1::option::borrow<u64>(&arg6)), 430);
        };
        if (0x1::option::is_some<vector<u8>>(&arg5.seal_marker)) {
            assert!(!0x2::table::contains<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, *0x1::option::borrow<vector<u8>>(&arg5.seal_marker)), 438);
        };
        let v4 = arg5.blob_id;
        let v5 = arg5.size_bytes;
        let v6 = arg5.encrypted;
        let v7 = arg5.seal_marker;
        arg5.folder = arg6;
        arg0.total_size_bytes = arg0.total_size_bytes + v5;
        arg0.total_blobs = arg0.total_blobs + 1;
        0x2::table::add<0x1::string::String, BlobRef>(&mut arg0.blobs, v4, arg5);
        if (0x1::option::is_some<u64>(&arg6)) {
            let v8 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, *0x1::option::borrow<u64>(&arg6));
            v8.blob_count = v8.blob_count + 1;
        };
        if (0x1::option::is_some<vector<u8>>(&v7)) {
            0x2::table::add<vector<u8>, 0x1::option::Option<u64>>(&mut arg0.marker_folder, *0x1::option::borrow<vector<u8>>(&v7), arg6);
        };
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::add_storage(arg3, v5, 1, v6);
        let v9 = BlobRegistered{
            blob_id      : v4,
            owner        : arg0.owner,
            size_bytes   : v5,
            expiry_epoch : arg5.expiry_epoch,
            encrypted    : v6,
            epoch        : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<BlobRegistered>(v9);
    }

    public fun register_quilt(arg0: &mut BlobStore, arg1: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg2: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::PlanRegistry, arg3: &mut 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::UserAccount, arg4: &0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::Subscription, arg5: vector<BlobRef>, arg6: 0x1::option::Option<u64>, arg7: &0x2::tx_context::TxContext) {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg1);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_version(arg1);
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 407);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::sub_owner(arg4) == 0x2::tx_context::sender(arg7), 407);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::account_owner(arg3) == 0x2::tx_context::sender(arg7), 407);
        let v0 = 0x1::vector::length<BlobRef>(&arg5);
        assert!(v0 > 0, 425);
        let v1 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::sub_tier(arg4);
        let v2 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::get_plan(arg2, v1);
        let v3 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_max_files_per_batch(v2);
        if (v3 > 0) {
            assert!(v0 <= v3, 419);
        };
        let v4 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_max_total_files(v2);
        if (v4 > 0) {
            assert!(arg0.total_blobs + v0 <= v4, 420);
        };
        let v5 = 0x1::vector::borrow<BlobRef>(&arg5, 0);
        let v6 = *0x1::option::borrow<0x1::string::String>(&v5.quilt_blob_id);
        let v7 = v5.expiry_epoch;
        let v8 = v5.encrypted;
        let v9 = 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_max_walrus_epochs(v2);
        if (v9 > 0) {
            assert!(v7 - v5.stored_epoch <= v9, 410);
        };
        if (v8) {
            assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::plan_has_seal(v2), 421);
        };
        let v10 = 0;
        let v11 = 0;
        while (v11 < v0) {
            v10 = v10 + 0x1::vector::borrow<BlobRef>(&arg5, v11).size_bytes;
            v11 = v11 + 1;
        };
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::account_total_bytes(arg3) + v10 <= 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::effective_storage_limit(arg3, arg2, v1), 428);
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(0x2::table::contains<u64, Folder>(&arg0.folders, *0x1::option::borrow<u64>(&arg6)), 430);
        };
        let v12 = 0;
        while (!0x1::vector::is_empty<BlobRef>(&arg5)) {
            let v13 = 0x1::vector::pop_back<BlobRef>(&mut arg5);
            assert!(v13.quilt_blob_id == 0x1::option::some<0x1::string::String>(v6), 426);
            assert!(0x1::option::is_none<vector<u8>>(&v13.seal_marker), 427);
            assert!(v13.expiry_epoch == v7, 401);
            assert!(v13.encrypted == v8, 426);
            assert!(!0x2::table::contains<0x1::string::String, BlobRef>(&arg0.blobs, v13.blob_id), 406);
            v13.folder = arg6;
            v12 = v12 + v13.size_bytes;
            0x2::table::add<0x1::string::String, BlobRef>(&mut arg0.blobs, v13.blob_id, v13);
        };
        0x1::vector::destroy_empty<BlobRef>(arg5);
        if (0x1::option::is_some<u64>(&arg6)) {
            let v14 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, *0x1::option::borrow<u64>(&arg6));
            v14.blob_count = v14.blob_count + v0;
        };
        arg0.total_size_bytes = arg0.total_size_bytes + v12;
        arg0.total_blobs = arg0.total_blobs + v0;
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::add_storage(arg3, v12, v0, v8);
        let v15 = QuiltRegistered{
            store_id         : 0x2::object::id<BlobStore>(arg0),
            owner            : arg0.owner,
            quilt_blob_id    : v6,
            patch_count      : v0,
            total_size_bytes : v12,
            expiry_epoch     : v7,
            epoch            : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<QuiltRegistered>(v15);
    }

    public fun release_blob(arg0: &mut BlobStore, arg1: &mut 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::UserAccount, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) : BlobRef {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 407);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::account_owner(arg1) == 0x2::tx_context::sender(arg3), 407);
        assert!(0x2::table::contains<0x1::string::String, BlobRef>(&arg0.blobs, arg2), 411);
        let v0 = 0x2::table::remove<0x1::string::String, BlobRef>(&mut arg0.blobs, arg2);
        let v1 = if (arg0.total_size_bytes > v0.size_bytes) {
            arg0.total_size_bytes - v0.size_bytes
        } else {
            0
        };
        arg0.total_size_bytes = v1;
        let v2 = if (arg0.total_blobs > 0) {
            arg0.total_blobs - 1
        } else {
            0
        };
        arg0.total_blobs = v2;
        if (0x1::option::is_some<u64>(&v0.folder)) {
            let v3 = *0x1::option::borrow<u64>(&v0.folder);
            if (0x2::table::contains<u64, Folder>(&arg0.folders, v3)) {
                let v4 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, v3);
                let v5 = if (v4.blob_count > 0) {
                    v4.blob_count - 1
                } else {
                    0
                };
                v4.blob_count = v5;
            };
        };
        if (0x1::option::is_some<vector<u8>>(&v0.seal_marker)) {
            let v6 = *0x1::option::borrow<vector<u8>>(&v0.seal_marker);
            if (0x2::table::contains<vector<u8>, 0x1::option::Option<u64>>(&arg0.marker_folder, v6)) {
                0x2::table::remove<vector<u8>, 0x1::option::Option<u64>>(&mut arg0.marker_folder, v6);
            };
        };
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::release_storage(arg1, v0.size_bytes, 1, v0.encrypted);
        let v7 = BlobReleased{
            blob_id    : v0.blob_id,
            owner      : arg0.owner,
            size_bytes : v0.size_bytes,
            epoch      : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BlobReleased>(v7);
        v0
    }

    public fun remove_blob_share(arg0: &mut BlobStore, arg1: vector<u8>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 407);
        assert!(0x1::vector::length<u8>(&arg1) == 16, 422);
        assert!(0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.shares, arg1), 424);
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.shares, arg1);
        assert!(0x2::vec_set::contains<address>(v0, &arg2), 424);
        0x2::vec_set::remove<address>(v0, &arg2);
        if (0x2::vec_set::length<address>(v0) == 0) {
            0x2::vec_set::into_keys<address>(0x2::table::remove<vector<u8>, 0x2::vec_set::VecSet<address>>(&mut arg0.shares, arg1));
            let (v1, v2) = 0x1::vector::index_of<vector<u8>>(&arg0.share_markers, &arg1);
            if (v1) {
                0x1::vector::remove<vector<u8>>(&mut arg0.share_markers, v2);
            };
        };
        let v3 = BlobShareRemoved{
            store_id    : 0x2::object::id<BlobStore>(arg0),
            owner       : arg0.owner,
            seal_marker : arg1,
            viewer      : arg2,
            epoch       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BlobShareRemoved>(v3);
    }

    public fun remove_folder_viewer(arg0: &mut BlobStore, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 407);
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg1), 430);
        let v0 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, arg1);
        assert!(0x2::vec_set::contains<address>(&v0.viewers, &arg2), 436);
        0x2::vec_set::remove<address>(&mut v0.viewers, &arg2);
        let v1 = if (arg0.folder_viewer_count > 0) {
            arg0.folder_viewer_count - 1
        } else {
            0
        };
        arg0.folder_viewer_count = v1;
        let v2 = FolderViewerRemoved{
            store_id  : 0x2::object::id<BlobStore>(arg0),
            folder_id : arg1,
            viewer    : arg2,
            epoch     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<FolderViewerRemoved>(v2);
    }

    public fun remove_viewer(arg0: &mut BlobStore, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 407);
        assert!(0x2::vec_set::contains<address>(&arg0.viewers, &arg1), 416);
        0x2::vec_set::remove<address>(&mut arg0.viewers, &arg1);
        let v0 = ViewerRemoved{
            store_id : 0x2::object::id<BlobStore>(arg0),
            owner    : arg0.owner,
            viewer   : arg1,
            epoch    : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<ViewerRemoved>(v0);
    }

    public fun rename_folder(arg0: &mut BlobStore, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 407);
        assert!(0x2::table::contains<u64, Folder>(&arg0.folders, arg1), 430);
        assert_valid_folder_name(&arg2);
        let v0 = 0x2::table::borrow_mut<u64, Folder>(&mut arg0.folders, arg1);
        v0.name = arg2;
        let v1 = FolderRenamed{
            store_id  : 0x2::object::id<BlobStore>(arg0),
            folder_id : arg1,
            old_name  : v0.name,
            new_name  : arg2,
            epoch     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<FolderRenamed>(v1);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &BlobStore, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_id_bound_to_store(&arg0, arg1);
        if (v0 == arg1.owner || 0x2::vec_set::contains<address>(&arg1.viewers, &v0)) {
            return
        };
        let v1 = 0x2::object::id<BlobStore>(arg1);
        let v2 = 0x2::object::id_to_bytes(&v1);
        let v3 = 0x1::vector::length<u8>(&v2);
        assert!(0x1::vector::length<u8>(&arg0) >= v3 + 16, 409);
        let v4 = b"";
        let v5 = 0;
        while (v5 < 16) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&arg0, v3 + v5));
            v5 = v5 + 1;
        };
        if (0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.shares, v4)) {
            if (0x2::vec_set::contains<address>(0x2::table::borrow<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg1.shares, v4), &v0)) {
                return
            };
        };
        assert!(marker_folder_grants(arg1, v4, v0), 407);
    }

    public fun store_blob_share_contains(arg0: &BlobStore, arg1: vector<u8>, arg2: address) : bool {
        !0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.shares, arg1) && false || 0x2::vec_set::contains<address>(0x2::table::borrow<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.shares, arg1), &arg2)
    }

    public fun store_blob_share_viewers(arg0: &BlobStore, arg1: vector<u8>) : 0x1::option::Option<vector<address>> {
        if (0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.shares, arg1)) {
            0x1::option::some<vector<address>>(*0x2::vec_set::keys<address>(0x2::table::borrow<vector<u8>, 0x2::vec_set::VecSet<address>>(&arg0.shares, arg1)))
        } else {
            0x1::option::none<vector<address>>()
        }
    }

    public fun store_can_view(arg0: &BlobStore, arg1: address) : bool {
        arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.viewers, &arg1)
    }

    public fun store_folder_count(arg0: &BlobStore) : u64 {
        0x1::vector::length<u64>(&arg0.folder_ids)
    }

    public fun store_folder_ids(arg0: &BlobStore) : &vector<u64> {
        &arg0.folder_ids
    }

    public fun store_folder_viewer_count(arg0: &BlobStore) : u64 {
        arg0.folder_viewer_count
    }

    public fun store_has_folder(arg0: &BlobStore, arg1: u64) : bool {
        0x2::table::contains<u64, Folder>(&arg0.folders, arg1)
    }

    public fun store_owner(arg0: &BlobStore) : address {
        arg0.owner
    }

    public fun store_share_count(arg0: &BlobStore) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.share_markers)
    }

    public fun store_share_markers(arg0: &BlobStore) : &vector<vector<u8>> {
        &arg0.share_markers
    }

    public fun store_total_blobs(arg0: &BlobStore) : u64 {
        arg0.total_blobs
    }

    public fun store_total_size(arg0: &BlobStore) : u64 {
        arg0.total_size_bytes
    }

    public fun store_viewer_count(arg0: &BlobStore) : u64 {
        0x2::vec_set::length<address>(&arg0.viewers)
    }

    public fun store_viewers(arg0: &BlobStore) : &0x2::vec_set::VecSet<address> {
        &arg0.viewers
    }

    public fun transfer_account(arg0: &mut 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::GlobalConfig, arg1: 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::UserAccount, arg2: 0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::Subscription, arg3: &mut BlobStore, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_not_paused(arg0);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::account_owner(&arg1) == v0, 407);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::sub_owner(&arg2) == v0, 407);
        assert!(arg3.owner == v0, 407);
        assert!(arg4 != v0, 413);
        assert!(0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::account_active_jobs(&arg1) == 0, 414);
        let v1 = 0x2::object::id<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::UserAccount>(&arg1);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::set_account_owner(&mut arg1, arg4);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::set_sub_owner(&mut arg2, arg4);
        arg3.owner = arg4;
        arg3.viewers = 0x2::vec_set::empty<address>();
        assert!(0x1::vector::is_empty<vector<u8>>(&arg3.share_markers), 429);
        assert!(arg3.folder_viewer_count == 0, 437);
        0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::admin::reassign_user_account(arg0, v0, arg4, v1, arg5);
        let v2 = AccountTransferred{
            from            : v0,
            to              : arg4,
            account_id      : v1,
            subscription_id : 0x2::object::id<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::Subscription>(&arg2),
            store_id        : 0x2::object::id<BlobStore>(arg3),
            epoch           : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<AccountTransferred>(v2);
        0x2::transfer::public_transfer<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::UserAccount>(arg1, arg4);
        0x2::transfer::public_transfer<0x2f548bb4bb1e5f7622c527417d3c0221840d0412ec23d70306f1bd4b79c20b45::subscription::Subscription>(arg2, arg4);
    }

    // decompiled from Move bytecode v7
}

