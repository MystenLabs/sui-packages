module 0x7d0885fae34034f2956e27359b7cea91eb53846c24f7fcfd1e53f0f02058245::rating {
    struct RatingCreatedEvent has copy, drop {
        rating_id: 0x2::object::ID,
    }

    struct Rating has store, key {
        id: 0x2::object::UID,
        rate: u64,
        community_id: 0x2::object::ID,
        create_date: u64,
        owner: address,
    }

    public entry fun user_rating(arg0: &mut 0x7d0885fae34034f2956e27359b7cea91eb53846c24f7fcfd1e53f0f02058245::community::Community, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rating{
            id           : 0x2::object::new(arg3),
            rate         : arg1,
            community_id : 0x7d0885fae34034f2956e27359b7cea91eb53846c24f7fcfd1e53f0f02058245::community::get_id(arg0),
            create_date  : 0x2::clock::timestamp_ms(arg2),
            owner        : 0x2::tx_context::sender(arg3),
        };
        let v1 = RatingCreatedEvent{rating_id: 0x2::object::id<Rating>(&v0)};
        0x2::event::emit<RatingCreatedEvent>(v1);
        0x7d0885fae34034f2956e27359b7cea91eb53846c24f7fcfd1e53f0f02058245::community::update_rating(arg0, arg1, arg3);
        0x2::transfer::share_object<Rating>(v0);
    }

    // decompiled from Move bytecode v6
}

