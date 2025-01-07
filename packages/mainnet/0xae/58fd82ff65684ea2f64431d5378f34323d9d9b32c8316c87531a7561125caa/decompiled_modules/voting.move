module 0xae58fd82ff65684ea2f64431d5378f34323d9d9b32c8316c87531a7561125caa::voting {
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
        banner: 0x1::string::String,
        description: 0x1::string::String,
        votes: 0x2::vec_map::VecMap<address, UserVote>,
        up: u64,
        down: u64,
        start_vote: u64,
        end_vote: u64,
        create_date: u64,
        update_date: u64,
        status: u8,
        type: u8,
        owner: address,
    }

    public entry fun create_vote(arg0: &mut 0xae58fd82ff65684ea2f64431d5378f34323d9d9b32c8316c87531a7561125caa::launchpadINO::LaunchpadINO, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == 0xae58fd82ff65684ea2f64431d5378f34323d9d9b32c8316c87531a7561125caa::launchpadINO::get_admin(), 0);
        let v1 = 0x2::object::new(arg6);
        0x2::object::uid_to_inner(&v1);
        let v2 = Vote{
            id               : v1,
            launchpad_ino_id : 0xae58fd82ff65684ea2f64431d5378f34323d9d9b32c8316c87531a7561125caa::launchpadINO::get_id(arg0),
            banner           : 0x1::string::utf8(arg1),
            description      : 0x1::string::utf8(arg2),
            votes            : 0x2::vec_map::empty<address, UserVote>(),
            up               : 0,
            down             : 0,
            start_vote       : arg3,
            end_vote         : arg4,
            create_date      : 0,
            update_date      : 0,
            status           : 0,
            type             : arg5,
            owner            : v0,
        };
        let v3 = 0x2::object::id<Vote>(&v2);
        let v4 = VoteCreatedEvent{vote_id: v3};
        0x2::event::emit<VoteCreatedEvent>(v4);
        0xae58fd82ff65684ea2f64431d5378f34323d9d9b32c8316c87531a7561125caa::launchpadINO::update_vote_id(arg0, v3);
        0x2::transfer::share_object<Vote>(v2);
    }

    public entry fun down_votes(arg0: &mut Vote, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = UserVote{
            id          : 0x2::object::new(arg3),
            status      : 0,
            comment     : 0x1::string::utf8(arg2),
            account     : v0,
            create_date : arg1,
        };
        0x2::vec_map::insert<address, UserVote>(&mut arg0.votes, v0, v1);
        arg0.down = arg0.down + 1;
    }

    public entry fun get_votes_by_user(arg0: &mut Vote, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_map::contains<address, UserVote>(&arg0.votes, &v0)
    }

    public entry fun up_votes(arg0: &mut Vote, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = UserVote{
            id          : 0x2::object::new(arg3),
            status      : 1,
            comment     : 0x1::string::utf8(arg2),
            account     : v0,
            create_date : arg1,
        };
        0x2::vec_map::insert<address, UserVote>(&mut arg0.votes, v0, v1);
        arg0.up = arg0.up + 1;
    }

    public entry fun update_vote(arg0: &mut Vote, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == 0xae58fd82ff65684ea2f64431d5378f34323d9d9b32c8316c87531a7561125caa::launchpadINO::get_admin(), 0);
        arg0.status = arg5;
        arg0.banner = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.start_vote = arg3;
        arg0.end_vote = arg4;
    }

    // decompiled from Move bytecode v6
}

