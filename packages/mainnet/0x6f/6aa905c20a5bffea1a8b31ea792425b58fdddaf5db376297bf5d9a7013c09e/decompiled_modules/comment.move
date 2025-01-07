module 0x6f6aa905c20a5bffea1a8b31ea792425b58fdddaf5db376297bf5d9a7013c09e::comment {
    struct Comment has store, key {
        id: 0x2::object::UID,
        reply: 0x1::option::Option<0x2::object::ID>,
        creator: address,
        media_link: 0x2::url::Url,
        content: 0x1::string::String,
        timestamp: u64,
        likes: 0x2::vec_set::VecSet<address>,
    }

    public fun drop_comment(arg0: Comment) {
        let Comment {
            id         : v0,
            reply      : _,
            creator    : _,
            media_link : _,
            content    : _,
            timestamp  : _,
            likes      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun like_comment(arg0: &mut Comment, arg1: &0x2::tx_context::TxContext) {
        0x2::vec_set::insert<address>(&mut arg0.likes, 0x2::tx_context::sender(arg1));
    }

    public fun like_count(arg0: &Comment) : u64 {
        0x2::vec_set::size<address>(&arg0.likes)
    }

    public fun new_comment(arg0: 0x1::option::Option<0x2::object::ID>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Comment {
        Comment{
            id         : 0x2::object::new(arg4),
            reply      : arg0,
            creator    : 0x2::tx_context::sender(arg4),
            media_link : 0x2::url::new_unsafe_from_bytes(arg1),
            content    : 0x1::string::utf8(arg2),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
            likes      : 0x2::vec_set::empty<address>(),
        }
    }

    public fun unlike_comment(arg0: &mut Comment, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_set::remove<address>(&mut arg0.likes, &v0);
    }

    // decompiled from Move bytecode v6
}

