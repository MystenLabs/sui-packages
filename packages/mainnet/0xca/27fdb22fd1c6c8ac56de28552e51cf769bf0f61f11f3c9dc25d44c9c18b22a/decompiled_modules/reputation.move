module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::reputation {
    struct Review has store, key {
        id: 0x2::object::UID,
        agent: address,
        reviewer: address,
        task_id: address,
        rating: u64,
        comment_hash: vector<u8>,
        created_at: u64,
    }

    struct ReviewCreated has copy, drop {
        review_id: address,
        agent: address,
        reviewer: address,
        rating: u64,
    }

    public fun agent(arg0: &Review) : address {
        arg0.agent
    }

    entry fun create_review(arg0: address, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 400);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg0, 402);
        let v1 = Review{
            id           : 0x2::object::new(arg5),
            agent        : arg0,
            reviewer     : v0,
            task_id      : arg1,
            rating       : arg2,
            comment_hash : arg3,
            created_at   : 0x2::clock::timestamp_ms(arg4),
        };
        let v2 = ReviewCreated{
            review_id : 0x2::object::uid_to_address(&v1.id),
            agent     : arg0,
            reviewer  : v0,
            rating    : arg2,
        };
        0x2::event::emit<ReviewCreated>(v2);
        0x2::transfer::freeze_object<Review>(v1);
    }

    public fun rating(arg0: &Review) : u64 {
        arg0.rating
    }

    public fun reviewer(arg0: &Review) : address {
        arg0.reviewer
    }

    // decompiled from Move bytecode v6
}

