module 0xce9643440c6dd01d6e599cc9ec0829902e981228fe03a6309861e2d9312879e5::comment {
    struct CommentChild has store, key {
        id: 0x2::object::UID,
        comment: 0x1::string::String,
        is_hidden: u8,
        create_date: u64,
        owner: address,
    }

    struct Comment has store, key {
        id: 0x2::object::UID,
        comment: 0x1::string::String,
        community_id: 0x2::object::ID,
        total_child: u64,
        votes: u64,
        child_comments: 0x2::vec_map::VecMap<u64, CommentChild>,
        is_active: u8,
        create_date: u64,
        owner: address,
        users_upvoted: vector<address>,
        totalVote: u64,
        users_downvoted: vector<address>,
    }

    public entry fun down_votes(arg0: &mut Comment, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.users_downvoted, &v0), 2);
        0x1::vector::push_back<address>(&mut arg0.users_downvoted, v0);
        arg0.totalVote = arg0.totalVote + 1;
    }

    public entry fun hidden_comment(arg0: &mut CommentChild, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.is_hidden = 1;
    }

    public entry fun reply_comment(arg0: &mut 0xce9643440c6dd01d6e599cc9ec0829902e981228fe03a6309861e2d9312879e5::community::Community, arg1: &mut Comment, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CommentChild{
            id          : 0x2::object::new(arg4),
            comment     : arg2,
            is_hidden   : 0,
            create_date : 0x2::clock::timestamp_ms(arg3),
            owner       : 0x2::tx_context::sender(arg4),
        };
        0x2::vec_map::insert<u64, CommentChild>(&mut arg1.child_comments, arg1.total_child, v0);
        arg1.total_child = arg1.total_child + 1;
        0xce9643440c6dd01d6e599cc9ec0829902e981228fe03a6309861e2d9312879e5::community::update_total_comments(arg0, arg4);
    }

    public entry fun up_votes(arg0: &mut Comment, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.users_upvoted, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.users_upvoted, v0);
        arg0.totalVote = arg0.totalVote + 1;
    }

    public entry fun user_comment(arg0: &mut 0xce9643440c6dd01d6e599cc9ec0829902e981228fe03a6309861e2d9312879e5::community::Community, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Comment{
            id              : 0x2::object::new(arg3),
            comment         : arg1,
            community_id    : 0xce9643440c6dd01d6e599cc9ec0829902e981228fe03a6309861e2d9312879e5::community::get_id(arg0),
            total_child     : 0,
            votes           : 0,
            child_comments  : 0x2::vec_map::empty<u64, CommentChild>(),
            is_active       : 0,
            create_date     : 0x2::clock::timestamp_ms(arg2),
            owner           : 0x2::tx_context::sender(arg3),
            users_upvoted   : 0x1::vector::empty<address>(),
            totalVote       : 0,
            users_downvoted : 0x1::vector::empty<address>(),
        };
        0xce9643440c6dd01d6e599cc9ec0829902e981228fe03a6309861e2d9312879e5::community::update_total_comments(arg0, arg3);
        0xce9643440c6dd01d6e599cc9ec0829902e981228fe03a6309861e2d9312879e5::community::update_list_comments(arg0, 0x2::object::id<Comment>(&v0), arg3);
        0x2::transfer::share_object<Comment>(v0);
    }

    // decompiled from Move bytecode v6
}

