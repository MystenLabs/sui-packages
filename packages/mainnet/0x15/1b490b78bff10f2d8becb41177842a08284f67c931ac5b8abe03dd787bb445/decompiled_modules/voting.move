module 0x151b490b78bff10f2d8becb41177842a08284f67c931ac5b8abe03dd787bb445::voting {
    struct VotingRegistry has key {
        id: 0x2::object::UID,
        reviews: 0x2::table::Table<0x2::object::ID, ReviewRequest>,
        total_reviews: u64,
    }

    struct ReviewRequest has store {
        id: 0x2::object::ID,
        object_id: 0x1::string::String,
        object_type: 0x1::string::String,
        object_name: 0x1::string::String,
        submitter: address,
        submission_time: u64,
        votes_up: u64,
        votes_down: u64,
        voters: 0x2::table::Table<address, bool>,
        metadata: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct VoteReceipt has store, key {
        id: 0x2::object::UID,
        voter: address,
        review_id: 0x2::object::ID,
        is_upvote: bool,
        timestamp: u64,
    }

    struct ReviewSubmitted has copy, drop {
        review_id: 0x2::object::ID,
        object_id: 0x1::string::String,
        submitter: address,
        timestamp: u64,
    }

    struct VoteCast has copy, drop {
        review_id: 0x2::object::ID,
        voter: address,
        is_upvote: bool,
        new_up_votes: u64,
        new_down_votes: u64,
    }

    public entry fun cast_vote(arg0: &mut VotingRegistry, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<0x2::object::ID, ReviewRequest>(&arg0.reviews, arg1), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, ReviewRequest>(&mut arg0.reviews, arg1);
        assert!(v1.submitter != v0, 3);
        assert!(!0x2::table::contains<address, bool>(&v1.voters, v0), 0);
        0x2::table::add<address, bool>(&mut v1.voters, v0, arg2);
        if (arg2) {
            v1.votes_up = v1.votes_up + 1;
        } else {
            v1.votes_down = v1.votes_down + 1;
        };
        let v2 = VoteReceipt{
            id        : 0x2::object::new(arg4),
            voter     : v0,
            review_id : arg1,
            is_upvote : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::transfer<VoteReceipt>(v2, v0);
        let v3 = VoteCast{
            review_id      : arg1,
            voter          : v0,
            is_upvote      : arg2,
            new_up_votes   : v1.votes_up,
            new_down_votes : v1.votes_down,
        };
        0x2::event::emit<VoteCast>(v3);
    }

    public entry fun change_vote(arg0: &mut VotingRegistry, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<0x2::object::ID, ReviewRequest>(&arg0.reviews, arg1), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, ReviewRequest>(&mut arg0.reviews, arg1);
        assert!(0x2::table::contains<address, bool>(&v1.voters, v0), 2);
        let v2 = *0x2::table::borrow<address, bool>(&v1.voters, v0);
        if (v2 != arg2) {
            if (v2) {
                v1.votes_up = v1.votes_up - 1;
                v1.votes_down = v1.votes_down + 1;
            } else {
                v1.votes_down = v1.votes_down - 1;
                v1.votes_up = v1.votes_up + 1;
            };
            0x2::table::remove<address, bool>(&mut v1.voters, v0);
            0x2::table::add<address, bool>(&mut v1.voters, v0, arg2);
            let v3 = VoteCast{
                review_id      : arg1,
                voter          : v0,
                is_upvote      : arg2,
                new_up_votes   : v1.votes_up,
                new_down_votes : v1.votes_down,
            };
            0x2::event::emit<VoteCast>(v3);
        };
    }

    public fun get_review(arg0: &VotingRegistry, arg1: 0x2::object::ID) : &ReviewRequest {
        0x2::table::borrow<0x2::object::ID, ReviewRequest>(&arg0.reviews, arg1)
    }

    public fun get_total_reviews(arg0: &VotingRegistry) : u64 {
        arg0.total_reviews
    }

    public fun get_user_vote(arg0: &ReviewRequest, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.voters, arg1) && *0x2::table::borrow<address, bool>(&arg0.voters, arg1)
    }

    public fun get_vote_counts(arg0: &ReviewRequest) : (u64, u64) {
        (arg0.votes_up, arg0.votes_down)
    }

    public fun has_voted(arg0: &ReviewRequest, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.voters, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VotingRegistry{
            id            : 0x2::object::new(arg0),
            reviews       : 0x2::table::new<0x2::object::ID, ReviewRequest>(arg0),
            total_reviews : 0,
        };
        0x2::transfer::share_object<VotingRegistry>(v0);
    }

    public entry fun submit_for_review(arg0: &mut VotingRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ReviewRequest{
            id              : v1,
            object_id       : arg1,
            object_type     : arg2,
            object_name     : arg3,
            submitter       : 0x2::tx_context::sender(arg7),
            submission_time : 0x2::clock::timestamp_ms(arg6),
            votes_up        : 0,
            votes_down      : 0,
            voters          : 0x2::table::new<address, bool>(arg7),
            metadata        : arg4,
            image_url       : arg5,
        };
        0x2::table::add<0x2::object::ID, ReviewRequest>(&mut arg0.reviews, v1, v2);
        arg0.total_reviews = arg0.total_reviews + 1;
        let v3 = ReviewSubmitted{
            review_id : v1,
            object_id : arg1,
            submitter : 0x2::tx_context::sender(arg7),
            timestamp : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ReviewSubmitted>(v3);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

