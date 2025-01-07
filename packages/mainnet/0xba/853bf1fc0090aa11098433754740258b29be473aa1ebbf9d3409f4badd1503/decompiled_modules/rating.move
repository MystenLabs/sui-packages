module 0xba853bf1fc0090aa11098433754740258b29be473aa1ebbf9d3409f4badd1503::rating {
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
        users_voted: vector<address>,
    }

    public entry fun hidden_comment(arg0: &mut CommentChild, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        arg0.is_hidden = 1;
    }

    public entry fun rating_and_comment(arg0: &mut 0xba853bf1fc0090aa11098433754740258b29be473aa1ebbf9d3409f4badd1503::community::Community, arg1: u64, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
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
            users_voted    : 0x1::vector::empty<address>(),
        };
        let v1 = RatingCreatedEvent{rating_id: 0x2::object::id<RateAndComment>(&v0)};
        0x2::event::emit<RatingCreatedEvent>(v1);
        0xba853bf1fc0090aa11098433754740258b29be473aa1ebbf9d3409f4badd1503::community::update_total_comments(arg0, arg4);
        0xba853bf1fc0090aa11098433754740258b29be473aa1ebbf9d3409f4badd1503::community::update_total_reviewers(arg0, arg1, arg4);
        0x2::transfer::public_transfer<RateAndComment>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun reply_comment(arg0: &mut 0xba853bf1fc0090aa11098433754740258b29be473aa1ebbf9d3409f4badd1503::community::Community, arg1: &mut RateAndComment, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CommentChild{
            id          : 0x2::object::new(arg4),
            comment     : arg2,
            is_hidden   : 0,
            create_date : arg3,
            owner       : 0x2::tx_context::sender(arg4),
        };
        0x2::vec_map::insert<u64, CommentChild>(&mut arg1.child_comments, arg1.total_child, v0);
        arg1.total_child = arg1.total_child + 1;
        0xba853bf1fc0090aa11098433754740258b29be473aa1ebbf9d3409f4badd1503::community::update_total_comments(arg0, arg4);
    }

    public entry fun vote_commnent(arg0: &mut RateAndComment, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.users_voted, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.users_voted, v0);
        arg0.votes = arg0.votes + 1;
    }

    // decompiled from Move bytecode v6
}

