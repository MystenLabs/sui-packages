module 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::voting {
    struct VotingBoard has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        owner: address,
        quadratic: bool,
        total_weight: u64,
        votes: vector<Vote>,
    }

    struct Vote has copy, drop, store {
        submission_id: 0x2::object::ID,
        voter: address,
        votes: u64,
        weight: u64,
    }

    struct VotingBoardCreated has copy, drop {
        board_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        owner: address,
        quadratic: bool,
    }

    struct VoteCast has copy, drop {
        board_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        voter: address,
        votes: u64,
        weight: u64,
    }

    public fun create_board(arg0: 0x2::object::ID, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VotingBoard{
            id           : 0x2::object::new(arg2),
            form_id      : arg0,
            owner        : 0x2::tx_context::sender(arg2),
            quadratic    : arg1,
            total_weight : 0,
            votes        : 0x1::vector::empty<Vote>(),
        };
        let v1 = VotingBoardCreated{
            board_id  : 0x2::object::id<VotingBoard>(&v0),
            form_id   : arg0,
            owner     : v0.owner,
            quadratic : arg1,
        };
        0x2::event::emit<VotingBoardCreated>(v1);
        0x2::transfer::share_object<VotingBoard>(v0);
    }

    public fun form_id(arg0: &VotingBoard) : 0x2::object::ID {
        arg0.form_id
    }

    public fun quadratic(arg0: &VotingBoard) : bool {
        arg0.quadratic
    }

    public fun total_weight(arg0: &VotingBoard) : u64 {
        arg0.total_weight
    }

    public fun vote(arg0: &mut VotingBoard, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = if (arg0.quadratic) {
            arg2 * arg2
        } else {
            arg2
        };
        arg0.total_weight = arg0.total_weight + v0;
        let v1 = Vote{
            submission_id : arg1,
            voter         : 0x2::tx_context::sender(arg3),
            votes         : arg2,
            weight        : v0,
        };
        0x1::vector::push_back<Vote>(&mut arg0.votes, v1);
        let v2 = VoteCast{
            board_id      : 0x2::object::id<VotingBoard>(arg0),
            form_id       : arg0.form_id,
            submission_id : arg1,
            voter         : 0x2::tx_context::sender(arg3),
            votes         : arg2,
            weight        : v0,
        };
        0x2::event::emit<VoteCast>(v2);
    }

    // decompiled from Move bytecode v6
}

