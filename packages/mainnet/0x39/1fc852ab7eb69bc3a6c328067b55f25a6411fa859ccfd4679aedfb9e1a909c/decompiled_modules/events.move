module 0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::events {
    struct PostCreated has copy, drop {
        post_id: 0x2::object::ID,
        author: address,
        walrus_blob_id: 0x1::string::String,
        content_type: u8,
        created_at: u64,
    }

    struct LikeCreated has copy, drop {
        post_id: 0x2::object::ID,
        user: address,
        created_at: u64,
    }

    struct TipEvent has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
        post_id: 0x2::object::ID,
        created_at: u64,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        username: 0x1::string::String,
        created_at: u64,
    }

    public(friend) fun emit_like_created(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = LikeCreated{
            post_id    : arg0,
            user       : arg1,
            created_at : arg2,
        };
        0x2::event::emit<LikeCreated>(v0);
    }

    public(friend) fun emit_post_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: u64) {
        let v0 = PostCreated{
            post_id        : arg0,
            author         : arg1,
            walrus_blob_id : arg2,
            content_type   : arg3,
            created_at     : arg4,
        };
        0x2::event::emit<PostCreated>(v0);
    }

    public(friend) fun emit_profile_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        let v0 = ProfileCreated{
            profile_id : arg0,
            owner      : arg1,
            username   : arg2,
            created_at : arg3,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public(friend) fun emit_tip_event(arg0: address, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = TipEvent{
            sender     : arg0,
            receiver   : arg1,
            amount     : arg2,
            post_id    : arg3,
            created_at : arg4,
        };
        0x2::event::emit<TipEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

