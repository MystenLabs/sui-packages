module 0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments {
    struct CommentsTree has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        owner: address,
        registry_id: 0x2::object::ID,
        paper_key: 0x1::string::String,
        paper_object_id: 0x2::object::ID,
        root_comment_id: u64,
        next_comment_id: u64,
        total_comments: u64,
        status: u8,
        max_onchain_comment_bytes: u64,
        max_comment_depth: u16,
        created_at_ms: u64,
        like_count: u64,
        likes: 0x2::table::Table<address, bool>,
        nodes: 0x2::table::Table<u64, CommentNode>,
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
        paper_key: 0x1::string::String,
        created_at_ms: u64,
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
        tree_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
    }

    struct CommentStatusChangedEvent has copy, drop {
        tree_id: 0x2::object::ID,
        comment_id: u64,
        old_status: u8,
        new_status: u8,
    }

    struct TreeOwnerTransferredEvent has copy, drop {
        tree_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    struct PaperLikedEvent has copy, drop {
        tree_id: 0x2::object::ID,
        liker: address,
        like_count: u64,
    }

    struct PaperUnlikedEvent has copy, drop {
        tree_id: 0x2::object::ID,
        liker: address,
        like_count: u64,
    }

    public fun add_blob_comment(arg0: &mut CommentsTree, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: u64, arg3: vector<u8>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg1);
        assert_tree_open(arg0);
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg2), 3);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 6);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 7);
        assert!(0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::registry_id(arg1) == arg0.registry_id, 14);
        let v0 = 0x2::table::borrow<u64, CommentNode>(&arg0.nodes, arg2).depth + 1;
        assert!(v0 <= arg0.max_comment_depth, 13);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::collect_comments_fee(arg1, arg7, arg9);
        let v1 = arg0.next_comment_id;
        arg0.next_comment_id = v1 + 1;
        arg0.total_comments = arg0.total_comments + 1;
        let v2 = 0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg2);
        v2.children_count = v2.children_count + 1;
        let v3 = 0x2::clock::timestamp_ms(arg8);
        let v4 = CommentNode{
            comment_id        : v1,
            parent_comment_id : 0x1::option::some<u64>(arg2),
            author            : 0x2::tx_context::sender(arg9),
            depth             : v0,
            content_mode      : 2,
            inline_content    : b"",
            content_preview   : arg6,
            blob_id           : arg3,
            blob_object_id    : arg4,
            blob_digest       : arg5,
            children_count    : 0,
            created_at_ms     : v3,
            edited_at_ms      : 0x1::option::none<u64>(),
            status            : 0,
        };
        0x2::table::add<u64, CommentNode>(&mut arg0.nodes, v1, v4);
        let v5 = CommentAddedEvent{
            tree_id           : *0x2::object::uid_as_inner(&arg0.id),
            comment_id        : v1,
            parent_comment_id : arg2,
            author            : 0x2::tx_context::sender(arg9),
            depth             : v0,
            content_mode      : 2,
            created_at_ms     : v3,
        };
        0x2::event::emit<CommentAddedEvent>(v5);
    }

    public fun add_onchain_comment(arg0: &mut CommentsTree, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: u64, arg3: vector<u8>, arg4: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg1);
        assert_tree_open(arg0);
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg2), 3);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 4);
        assert!(0x1::vector::length<u8>(&arg3) <= arg0.max_onchain_comment_bytes, 5);
        assert!(0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::registry_id(arg1) == arg0.registry_id, 14);
        let v0 = 0x2::table::borrow<u64, CommentNode>(&arg0.nodes, arg2).depth + 1;
        assert!(v0 <= arg0.max_comment_depth, 13);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::collect_comments_fee(arg1, arg4, arg6);
        let v1 = arg0.next_comment_id;
        arg0.next_comment_id = v1 + 1;
        arg0.total_comments = arg0.total_comments + 1;
        let v2 = 0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg2);
        v2.children_count = v2.children_count + 1;
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = CommentNode{
            comment_id        : v1,
            parent_comment_id : 0x1::option::some<u64>(arg2),
            author            : 0x2::tx_context::sender(arg6),
            depth             : v0,
            content_mode      : 1,
            inline_content    : arg3,
            content_preview   : b"",
            blob_id           : b"",
            blob_object_id    : 0x1::option::none<0x2::object::ID>(),
            blob_digest       : b"",
            children_count    : 0,
            created_at_ms     : v3,
            edited_at_ms      : 0x1::option::none<u64>(),
            status            : 0,
        };
        0x2::table::add<u64, CommentNode>(&mut arg0.nodes, v1, v4);
        let v5 = CommentAddedEvent{
            tree_id           : *0x2::object::uid_as_inner(&arg0.id),
            comment_id        : v1,
            parent_comment_id : arg2,
            author            : 0x2::tx_context::sender(arg6),
            depth             : v0,
            content_mode      : 1,
            created_at_ms     : v3,
        };
        0x2::event::emit<CommentAddedEvent>(v5);
    }

    fun assert_current_tree(arg0: &CommentsTree) {
        assert!(arg0.version == 1, 19);
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

    public fun has_comment(arg0: &CommentsTree, arg1: u64) : bool {
        0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg1)
    }

    public fun has_liked(arg0: &CommentsTree, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.likes, arg1)
    }

    public fun inline_content(arg0: &CommentNode) : &vector<u8> {
        &arg0.inline_content
    }

    public fun like_count(arg0: &CommentsTree) : u64 {
        arg0.like_count
    }

    public fun like_paper(arg0: &mut CommentsTree, arg1: &0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg2: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(arg1) >= 1000000000, 16);
        assert!(!0x2::table::contains<address, bool>(&arg0.likes, v0), 17);
        0x2::table::add<address, bool>(&mut arg0.likes, v0, true);
        arg0.like_count = arg0.like_count + 1;
        let v1 = PaperLikedEvent{
            tree_id    : *0x2::object::uid_as_inner(&arg0.id),
            liker      : v0,
            like_count : arg0.like_count,
        };
        0x2::event::emit<PaperLikedEvent>(v1);
    }

    public fun max_comment_depth(arg0: &CommentsTree) : u16 {
        arg0.max_comment_depth
    }

    public fun max_onchain_comment_bytes(arg0: &CommentsTree) : u64 {
        arg0.max_onchain_comment_bytes
    }

    public fun migrate_tree(arg0: &mut CommentsTree, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: &0x2::tx_context::TxContext) {
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg1);
        assert!(0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::registry_id(arg1) == arg0.registry_id, 14);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_upgrade_authority(arg1, 0x2::tx_context::sender(arg2));
        migrate_tree_version(arg0);
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

    public fun new_tree(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : CommentsTree {
        assert!(!0x1::string::is_empty(&arg2), 1);
        let v0 = CommentsTree{
            id                        : 0x2::object::new(arg5),
            version                   : 1,
            creator                   : 0x2::tx_context::sender(arg5),
            owner                     : arg1,
            registry_id               : arg0,
            paper_key                 : arg2,
            paper_object_id           : arg3,
            root_comment_id           : 0,
            next_comment_id           : 1,
            total_comments            : 0,
            status                    : 0,
            max_onchain_comment_bytes : 512,
            max_comment_depth         : 64,
            created_at_ms             : 0x2::clock::timestamp_ms(arg4),
            like_count                : 0,
            likes                     : 0x2::table::new<address, bool>(arg5),
            nodes                     : 0x2::table::new<u64, CommentNode>(arg5),
        };
        let v1 = CommentNode{
            comment_id        : 0,
            parent_comment_id : 0x1::option::none<u64>(),
            author            : 0x2::tx_context::sender(arg5),
            depth             : 0,
            content_mode      : 1,
            inline_content    : b"",
            content_preview   : b"",
            blob_id           : b"",
            blob_object_id    : 0x1::option::none<0x2::object::ID>(),
            blob_digest       : b"",
            children_count    : 0,
            created_at_ms     : v0.created_at_ms,
            edited_at_ms      : 0x1::option::none<u64>(),
            status            : 0,
        };
        0x2::table::add<u64, CommentNode>(&mut v0.nodes, 0, v1);
        let v2 = TreeCreatedEvent{
            tree_id       : *0x2::object::uid_as_inner(&v0.id),
            creator       : v0.creator,
            owner         : v0.owner,
            paper_key     : v0.paper_key,
            created_at_ms : v0.created_at_ms,
        };
        0x2::event::emit<TreeCreatedEvent>(v2);
        v0
    }

    public fun next_comment_id(arg0: &CommentsTree) : u64 {
        arg0.next_comment_id
    }

    public fun owner(arg0: &CommentsTree) : address {
        arg0.owner
    }

    public fun paper_key(arg0: &CommentsTree) : &0x1::string::String {
        &arg0.paper_key
    }

    public fun paper_object_id(arg0: &CommentsTree) : 0x2::object::ID {
        arg0.paper_object_id
    }

    public fun parent_comment_id(arg0: &CommentNode) : &0x1::option::Option<u64> {
        &arg0.parent_comment_id
    }

    public fun registry_id(arg0: &CommentsTree) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun root_comment_id(arg0: &CommentsTree) : u64 {
        arg0.root_comment_id
    }

    public fun set_comment_status(arg0: &mut CommentsTree, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        assert_valid_comment_status(arg2);
        assert!(0x2::table::contains<u64, CommentNode>(&arg0.nodes, arg1), 11);
        let v0 = 0x2::table::borrow_mut<u64, CommentNode>(&mut arg0.nodes, arg1);
        assert!(v0.author == 0x2::tx_context::sender(arg3) || arg0.owner == 0x2::tx_context::sender(arg3), 12);
        v0.status = arg2;
        v0.edited_at_ms = 0x1::option::none<u64>();
        let v1 = CommentStatusChangedEvent{
            tree_id    : *0x2::object::uid_as_inner(&arg0.id),
            comment_id : arg1,
            old_status : v0.status,
            new_status : arg2,
        };
        0x2::event::emit<CommentStatusChangedEvent>(v1);
    }

    public fun set_tree_status(arg0: &mut CommentsTree, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        assert_tree_owner(arg0, arg2);
        assert_valid_tree_status(arg1);
        arg0.status = arg1;
        let v0 = TreeStatusChangedEvent{
            tree_id    : *0x2::object::uid_as_inner(&arg0.id),
            old_status : arg0.status,
            new_status : arg1,
        };
        0x2::event::emit<TreeStatusChangedEvent>(v0);
    }

    public fun share_tree(arg0: CommentsTree) {
        0x2::transfer::share_object<CommentsTree>(arg0);
    }

    public fun status(arg0: &CommentNode) : u8 {
        arg0.status
    }

    public fun total_comments(arg0: &CommentsTree) : u64 {
        arg0.total_comments
    }

    public fun transfer_tree_owner(arg0: &mut CommentsTree, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 8);
        assert!(arg1 != @0x0, 15);
        arg0.owner = arg1;
        let v0 = TreeOwnerTransferredEvent{
            tree_id   : *0x2::object::uid_as_inner(&arg0.id),
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<TreeOwnerTransferredEvent>(v0);
    }

    public fun tree_id(arg0: &CommentsTree) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
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

    public fun tree_version(arg0: &CommentsTree) : u64 {
        arg0.version
    }

    public fun unlike_paper(arg0: &mut CommentsTree, arg1: &0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg2: &0x2::tx_context::TxContext) {
        assert_current_tree(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(arg1) >= 1000000000, 16);
        assert!(0x2::table::contains<address, bool>(&arg0.likes, v0), 18);
        0x2::table::remove<address, bool>(&mut arg0.likes, v0);
        arg0.like_count = arg0.like_count - 1;
        let v1 = PaperUnlikedEvent{
            tree_id    : *0x2::object::uid_as_inner(&arg0.id),
            liker      : v0,
            like_count : arg0.like_count,
        };
        0x2::event::emit<PaperUnlikedEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

