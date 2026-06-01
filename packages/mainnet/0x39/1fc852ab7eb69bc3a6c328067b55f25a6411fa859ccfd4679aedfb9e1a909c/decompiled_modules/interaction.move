module 0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::interaction {
    struct Like has key {
        id: 0x2::object::UID,
        user: address,
        post_id: 0x2::object::ID,
        created_at: u64,
    }

    struct Follow has key {
        id: 0x2::object::UID,
        follower: address,
        following: address,
        created_at: u64,
    }

    public entry fun follow_user(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Follow{
            id         : 0x2::object::new(arg2),
            follower   : v0,
            following  : arg0,
            created_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::transfer<Follow>(v1, v0);
    }

    public entry fun like_post(arg0: &mut 0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::post::Post, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::post::Post>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::post::increment_like_count(arg0);
        let v3 = Like{
            id         : 0x2::object::new(arg2),
            user       : v0,
            post_id    : v1,
            created_at : v2,
        };
        0x2::transfer::transfer<Like>(v3, v0);
        0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::events::emit_like_created(v1, v0, v2);
    }

    // decompiled from Move bytecode v7
}

