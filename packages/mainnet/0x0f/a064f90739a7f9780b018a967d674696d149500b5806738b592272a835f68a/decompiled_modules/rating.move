module 0xfa064f90739a7f9780b018a967d674696d149500b5806738b592272a835f68a::rating {
    struct RatingCreatedEvent has copy, drop {
        rating_id: 0x2::object::ID,
    }

    struct CommentChild has store, key {
        id: 0x2::object::UID,
        comment: 0x1::string::String,
        is_hidden: u8,
        create_date: u64,
        owner: address,
    }

    struct RateAndComment has store, key {
        id: 0x2::object::UID,
        rate: u64,
        comment: 0x1::string::String,
        community_id: address,
        total_child: u64,
        votes: u64,
        child_comments: 0x2::vec_map::VecMap<u64, CommentChild>,
        is_active: u8,
        create_date: u64,
        owner: address,
    }

    public entry fun hidden_comment(arg0: &mut CommentChild, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.is_hidden = 1;
    }

    public entry fun rating_and_comment(arg0: &mut 0xfa064f90739a7f9780b018a967d674696d149500b5806738b592272a835f68a::community::Community, arg1: u64, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RateAndComment{
            id             : 0x2::object::new(arg4),
            rate           : arg1,
            comment        : arg2,
            community_id   : arg3,
            total_child    : 0,
            votes          : 0,
            child_comments : 0x2::vec_map::empty<u64, CommentChild>(),
            is_active      : 0,
            create_date    : 0x2::tx_context::epoch_timestamp_ms(arg4),
            owner          : 0x2::tx_context::sender(arg4),
        };
        let v1 = RatingCreatedEvent{rating_id: 0x2::object::id<RateAndComment>(&v0)};
        0x2::event::emit<RatingCreatedEvent>(v1);
        0xfa064f90739a7f9780b018a967d674696d149500b5806738b592272a835f68a::community::update_total_comments(arg0, arg4);
        0xfa064f90739a7f9780b018a967d674696d149500b5806738b592272a835f68a::community::update_total_reviewers(arg0, arg1, arg4);
        0x2::transfer::share_object<RateAndComment>(v0);
    }

    public entry fun reply_comment(arg0: &mut 0xfa064f90739a7f9780b018a967d674696d149500b5806738b592272a835f68a::community::Community, arg1: &mut RateAndComment, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CommentChild{
            id          : 0x2::object::new(arg4),
            comment     : arg2,
            is_hidden   : 0,
            create_date : arg3,
            owner       : 0x2::tx_context::sender(arg4),
        };
        0x2::vec_map::insert<u64, CommentChild>(&mut arg1.child_comments, arg1.total_child, v0);
        arg1.total_child = arg1.total_child + 1;
        0xfa064f90739a7f9780b018a967d674696d149500b5806738b592272a835f68a::community::update_total_comments(arg0, arg4);
    }

    public entry fun vote_commnent(arg0: &mut RateAndComment, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.votes = arg0.votes + 1;
    }

    // decompiled from Move bytecode v6
}

