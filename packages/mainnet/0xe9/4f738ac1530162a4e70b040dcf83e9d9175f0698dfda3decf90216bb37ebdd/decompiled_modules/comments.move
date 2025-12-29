module 0xe94f738ac1530162a4e70b040dcf83e9d9175f0698dfda3decf90216bb37ebdd::comments {
    struct Comment has store, key {
        id: 0x2::object::UID,
        document_id: 0x2::object::ID,
        author: address,
        comment_type: u8,
        blob_id: 0x1::string::String,
        seal_id: 0x1::string::String,
        content_hash: vector<u8>,
        timestamp: u64,
    }

    struct CommentThread has store, key {
        id: 0x2::object::UID,
        document_id: 0x2::object::ID,
        comments: vector<0x2::object::ID>,
        comment_count: u64,
    }

    struct CommentAdded has copy, drop {
        comment_id: 0x2::object::ID,
        document_id: 0x2::object::ID,
        author: address,
        comment_type: u8,
        timestamp: u64,
    }

    struct ThreadCreated has copy, drop {
        thread_id: 0x2::object::ID,
        document_id: 0x2::object::ID,
    }

    public fun add_comment(arg0: &mut CommentThread, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Comment {
        assert!(arg0.document_id == arg1, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = create_comment_internal(arg1, v0, 0, arg2, arg3, arg4, arg5);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.comments, 0x2::object::id<Comment>(&v1));
        arg0.comment_count = arg0.comment_count + 1;
        v1
    }

    public fun add_rejection_remark(arg0: &mut CommentThread, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Comment {
        assert!(arg0.document_id == arg1, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = create_comment_internal(arg1, v0, 1, arg2, arg3, arg4, arg5);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.comments, 0x2::object::id<Comment>(&v1));
        arg0.comment_count = arg0.comment_count + 1;
        v1
    }

    public fun add_review_comment(arg0: &mut CommentThread, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Comment {
        assert!(arg0.document_id == arg1, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = create_comment_internal(arg1, v0, 2, arg2, arg3, arg4, arg5);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.comments, 0x2::object::id<Comment>(&v1));
        arg0.comment_count = arg0.comment_count + 1;
        v1
    }

    public fun comment_general() : u8 {
        0
    }

    public fun comment_rejection() : u8 {
        1
    }

    public fun comment_review() : u8 {
        2
    }

    fun create_comment_internal(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : Comment {
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v2 = CommentAdded{
            comment_id   : 0x2::object::uid_to_inner(&v0),
            document_id  : arg0,
            author       : arg1,
            comment_type : arg2,
            timestamp    : v1,
        };
        0x2::event::emit<CommentAdded>(v2);
        Comment{
            id           : v0,
            document_id  : arg0,
            author       : arg1,
            comment_type : arg2,
            blob_id      : arg3,
            seal_id      : arg4,
            content_hash : arg5,
            timestamp    : v1,
        }
    }

    public fun create_thread(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : CommentThread {
        let v0 = 0x2::object::new(arg1);
        let v1 = ThreadCreated{
            thread_id   : 0x2::object::uid_to_inner(&v0),
            document_id : arg0,
        };
        0x2::event::emit<ThreadCreated>(v1);
        CommentThread{
            id            : v0,
            document_id   : arg0,
            comments      : 0x1::vector::empty<0x2::object::ID>(),
            comment_count : 0,
        }
    }

    public fun get_comment_author(arg0: &Comment) : address {
        arg0.author
    }

    public fun get_comment_blob_id(arg0: &Comment) : 0x1::string::String {
        arg0.blob_id
    }

    public fun get_comment_content_hash(arg0: &Comment) : vector<u8> {
        arg0.content_hash
    }

    public fun get_comment_id(arg0: &Comment) : 0x2::object::ID {
        0x2::object::id<Comment>(arg0)
    }

    public fun get_comment_seal_id(arg0: &Comment) : 0x1::string::String {
        arg0.seal_id
    }

    public fun get_comment_timestamp(arg0: &Comment) : u64 {
        arg0.timestamp
    }

    public fun get_comment_type(arg0: &Comment) : u8 {
        arg0.comment_type
    }

    public fun get_thread_comment_count(arg0: &CommentThread) : u64 {
        arg0.comment_count
    }

    public fun get_thread_comments(arg0: &CommentThread) : vector<0x2::object::ID> {
        arg0.comments
    }

    public fun get_thread_document_id(arg0: &CommentThread) : 0x2::object::ID {
        arg0.document_id
    }

    // decompiled from Move bytecode v6
}

