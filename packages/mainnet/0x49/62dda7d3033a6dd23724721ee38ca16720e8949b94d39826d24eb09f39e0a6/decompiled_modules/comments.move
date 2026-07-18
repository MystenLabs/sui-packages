module 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments {
    struct CommentsTree has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        owner: address,
        registry_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
        fee_manager_id: 0x2::object::ID,
        target_key: 0x1::string::String,
        target_series_id: 0x2::object::ID,
        target_artifact_type: u8,
        root_comment_id: u64,
        next_comment_id: u64,
        total_comments: u64,
        status: u8,
        max_onchain_comment_bytes: u64,
        max_comment_depth: u16,
        created_at_ms: u64,
        likes_book_id: 0x2::object::ID,
        nodes: 0x2::table::Table<u64, CommentNode>,
    }

    struct LikesBook has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        comments_tree_id: 0x2::object::ID,
        target_series_id: 0x2::object::ID,
        target_artifact_type: u8,
        like_count: u64,
        likes: 0x2::table::Table<address, bool>,
    }

    struct TreeFactoryCap has drop, store {
        registry_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
        fee_manager_id: 0x2::object::ID,
    }

    struct CommentNode has store {
        comment_id: u64,
        parent_comment_id: 0x1::option::Option<u64>,
        author: address,
        depth: u16,
        content_mode: u8,
        inline_content: vector<u8>,
        content_preview: vector<u8>,
        blob_id: vector<u8>,
        blob_object_id: 0x1::option::Option<0x2::object::ID>,
        blob_digest: vector<u8>,
        children_count: u64,
        created_at_ms: u64,
        edited_at_ms: 0x1::option::Option<u64>,
        status: u8,
    }

    struct TreeCreatedEvent has copy, drop {
        tree_id: 0x2::object::ID,
        creator: address,
        owner: address,
        registry_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
        fee_manager_id: 0x2::object::ID,
        target_key: 0x1::string::String,
        target_series_id: 0x2::object::ID,
        target_artifact_type: u8,
        created_at_ms: u64,
        likes_book_id: 0x2::object::ID,
    }

    struct CommentAddedEvent has copy, drop {
        tree_id: 0x2::object::ID,
        comment_id: u64,
        parent_comment_id: u64,
        author: address,
        depth: u16,
        content_mode: u8,
        created_at_ms: u64,
    }

    struct TreeStatusChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        tree_id: 0x2::object::ID,
        changed_by: address,
        old_status: u8,
        new_status: u8,
    }

    struct CommentStatusChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        tree_id: 0x2::object::ID,
        comment_id: u64,
        changed_by: address,
        old_status: u8,
        new_status: u8,
    }

    struct TreeOwnerTransferredEvent has copy, drop {
        registry_id: 0x2::object::ID,
        tree_id: 0x2::object::ID,
        changed_by: address,
        old_owner: address,
        new_owner: address,
    }

    struct CommentsTreeMigratedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        tree_id: 0x2::object::ID,
        migrated_by: address,
        new_version: u64,
    }

    struct PaperLikedEvent has copy, drop {
        tree_id: 0x2::object::ID,
        likes_book_id: 0x2::object::ID,
        target_series_id: 0x2::object::ID,
        liker: address,
        like_count: u64,
    }

    struct PaperUnlikedEvent has copy, drop {
        tree_id: 0x2::object::ID,
        likes_book_id: 0x2::object::ID,
        target_series_id: 0x2::object::ID,
        liker: address,
        like_count: u64,
    }

    public fun fee_manager_id(arg0: &CommentsTree) : 0x2::object::ID {
        arg0.fee_manager_id
    }

    public fun registry_id(arg0: &CommentsTree) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun add_blob_comment(arg0: &mut CommentsTree, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg3: u64, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg1);
        assert_tree_open(arg0);
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg3), 3);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 6);
        assert!(!0x1::vector::is_empty<u8>(&arg6), 7);
        assert!(0x1::vector::length<u8>(&arg4) <= 128, 21);
        assert!(0x1::vector::length<u8>(&arg6) <= 128, 22);
        assert!(0x1::vector::length<u8>(&arg7) <= 256, 23);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg1) == arg0.registry_id, 14);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_registry_id(arg2) == arg0.registry_id, 14);
        assert!(0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1) == arg0.governance_vault_id, 14);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg2) == arg0.fee_manager_id, 14);
        let v0 = 0x2::table::borrow<u64, CommentNode>(&arg0.nodes, arg3);
        assert!(v0.status == 0, 20);
        let v1 = v0.depth + 1;
        assert!(v1 <= arg0.max_comment_depth, 13);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::collect_comments_fee(arg1, arg2, arg8, arg10);
        let v2 = arg0.next_comment_id;
        arg0.next_comment_id = v2 + 1;
        arg0.total_comments = arg0.total_comments + 1;
        let v3 = 0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg3);
        v3.children_count = v3.children_count + 1;
        let v4 = 0x2::clock::timestamp_ms(arg9);
        let v5 = CommentNode{
            comment_id        : v2,
            parent_comment_id : 0x1::option::some<u64>(arg3),
            author            : 0x2::tx_context::sender(arg10),
            depth             : v1,
            content_mode      : 2,
            inline_content    : b"",
            content_preview   : arg7,
            blob_id           : arg4,
            blob_object_id    : arg5,
            blob_digest       : arg6,
            children_count    : 0,
            created_at_ms     : v4,
            edited_at_ms      : 0x1::option::none<u64>(),
            status            : 0,
        };
        0x2::table::add<u64, CommentNode>(&mut arg0.nodes, v2, v5);
        let v6 = CommentAddedEvent{
            tree_id           : *0x2::object::uid_as_inner(&arg0.id),
            comment_id        : v2,
            parent_comment_id : arg3,
            author            : 0x2::tx_context::sender(arg10),
            depth             : v1,
            content_mode      : 2,
            created_at_ms     : v4,
        };
        0x2::event::emit<CommentAddedEvent>(v6);
    }

    public fun add_onchain_comment(arg0: &mut CommentsTree, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg3: u64, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg1);
        assert_tree_open(arg0);
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg3), 3);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 4);
        assert!(0x1::vector::length<u8>(&arg4) <= arg0.max_onchain_comment_bytes, 5);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg1) == arg0.registry_id, 14);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_registry_id(arg2) == arg0.registry_id, 14);
        assert!(0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1) == arg0.governance_vault_id, 14);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg2) == arg0.fee_manager_id, 14);
        let v0 = 0x2::table::borrow<u64, CommentNode>(&arg0.nodes, arg3);
        assert!(v0.status == 0, 20);
        let v1 = v0.depth + 1;
        assert!(v1 <= arg0.max_comment_depth, 13);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::collect_comments_fee(arg1, arg2, arg5, arg7);
        let v2 = arg0.next_comment_id;
        arg0.next_comment_id = v2 + 1;
        arg0.total_comments = arg0.total_comments + 1;
        let v3 = 0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg3);
        v3.children_count = v3.children_count + 1;
        let v4 = 0x2::clock::timestamp_ms(arg6);
        let v5 = CommentNode{
            comment_id        : v2,
            parent_comment_id : 0x1::option::some<u64>(arg3),
            author            : 0x2::tx_context::sender(arg7),
            depth             : v1,
            content_mode      : 1,
            inline_content    : arg4,
            content_preview   : b"",
            blob_id           : b"",
            blob_object_id    : 0x1::option::none<0x2::object::ID>(),
            blob_digest       : b"",
            children_count    : 0,
            created_at_ms     : v4,
            edited_at_ms      : 0x1::option::none<u64>(),
            status            : 0,
        };
        0x2::table::add<u64, CommentNode>(&mut arg0.nodes, v2, v5);
        let v6 = CommentAddedEvent{
            tree_id           : *0x2::object::uid_as_inner(&arg0.id),
            comment_id        : v2,
            parent_comment_id : arg3,
            author            : 0x2::tx_context::sender(arg7),
            depth             : v1,
            content_mode      : 1,
            created_at_ms     : v4,
        };
        0x2::event::emit<CommentAddedEvent>(v6);
    }

    fun assert_current_likes_book(arg0: &LikesBook) {
        assert!(arg0.version == 1, 19);
    }

    fun assert_current_tree(arg0: &CommentsTree) {
        assert!(arg0.version == 1, 19);
    }

    fun assert_tree_factory_cap(arg0: &TreeFactoryCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(arg0.registry_id == arg1, 24);
        assert!(arg0.governance_vault_id == arg2, 24);
        assert!(arg0.fee_manager_id == arg3, 24);
    }

    fun assert_tree_open(arg0: &CommentsTree) {
        assert!(arg0.status == 0, 2);
    }

    fun assert_tree_owner(arg0: &CommentsTree, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 8);
    }

    fun assert_valid_comment_status(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 10);
    }

    fun assert_valid_tree_status(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 9);
    }

    public fun blob_digest(arg0: &CommentNode) : &vector<u8> {
        &arg0.blob_digest
    }

    public fun blob_id(arg0: &CommentNode) : &vector<u8> {
        &arg0.blob_id
    }

    public fun blob_object_id(arg0: &CommentNode) : &0x1::option::Option<0x2::object::ID> {
        &arg0.blob_object_id
    }

    public fun borrow_comment(arg0: &CommentsTree, arg1: u64) : &CommentNode {
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg1), 11);
        0x2::table::borrow<u64, CommentNode>(&arg0.nodes, arg1)
    }

    public fun borrow_comment_mut(arg0: &mut CommentsTree, arg1: u64) : &mut CommentNode {
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg1), 11);
        0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg1)
    }

    public fun children_count(arg0: &CommentNode) : u64 {
        arg0.children_count
    }

    public fun comment_author(arg0: &CommentNode) : address {
        arg0.author
    }

    public fun comment_depth(arg0: &CommentNode) : u16 {
        arg0.depth
    }

    public fun comment_id(arg0: &CommentNode) : u64 {
        arg0.comment_id
    }

    public fun comment_mode_blob() : u8 {
        2
    }

    public fun comment_mode_onchain() : u8 {
        1
    }

    public fun comment_status_active() : u8 {
        0
    }

    public fun comment_status_deleted() : u8 {
        2
    }

    public fun comment_status_hidden() : u8 {
        1
    }

    public fun content_mode(arg0: &CommentNode) : u8 {
        arg0.content_mode
    }

    public fun content_preview(arg0: &CommentNode) : &vector<u8> {
        &arg0.content_preview
    }

    public fun created_at_ms(arg0: &CommentNode) : u64 {
        arg0.created_at_ms
    }

    public fun creator(arg0: &CommentsTree) : address {
        arg0.creator
    }

    public fun current_tree_version() : u64 {
        1
    }

    public fun governance_vault_id(arg0: &CommentsTree) : 0x2::object::ID {
        arg0.governance_vault_id
    }

    public fun has_comment(arg0: &CommentsTree, arg1: u64) : bool {
        0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg1)
    }

    public fun has_liked(arg0: &LikesBook, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.likes, arg1)
    }

    public fun inline_content(arg0: &CommentNode) : &vector<u8> {
        &arg0.inline_content
    }

    public fun like_count(arg0: &LikesBook) : u64 {
        arg0.like_count
    }

    public fun like_paper(arg0: &mut LikesBook, arg1: &0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg2: &0x2::tx_context::TxContext) {
        assert_current_likes_book(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(arg1) >= 1000000000, 16);
        assert!(!0x2::table::contains<address, bool>(&arg0.likes, v0), 17);
        0x2::table::add<address, bool>(&mut arg0.likes, v0, true);
        arg0.like_count = arg0.like_count + 1;
        let v1 = PaperLikedEvent{
            tree_id          : arg0.comments_tree_id,
            likes_book_id    : 0x2::object::id<LikesBook>(arg0),
            target_series_id : arg0.target_series_id,
            liker            : v0,
            like_count       : arg0.like_count,
        };
        0x2::event::emit<PaperLikedEvent>(v1);
    }

    public fun likes_book_comments_tree_id(arg0: &LikesBook) : 0x2::object::ID {
        arg0.comments_tree_id
    }

    public fun likes_book_id(arg0: &LikesBook) : 0x2::object::ID {
        0x2::object::id<LikesBook>(arg0)
    }

    public fun likes_book_registry_id(arg0: &LikesBook) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun likes_book_target_artifact_type(arg0: &LikesBook) : u8 {
        arg0.target_artifact_type
    }

    public fun likes_book_target_series_id(arg0: &LikesBook) : 0x2::object::ID {
        arg0.target_series_id
    }

    public fun likes_book_version(arg0: &LikesBook) : u64 {
        arg0.version
    }

    public fun max_comment_depth(arg0: &CommentsTree) : u16 {
        arg0.max_comment_depth
    }

    public fun max_onchain_comment_bytes(arg0: &CommentsTree) : u64 {
        arg0.max_onchain_comment_bytes
    }

    public fun migrate_tree(arg0: &mut CommentsTree, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &0x2::tx_context::TxContext) {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg1);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg1) == arg0.registry_id, 14);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_upgrade_authority(arg1, 0x2::tx_context::sender(arg2));
        migrate_tree_version(arg0);
        let v0 = CommentsTreeMigratedEvent{
            registry_id : arg0.registry_id,
            tree_id     : *0x2::object::uid_as_inner(&arg0.id),
            migrated_by : 0x2::tx_context::sender(arg2),
            new_version : arg0.version,
        };
        0x2::event::emit<CommentsTreeMigratedEvent>(v0);
    }

    fun migrate_tree_version(arg0: &mut CommentsTree) {
        assert!(arg0.version <= 1, 19);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun minimum_pprf_for_like() : u64 {
        1000000000
    }

    public fun new_tree(arg0: &TreeFactoryCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x1::string::String, arg6: 0x2::object::ID, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (CommentsTree, LikesBook) {
        assert_tree_factory_cap(arg0, arg1, arg2, arg3);
        assert!(!0x1::string::is_empty(&arg5), 1);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::new(arg9);
        let v2 = CommentsTree{
            id                        : v0,
            version                   : 1,
            creator                   : 0x2::tx_context::sender(arg9),
            owner                     : arg4,
            registry_id               : arg1,
            governance_vault_id       : arg2,
            fee_manager_id            : arg3,
            target_key                : arg5,
            target_series_id          : arg6,
            target_artifact_type      : arg7,
            root_comment_id           : 0,
            next_comment_id           : 1,
            total_comments            : 0,
            status                    : 0,
            max_onchain_comment_bytes : 512,
            max_comment_depth         : 64,
            created_at_ms             : 0x2::clock::timestamp_ms(arg8),
            likes_book_id             : *0x2::object::uid_as_inner(&v1),
            nodes                     : 0x2::table::new<u64, CommentNode>(arg9),
        };
        let v3 = LikesBook{
            id                   : v1,
            version              : 1,
            registry_id          : arg1,
            comments_tree_id     : *0x2::object::uid_as_inner(&v0),
            target_series_id     : arg6,
            target_artifact_type : arg7,
            like_count           : 0,
            likes                : 0x2::table::new<address, bool>(arg9),
        };
        let v4 = CommentNode{
            comment_id        : 0,
            parent_comment_id : 0x1::option::none<u64>(),
            author            : 0x2::tx_context::sender(arg9),
            depth             : 0,
            content_mode      : 1,
            inline_content    : b"",
            content_preview   : b"",
            blob_id           : b"",
            blob_object_id    : 0x1::option::none<0x2::object::ID>(),
            blob_digest       : b"",
            children_count    : 0,
            created_at_ms     : v2.created_at_ms,
            edited_at_ms      : 0x1::option::none<u64>(),
            status            : 0,
        };
        0x2::table::add<u64, CommentNode>(&mut v2.nodes, 0, v4);
        (v2, v3)
    }

    public fun new_tree_factory_cap(arg0: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg2: &mut 0x2::tx_context::TxContext) : TreeFactoryCap {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::governance_authority(arg0) || v0 == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::upgrade_authority(arg0), 24);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_registry_id(arg1) == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg0), 24);
        TreeFactoryCap{
            registry_id         : 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg0),
            governance_vault_id : 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg0),
            fee_manager_id      : 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg1),
        }
    }

    public fun next_comment_id(arg0: &CommentsTree) : u64 {
        arg0.next_comment_id
    }

    public fun owner(arg0: &CommentsTree) : address {
        arg0.owner
    }

    public fun parent_comment_id(arg0: &CommentNode) : &0x1::option::Option<u64> {
        &arg0.parent_comment_id
    }

    public fun root_comment_id(arg0: &CommentsTree) : u64 {
        arg0.root_comment_id
    }

    public fun set_comment_status(arg0: &mut CommentsTree, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        assert_valid_comment_status(arg2);
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg1), 11);
        assert!(arg1 != 0, 25);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (!0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::is_tree_control_enabled(&arg0.id)) {
            true
        } else if (0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::tree_authority_mode(&arg0.id) == 0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::authority_mode_dual()) {
            true
        } else {
            0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::tree_authority_mode(&arg0.id) == 0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::authority_mode_legacy_owner_only()
        };
        assert!(v0 == 0x2::table::borrow<u64, CommentNode>(&arg0.nodes, arg1).author && arg2 == 2 || v1 && v0 == arg0.owner, 12);
        let v2 = 0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg1);
        assert!(v2.status != 2, 26);
        v2.status = arg2;
        v2.edited_at_ms = 0x1::option::none<u64>();
        let v3 = CommentStatusChangedEvent{
            registry_id : arg0.registry_id,
            tree_id     : *0x2::object::uid_as_inner(&arg0.id),
            comment_id  : arg1,
            changed_by  : 0x2::tx_context::sender(arg3),
            old_status  : v2.status,
            new_status  : arg2,
        };
        0x2::event::emit<CommentStatusChangedEvent>(v3);
    }

    public fun set_comment_status_with_controller(arg0: &mut CommentsTree, arg1: &mut 0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::ArtifactControlRecord, arg2: &0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::ControllerNFT, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        assert_valid_comment_status(arg4);
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg3), 11);
        assert!(arg3 != 0, 25);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = false;
        if (0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::is_tree_control_enabled(&arg0.id)) {
            0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::assert_controller_for_tree(&arg0.id, tree_id(arg0), arg0.target_series_id, arg0.target_artifact_type, arg1, arg2, arg6);
            0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::sync_legacy_comments_owner_mirror(arg1, arg2, arg0.owner, arg5, arg6);
            v1 = true;
        };
        let v2 = 0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg3);
        assert!(v2.status != 2, 26);
        if (!v1 && v0 != v2.author) {
            assert!(v0 == arg0.owner, 12);
        } else if (!v1) {
            assert!(arg4 == 2, 12);
        };
        v2.status = arg4;
        v2.edited_at_ms = 0x1::option::none<u64>();
        let v3 = CommentStatusChangedEvent{
            registry_id : arg0.registry_id,
            tree_id     : *0x2::object::uid_as_inner(&arg0.id),
            comment_id  : arg3,
            changed_by  : 0x2::tx_context::sender(arg6),
            old_status  : v2.status,
            new_status  : arg4,
        };
        0x2::event::emit<CommentStatusChangedEvent>(v3);
    }

    public fun set_tree_status(arg0: &mut CommentsTree, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::assert_tree_legacy_write_allowed(&arg0.id);
        assert_tree_owner(arg0, arg2);
        assert_valid_tree_status(arg1);
        arg0.status = arg1;
        let v0 = TreeStatusChangedEvent{
            registry_id : arg0.registry_id,
            tree_id     : *0x2::object::uid_as_inner(&arg0.id),
            changed_by  : 0x2::tx_context::sender(arg2),
            old_status  : arg0.status,
            new_status  : arg1,
        };
        0x2::event::emit<TreeStatusChangedEvent>(v0);
    }

    public fun set_tree_status_with_controller(arg0: &mut CommentsTree, arg1: &mut 0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::ArtifactControlRecord, arg2: &0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::ControllerNFT, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::assert_controller_for_tree(&arg0.id, tree_id(arg0), arg0.target_series_id, arg0.target_artifact_type, arg1, arg2, arg5);
        assert_valid_tree_status(arg3);
        arg0.status = arg3;
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::sync_legacy_comments_owner_mirror(arg1, arg2, arg0.owner, arg4, arg5);
        let v0 = TreeStatusChangedEvent{
            registry_id : arg0.registry_id,
            tree_id     : *0x2::object::uid_as_inner(&arg0.id),
            changed_by  : 0x2::tx_context::sender(arg5),
            old_status  : arg0.status,
            new_status  : arg3,
        };
        0x2::event::emit<TreeStatusChangedEvent>(v0);
    }

    public fun share_likes_book(arg0: LikesBook) {
        0x2::transfer::share_object<LikesBook>(arg0);
    }

    public fun share_tree(arg0: CommentsTree) {
        0x2::transfer::share_object<CommentsTree>(arg0);
    }

    public fun status(arg0: &CommentNode) : u8 {
        arg0.status
    }

    public fun target_artifact_type(arg0: &CommentsTree) : u8 {
        arg0.target_artifact_type
    }

    public fun target_key(arg0: &CommentsTree) : &0x1::string::String {
        &arg0.target_key
    }

    public fun target_series_id(arg0: &CommentsTree) : 0x2::object::ID {
        arg0.target_series_id
    }

    public fun total_comments(arg0: &CommentsTree) : u64 {
        arg0.total_comments
    }

    public fun transfer_tree_owner(arg0: &mut CommentsTree, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::assert_tree_legacy_write_allowed(&arg0.id);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 8);
        assert!(arg1 != @0x0, 15);
        arg0.owner = arg1;
        let v0 = TreeOwnerTransferredEvent{
            registry_id : arg0.registry_id,
            tree_id     : *0x2::object::uid_as_inner(&arg0.id),
            changed_by  : 0x2::tx_context::sender(arg2),
            old_owner   : arg0.owner,
            new_owner   : arg1,
        };
        0x2::event::emit<TreeOwnerTransferredEvent>(v0);
    }

    public fun transfer_tree_owner_with_controller(arg0: &mut CommentsTree, arg1: &mut 0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::ArtifactControlRecord, arg2: &0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::ControllerNFT, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::assert_controller_for_tree(&arg0.id, tree_id(arg0), arg0.target_series_id, arg0.target_artifact_type, arg1, arg2, arg5);
        assert!(arg3 != @0x0, 15);
        arg0.owner = arg3;
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::sync_legacy_comments_owner_mirror(arg1, arg2, arg0.owner, arg4, arg5);
        let v0 = TreeOwnerTransferredEvent{
            registry_id : arg0.registry_id,
            tree_id     : *0x2::object::uid_as_inner(&arg0.id),
            changed_by  : 0x2::tx_context::sender(arg5),
            old_owner   : arg0.owner,
            new_owner   : arg3,
        };
        0x2::event::emit<TreeOwnerTransferredEvent>(v0);
    }

    public fun tree_authority_mode(arg0: &CommentsTree) : u8 {
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::tree_authority_mode(&arg0.id)
    }

    public fun tree_control_enabled(arg0: &CommentsTree) : bool {
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::is_tree_control_enabled(&arg0.id)
    }

    public fun tree_control_record_id(arg0: &CommentsTree) : 0x1::option::Option<0x2::object::ID> {
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::tree_control_record_id(&arg0.id)
    }

    public fun tree_controller_nft_id(arg0: &CommentsTree) : 0x1::option::Option<0x2::object::ID> {
        0xe68fef47337eb2ee970431fae9519c4b2bb9f4505a3d14b6b91fdfc6aae3b75c::controller::tree_controller_nft_id(&arg0.id)
    }

    public fun tree_factory_cap_registry_id(arg0: &TreeFactoryCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun tree_id(arg0: &CommentsTree) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public fun tree_likes_book_id(arg0: &CommentsTree) : 0x2::object::ID {
        arg0.likes_book_id
    }

    public fun tree_status(arg0: &CommentsTree) : u8 {
        arg0.status
    }

    public fun tree_status_archived() : u8 {
        2
    }

    public fun tree_status_locked() : u8 {
        1
    }

    public fun tree_status_open() : u8 {
        0
    }

    public fun tree_uid(arg0: &CommentsTree) : &0x2::object::UID {
        &arg0.id
    }

    public fun tree_uid_mut(arg0: &mut CommentsTree) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun tree_version(arg0: &CommentsTree) : u64 {
        arg0.version
    }

    public fun unlike_paper(arg0: &mut LikesBook, arg1: &0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg2: &0x2::tx_context::TxContext) {
        assert_current_likes_book(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(arg1) >= 1000000000, 16);
        assert!(0x2::table::contains<address, bool>(&arg0.likes, v0), 18);
        0x2::table::remove<address, bool>(&mut arg0.likes, v0);
        arg0.like_count = arg0.like_count - 1;
        let v1 = PaperUnlikedEvent{
            tree_id          : arg0.comments_tree_id,
            likes_book_id    : 0x2::object::id<LikesBook>(arg0),
            target_series_id : arg0.target_series_id,
            liker            : v0,
            like_count       : arg0.like_count,
        };
        0x2::event::emit<PaperUnlikedEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

