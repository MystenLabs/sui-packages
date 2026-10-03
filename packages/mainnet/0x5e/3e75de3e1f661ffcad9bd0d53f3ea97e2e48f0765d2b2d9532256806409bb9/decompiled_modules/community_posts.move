module 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::community_posts {
    struct CommunityRegistryV1 has key {
        id: 0x2::object::UID,
        version: u64,
        post_count: u64,
        by_index: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct PublicDocumentRefV1 has copy, drop, store {
        blob_object_id: 0x2::object::ID,
        blob_id: vector<u8>,
        sha256: vector<u8>,
        byte_length: u64,
    }

    struct PostV1 has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        profile_registry_id: 0x2::object::ID,
        author: 0x2::object::ID,
        author_owner: address,
        index: u64,
        post_type: u8,
        channel: u8,
        document: PublicDocumentRefV1,
        created_at_ms: u64,
        updated_at_ms: u64,
        comment_count: u64,
        comments_by_index: 0x2::table::Table<u64, 0x2::object::ID>,
        accepted_comment_id: 0x1::option::Option<0x2::object::ID>,
        acceptance_revision: u64,
    }

    struct CommentV1 has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        profile_registry_id: 0x2::object::ID,
        post_id: 0x2::object::ID,
        author: 0x2::object::ID,
        author_owner: address,
        index: u64,
        document: PublicDocumentRefV1,
        created_at_ms: u64,
    }

    struct CommunityRegistryCreatedV1 has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct PostCreatedV1 has copy, drop {
        registry_id: 0x2::object::ID,
        post_id: 0x2::object::ID,
        author: 0x2::object::ID,
        index: u64,
        timestamp_ms: u64,
    }

    struct CommentCreatedV1 has copy, drop {
        registry_id: 0x2::object::ID,
        post_id: 0x2::object::ID,
        comment_id: 0x2::object::ID,
        author: 0x2::object::ID,
        index: u64,
        timestamp_ms: u64,
    }

    struct AnswerAcceptedV1 has copy, drop {
        registry_id: 0x2::object::ID,
        post_id: 0x2::object::ID,
        comment_id: 0x2::object::ID,
        revision: u64,
    }

    public fun accept_answer(arg0: &CommunityRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg2: &mut PostV1, arg3: &CommentV1, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        assert_post(arg0, arg1, arg2);
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::is_registered_profile(arg1, 0x2::tx_context::sender(arg6), arg4), 1);
        assert!(arg2.author == arg4 && arg2.author_owner == 0x2::tx_context::sender(arg6), 7);
        assert!(arg2.post_type == 1, 8);
        assert!(arg3.version == 1, 0);
        assert!(arg3.registry_id == arg2.registry_id && arg3.profile_registry_id == arg2.profile_registry_id, 2);
        let v0 = 0x2::object::id<CommentV1>(arg3);
        let v1 = if (arg3.post_id == 0x2::object::id<PostV1>(arg2)) {
            if (0x2::table::contains<u64, 0x2::object::ID>(&arg2.comments_by_index, arg3.index)) {
                *0x2::table::borrow<u64, 0x2::object::ID>(&arg2.comments_by_index, arg3.index) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 9);
        assert!(arg2.acceptance_revision == arg5, 10);
        if (arg2.accepted_comment_id == 0x1::option::some<0x2::object::ID>(v0)) {
            return arg2.acceptance_revision
        };
        assert!(arg2.acceptance_revision < 18446744073709551615, 11);
        arg2.accepted_comment_id = 0x1::option::some<0x2::object::ID>(v0);
        arg2.acceptance_revision = arg2.acceptance_revision + 1;
        let v2 = AnswerAcceptedV1{
            registry_id : 0x2::object::id<CommunityRegistryV1>(arg0),
            post_id     : 0x2::object::id<PostV1>(arg2),
            comment_id  : v0,
            revision    : arg2.acceptance_revision,
        };
        0x2::event::emit<AnswerAcceptedV1>(v2);
        arg2.acceptance_revision
    }

    public fun acceptance_revision(arg0: &PostV1) : u64 {
        arg0.acceptance_revision
    }

    public fun accepted_comment_id(arg0: &PostV1) : 0x1::option::Option<0x2::object::ID> {
        arg0.accepted_comment_id
    }

    public(friend) fun assert_post(arg0: &CommunityRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg2: &PostV1) {
        assert!(arg0.version == 1 && arg2.version == 1, 0);
        let v0 = if (arg2.registry_id == 0x2::object::id<CommunityRegistryV1>(arg0)) {
            if (arg2.profile_registry_id == 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::registry_id(arg1)) {
                if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.by_index, arg2.index)) {
                    *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.by_index, arg2.index) == 0x2::object::id<PostV1>(arg2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    public fun comment_at_index(arg0: &PostV1, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.comments_by_index, arg1)
    }

    public fun comment_author(arg0: &CommentV1) : 0x2::object::ID {
        arg0.author
    }

    public fun comment_count(arg0: &PostV1) : u64 {
        arg0.comment_count
    }

    public fun comment_created_at_ms(arg0: &CommentV1) : u64 {
        arg0.created_at_ms
    }

    public fun comment_document(arg0: &CommentV1) : &PublicDocumentRefV1 {
        &arg0.document
    }

    public fun comment_post_id(arg0: &CommentV1) : 0x2::object::ID {
        arg0.post_id
    }

    public fun create_comment(arg0: &CommunityRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg2: &mut PostV1, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_post(arg0, arg1, arg2);
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::is_registered_profile(arg1, 0x2::tx_context::sender(arg9), arg3), 1);
        assert!(arg2.comment_count < 18446744073709551615, 6);
        let v0 = arg2.comment_count;
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = CommentV1{
            id                  : 0x2::object::new(arg9),
            version             : 1,
            registry_id         : 0x2::object::id<CommunityRegistryV1>(arg0),
            profile_registry_id : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::registry_id(arg1),
            post_id             : 0x2::object::id<PostV1>(arg2),
            author              : arg3,
            author_owner        : 0x2::tx_context::sender(arg9),
            index               : v0,
            document            : document_ref(arg4, arg5, arg6, arg7),
            created_at_ms       : v1,
        };
        let v3 = 0x2::object::id<CommentV1>(&v2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg2.comments_by_index, v0, v3);
        arg2.comment_count = v0 + 1;
        arg2.updated_at_ms = v1;
        let v4 = CommentCreatedV1{
            registry_id  : 0x2::object::id<CommunityRegistryV1>(arg0),
            post_id      : 0x2::object::id<PostV1>(arg2),
            comment_id   : v3,
            author       : arg3,
            index        : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<CommentCreatedV1>(v4);
        0x2::transfer::freeze_object<CommentV1>(v2);
        v3
    }

    public fun create_post(arg0: &mut CommunityRegistryV1, arg1: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::ProfileRegistryV1, arg2: 0x2::object::ID, arg3: u8, arg4: u8, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.version == 1, 0);
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::is_registered_profile(arg1, 0x2::tx_context::sender(arg10), arg2), 1);
        assert!(arg3 <= 2, 3);
        assert!(arg4 <= 1, 4);
        assert!(arg0.post_count < 18446744073709551615, 6);
        let v0 = arg0.post_count;
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = PostV1{
            id                  : 0x2::object::new(arg10),
            version             : 1,
            registry_id         : 0x2::object::id<CommunityRegistryV1>(arg0),
            profile_registry_id : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::profile::registry_id(arg1),
            author              : arg2,
            author_owner        : 0x2::tx_context::sender(arg10),
            index               : v0,
            post_type           : arg3,
            channel             : arg4,
            document            : document_ref(arg5, arg6, arg7, arg8),
            created_at_ms       : v1,
            updated_at_ms       : v1,
            comment_count       : 0,
            comments_by_index   : 0x2::table::new<u64, 0x2::object::ID>(arg10),
            accepted_comment_id : 0x1::option::none<0x2::object::ID>(),
            acceptance_revision : 0,
        };
        let v3 = 0x2::object::id<PostV1>(&v2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.by_index, v0, v3);
        arg0.post_count = v0 + 1;
        let v4 = PostCreatedV1{
            registry_id  : 0x2::object::id<CommunityRegistryV1>(arg0),
            post_id      : v3,
            author       : arg2,
            index        : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<PostCreatedV1>(v4);
        0x2::transfer::share_object<PostV1>(v2);
        v3
    }

    public fun created_at_ms(arg0: &PostV1) : u64 {
        arg0.created_at_ms
    }

    fun document_ref(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : PublicDocumentRefV1 {
        let v0 = if (arg0 != 0x2::object::id_from_address(@0x0)) {
            if (0x1::vector::length<u8>(&arg1) == 32) {
                if (0x1::vector::length<u8>(&arg2) == 32) {
                    arg3 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        PublicDocumentRefV1{
            blob_object_id : arg0,
            blob_id        : arg1,
            sha256         : arg2,
            byte_length    : arg3,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CommunityRegistryV1{
            id         : 0x2::object::new(arg0),
            version    : 1,
            post_count : 0,
            by_index   : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        let v1 = CommunityRegistryCreatedV1{registry_id: 0x2::object::id<CommunityRegistryV1>(&v0)};
        0x2::event::emit<CommunityRegistryCreatedV1>(v1);
        0x2::transfer::share_object<CommunityRegistryV1>(v0);
    }

    public fun post_at_index(arg0: &CommunityRegistryV1, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.by_index, arg1)
    }

    public fun post_author(arg0: &PostV1) : 0x2::object::ID {
        arg0.author
    }

    public fun post_count(arg0: &CommunityRegistryV1) : u64 {
        arg0.post_count
    }

    public fun post_document(arg0: &PostV1) : &PublicDocumentRefV1 {
        &arg0.document
    }

    public fun updated_at_ms(arg0: &PostV1) : u64 {
        arg0.updated_at_ms
    }

    // decompiled from Move bytecode v7
}

