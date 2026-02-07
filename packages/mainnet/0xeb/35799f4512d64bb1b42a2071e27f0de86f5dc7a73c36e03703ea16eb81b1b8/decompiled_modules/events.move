module 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events {
    struct TempleCreated has copy, drop {
        temple_id: 0x2::object::ID,
        name: vector<u8>,
        description: vector<u8>,
        creator: address,
        timestamp: u64,
    }

    struct TempleMemberJoined has copy, drop {
        temple_id: 0x2::object::ID,
        member: address,
        timestamp: u64,
    }

    struct TempleMemberLeft has copy, drop {
        temple_id: 0x2::object::ID,
        member: address,
        timestamp: u64,
    }

    struct PostCreated has copy, drop {
        post_id: 0x2::object::ID,
        temple_id: 0x2::object::ID,
        author: address,
        genome_id: 0x2::object::ID,
        title: vector<u8>,
        post_type: u8,
        has_body: bool,
        link_url: vector<u8>,
        timestamp: u64,
    }

    struct PostDeleted has copy, drop {
        post_id: 0x2::object::ID,
        author: address,
        timestamp: u64,
    }

    struct CommentCreated has copy, drop {
        comment_id: 0x2::object::ID,
        post_id: 0x2::object::ID,
        parent_comment_id: vector<u8>,
        author: address,
        timestamp: u64,
    }

    struct Voted has copy, drop {
        target_id: 0x2::object::ID,
        voter: address,
        vote_value: u8,
        is_post: bool,
        timestamp: u64,
    }

    struct VoteRemoved has copy, drop {
        target_id: 0x2::object::ID,
        voter: address,
        old_value: u8,
        is_post: bool,
        timestamp: u64,
    }

    struct VoteChanged has copy, drop {
        target_id: 0x2::object::ID,
        voter: address,
        old_value: u8,
        new_value: u8,
        is_post: bool,
        timestamp: u64,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        genome_id: 0x2::object::ID,
        name: vector<u8>,
        timestamp: u64,
    }

    struct ProfileUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        name: vector<u8>,
        description: vector<u8>,
        avatar_blob_id: vector<u8>,
        banner_blob_id: vector<u8>,
        timestamp: u64,
    }

    struct EncryptedPostCreated has copy, drop {
        post_id: 0x2::object::ID,
        temple_id: 0x2::object::ID,
        author: address,
        title: vector<u8>,
        decrypt_price: u64,
        timestamp: u64,
    }

    struct AccessPurchased has copy, drop {
        post_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        timestamp: u64,
    }

    struct EarningsWithdrawn has copy, drop {
        post_id: 0x2::object::ID,
        author: address,
        amount: u64,
        timestamp: u64,
    }

    public fun emit_access_purchased(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = AccessPurchased{
            post_id   : arg0,
            buyer     : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<AccessPurchased>(v0);
    }

    public fun emit_comment_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: address, arg4: u64) {
        let v0 = CommentCreated{
            comment_id        : arg0,
            post_id           : arg1,
            parent_comment_id : arg2,
            author            : arg3,
            timestamp         : arg4,
        };
        0x2::event::emit<CommentCreated>(v0);
    }

    public fun emit_earnings_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = EarningsWithdrawn{
            post_id   : arg0,
            author    : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<EarningsWithdrawn>(v0);
    }

    public fun emit_encrypted_post_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64) {
        let v0 = EncryptedPostCreated{
            post_id       : arg0,
            temple_id     : arg1,
            author        : arg2,
            title         : arg3,
            decrypt_price : arg4,
            timestamp     : arg5,
        };
        0x2::event::emit<EncryptedPostCreated>(v0);
    }

    public fun emit_post_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u8, arg6: bool, arg7: vector<u8>, arg8: u64) {
        let v0 = PostCreated{
            post_id   : arg0,
            temple_id : arg1,
            author    : arg2,
            genome_id : arg3,
            title     : arg4,
            post_type : arg5,
            has_body  : arg6,
            link_url  : arg7,
            timestamp : arg8,
        };
        0x2::event::emit<PostCreated>(v0);
    }

    public fun emit_post_deleted(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PostDeleted{
            post_id   : arg0,
            author    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<PostDeleted>(v0);
    }

    public fun emit_profile_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64) {
        let v0 = ProfileCreated{
            profile_id : arg0,
            owner      : arg1,
            genome_id  : arg2,
            name       : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public fun emit_profile_updated(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64) {
        let v0 = ProfileUpdated{
            profile_id     : arg0,
            owner          : arg1,
            name           : arg2,
            description    : arg3,
            avatar_blob_id : arg4,
            banner_blob_id : arg5,
            timestamp      : arg6,
        };
        0x2::event::emit<ProfileUpdated>(v0);
    }

    public fun emit_temple_created(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64) {
        let v0 = TempleCreated{
            temple_id   : arg0,
            name        : arg1,
            description : arg2,
            creator     : arg3,
            timestamp   : arg4,
        };
        0x2::event::emit<TempleCreated>(v0);
    }

    public fun emit_temple_member_joined(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = TempleMemberJoined{
            temple_id : arg0,
            member    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<TempleMemberJoined>(v0);
    }

    public fun emit_temple_member_left(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = TempleMemberLeft{
            temple_id : arg0,
            member    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<TempleMemberLeft>(v0);
    }

    public fun emit_vote_changed(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u8, arg4: bool, arg5: u64) {
        let v0 = VoteChanged{
            target_id : arg0,
            voter     : arg1,
            old_value : arg2,
            new_value : arg3,
            is_post   : arg4,
            timestamp : arg5,
        };
        0x2::event::emit<VoteChanged>(v0);
    }

    public fun emit_vote_removed(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: bool, arg4: u64) {
        let v0 = VoteRemoved{
            target_id : arg0,
            voter     : arg1,
            old_value : arg2,
            is_post   : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<VoteRemoved>(v0);
    }

    public fun emit_voted(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: bool, arg4: u64) {
        let v0 = Voted{
            target_id  : arg0,
            voter      : arg1,
            vote_value : arg2,
            is_post    : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<Voted>(v0);
    }

    // decompiled from Move bytecode v6
}

