module 0x8888a5502884994774f1794a9370e4ab298feb7826297e490bba371251d5f990::voting {
    struct VoteCreatedEvent has copy, drop {
        vote_id: 0x2::object::ID,
    }

    struct UserVote has store, key {
        id: 0x2::object::UID,
        status: u8,
        comment: 0x1::string::String,
        account: address,
        create_date: u64,
    }

    struct Vote has store, key {
        id: 0x2::object::UID,
        launchpad_ino_id: 0x2::object::ID,
        votes: 0x2::vec_map::VecMap<address, UserVote>,
        up: u64,
        down: u64,
        start_vote: u64,
        end_vote: u64,
        create_date: u64,
        update_date: u64,
        status: u8,
        owner: address,
    }

    public entry fun create_vote(arg0: &mut 0x8888a5502884994774f1794a9370e4ab298feb7826297e490bba371251d5f990::launchpadINO::LaunchpadINO, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0x8888a5502884994774f1794a9370e4ab298feb7826297e490bba371251d5f990::launchpadINO::get_admin(), 0);
        let v1 = 0x2::object::new(arg4);
        0x2::object::uid_to_inner(&v1);
        let v2 = Vote{
            id               : v1,
            launchpad_ino_id : 0x8888a5502884994774f1794a9370e4ab298feb7826297e490bba371251d5f990::launchpadINO::get_id(arg0),
            votes            : 0x2::vec_map::empty<address, UserVote>(),
            up               : 0,
            down             : 0,
            start_vote       : arg1,
            end_vote         : arg2,
            create_date      : 0x2::clock::timestamp_ms(arg3),
            update_date      : 0,
            status           : 0,
            owner            : v0,
        };
        let v3 = 0x2::object::id<Vote>(&v2);
        let v4 = VoteCreatedEvent{vote_id: v3};
        0x2::event::emit<VoteCreatedEvent>(v4);
        0x8888a5502884994774f1794a9370e4ab298feb7826297e490bba371251d5f990::launchpadINO::update_vote_id(arg0, v3);
        0x2::transfer::share_object<Vote>(v2);
    }

    public entry fun down_votes(arg0: &mut Vote, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = UserVote{
            id          : 0x2::object::new(arg3),
            status      : 0,
            comment     : 0x1::string::utf8(arg2),
            account     : v0,
            create_date : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::vec_map::insert<address, UserVote>(&mut arg0.votes, v0, v1);
        arg0.down = arg0.down + 1;
    }

    public entry fun get_votes_by_user(arg0: &mut Vote, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_map::contains<address, UserVote>(&arg0.votes, &v0)
    }

    public entry fun up_votes(arg0: &mut Vote, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = UserVote{
            id          : 0x2::object::new(arg3),
            status      : 1,
            comment     : 0x1::string::utf8(arg2),
            account     : v0,
            create_date : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::vec_map::insert<address, UserVote>(&mut arg0.votes, v0, v1);
        arg0.up = arg0.up + 1;
    }

    public entry fun update_vote(arg0: &mut Vote, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0x8888a5502884994774f1794a9370e4ab298feb7826297e490bba371251d5f990::launchpadINO::get_admin(), 0);
        arg0.status = arg3;
        arg0.start_vote = arg1;
        arg0.end_vote = arg2;
        arg0.update_date = 0x2::clock::timestamp_ms(arg4);
    }

    // decompiled from Move bytecode v6
}

