module 0x3a197a10b0c940f2cb0a82756c477739c2fa673bb9e41f9531a5ba320728e783::voting {
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
        owner: address,
    }

    public entry fun create_vote(arg0: &mut 0x3a197a10b0c940f2cb0a82756c477739c2fa673bb9e41f9531a5ba320728e783::launchpadINO::LaunchpadINO, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        0x2::object::uid_to_inner(&v0);
        let v1 = Vote{
            id               : v0,
            launchpad_ino_id : 0x3a197a10b0c940f2cb0a82756c477739c2fa673bb9e41f9531a5ba320728e783::launchpadINO::get_id(arg0),
            banner           : 0x1::string::utf8(arg1),
            description      : 0x1::string::utf8(arg2),
            votes            : 0x2::vec_map::empty<address, UserVote>(),
            up               : 0,
            down             : 0,
            start_vote       : arg3,
            end_vote         : arg4,
            create_date      : 0,
            update_date      : 0,
            owner            : 0x2::tx_context::sender(arg5),
        };
        let v2 = 0x2::object::id<Vote>(&v1);
        let v3 = VoteCreatedEvent{vote_id: v2};
        0x2::event::emit<VoteCreatedEvent>(v3);
        0x3a197a10b0c940f2cb0a82756c477739c2fa673bb9e41f9531a5ba320728e783::launchpadINO::update_vote_id(arg0, v2);
        0x2::transfer::share_object<Vote>(v1);
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

    // decompiled from Move bytecode v6
}

