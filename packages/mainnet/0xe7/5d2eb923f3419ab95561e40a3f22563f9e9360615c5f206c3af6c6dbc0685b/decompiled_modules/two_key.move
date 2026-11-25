module 0xe75d2eb923f3419ab95561e40a3f22563f9e9360615c5f206c3af6c6dbc0685b::two_key {
    struct Board has key {
        id: 0x2::object::UID,
        group: 0x1::string::String,
        admins: 0x2::vec_set::VecSet<address>,
        runner: address,
        solo_wait_ms: u64,
        epoch: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        board: 0x2::object::ID,
        action_hash: vector<u8>,
        proposer: address,
        approver: address,
        created_ms: u64,
        expires_ms: u64,
        state: u8,
        epoch: u64,
        consumed_ms: u64,
    }

    struct BoardCreated has copy, drop {
        board: 0x2::object::ID,
        group: 0x1::string::String,
        admins: vector<address>,
        runner: address,
        solo_wait_ms: u64,
    }

    struct Proposed has copy, drop {
        board: 0x2::object::ID,
        proposal: 0x2::object::ID,
        action_hash: vector<u8>,
        proposer: address,
        expires_ms: u64,
    }

    struct Approved has copy, drop {
        board: 0x2::object::ID,
        proposal: 0x2::object::ID,
        action_hash: vector<u8>,
        approver: address,
        solo: bool,
    }

    struct Consumed has copy, drop {
        board: 0x2::object::ID,
        proposal: 0x2::object::ID,
        action_hash: vector<u8>,
        by: address,
        at_ms: u64,
    }

    struct Cancelled has copy, drop {
        board: 0x2::object::ID,
        proposal: 0x2::object::ID,
        by: address,
    }

    struct AdminsChanged has copy, drop {
        board: 0x2::object::ID,
        who: address,
        added: bool,
        by: address,
        epoch: u64,
    }

    struct RunnerChanged has copy, drop {
        board: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun action_hash(arg0: &Proposal) : vector<u8> {
        arg0.action_hash
    }

    public fun add_admin(arg0: &mut Board, arg1: &mut Proposal, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        take(arg0, arg1, governance_hash(arg0, b"add_admin", arg2), arg3);
        assert!(arg2 != @0x0, 14);
        assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg2), 13);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg2);
        arg0.epoch = arg0.epoch + 1;
        let v1 = AdminsChanged{
            board : 0x2::object::id<Board>(arg0),
            who   : arg2,
            added : true,
            by    : 0x2::tx_context::sender(arg4),
            epoch : arg0.epoch,
        };
        0x2::event::emit<AdminsChanged>(v1);
    }

    public fun admin_count(arg0: &Board) : u64 {
        0x2::vec_set::length<address>(&arg0.admins)
    }

    public fun admins(arg0: &Board) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.admins)
    }

    public fun approve(arg0: &Board, arg1: &mut Proposal, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.board == 0x2::object::id<Board>(arg0), 8);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        assert!(arg1.epoch == arg0.epoch, 9);
        assert!(arg1.state == 0, 5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 < arg1.expires_ms, 3);
        assert!(arg2 == arg1.action_hash, 4);
        let v2 = v0 == arg1.proposer;
        if (v2) {
            assert!(0x2::vec_set::length<address>(&arg0.admins) == 1 && arg0.solo_wait_ms > 0, 2);
            assert!(v1 >= arg1.created_ms + arg0.solo_wait_ms, 11);
        };
        arg1.approver = v0;
        arg1.state = 1;
        let v3 = Approved{
            board       : arg1.board,
            proposal    : 0x2::object::id<Proposal>(arg1),
            action_hash : arg2,
            approver    : v0,
            solo        : v2,
        };
        0x2::event::emit<Approved>(v3);
    }

    public fun approver(arg0: &Proposal) : address {
        arg0.approver
    }

    public fun board(arg0: &Proposal) : 0x2::object::ID {
        arg0.board
    }

    public fun cancel(arg0: &Board, arg1: &mut Proposal, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.board == 0x2::object::id<Board>(arg0), 8);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        assert!(arg1.state == 0 || arg1.state == 1, 5);
        arg1.state = 3;
        let v1 = Cancelled{
            board    : arg1.board,
            proposal : 0x2::object::id<Proposal>(arg1),
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Cancelled>(v1);
    }

    public fun consume(arg0: &Board, arg1: &mut Proposal, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.runner, 7);
        take(arg0, arg1, arg2, arg3);
        let v0 = Consumed{
            board       : arg1.board,
            proposal    : 0x2::object::id<Proposal>(arg1),
            action_hash : arg2,
            by          : 0x2::tx_context::sender(arg4),
            at_ms       : arg1.consumed_ms,
        };
        0x2::event::emit<Consumed>(v0);
    }

    public fun consumed_ms(arg0: &Proposal) : u64 {
        arg0.consumed_ms
    }

    public fun create_board(arg0: 0x1::string::String, arg1: vector<address>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 14);
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            assert!(v2 != @0x0, 14);
            assert!(!0x2::vec_set::contains<address>(&v0, &v2), 13);
            0x2::vec_set::insert<address>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&v0, &v3), 1);
        let v4 = Board{
            id           : 0x2::object::new(arg4),
            group        : arg0,
            admins       : v0,
            runner       : arg2,
            solo_wait_ms : arg3,
            epoch        : 0,
        };
        let v5 = BoardCreated{
            board        : 0x2::object::id<Board>(&v4),
            group        : v4.group,
            admins       : *0x2::vec_set::keys<address>(&v4.admins),
            runner       : arg2,
            solo_wait_ms : arg3,
        };
        0x2::event::emit<BoardCreated>(v5);
        0x2::transfer::share_object<Board>(v4);
    }

    public fun created_ms(arg0: &Proposal) : u64 {
        arg0.created_ms
    }

    public fun epoch(arg0: &Board) : u64 {
        arg0.epoch
    }

    public fun expires_ms(arg0: &Proposal) : u64 {
        arg0.expires_ms
    }

    public fun governance_hash(arg0: &Board, arg1: vector<u8>, arg2: address) : vector<u8> {
        let v0 = b"one:two-key:v1";
        let v1 = 0x2::object::id<Board>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::hash::sha2_256(v0)
    }

    public fun group(arg0: &Board) : 0x1::string::String {
        arg0.group
    }

    public fun is_admin(arg0: &Board, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun leave(arg0: &mut Board, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        assert!(0x2::vec_set::length<address>(&arg0.admins) > 1, 12);
        0x2::vec_set::remove<address>(&mut arg0.admins, &v0);
        arg0.epoch = arg0.epoch + 1;
        let v1 = AdminsChanged{
            board : 0x2::object::id<Board>(arg0),
            who   : v0,
            added : false,
            by    : v0,
            epoch : arg0.epoch,
        };
        0x2::event::emit<AdminsChanged>(v1);
    }

    public fun proposal_epoch(arg0: &Proposal) : u64 {
        arg0.epoch
    }

    public fun propose(arg0: &Board, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > v1 && arg2 - v1 <= 604800000, 10);
        let v2 = Proposal{
            id          : 0x2::object::new(arg4),
            board       : 0x2::object::id<Board>(arg0),
            action_hash : arg1,
            proposer    : v0,
            approver    : @0x0,
            created_ms  : v1,
            expires_ms  : arg2,
            state       : 0,
            epoch       : arg0.epoch,
            consumed_ms : 0,
        };
        let v3 = Proposed{
            board       : v2.board,
            proposal    : 0x2::object::id<Proposal>(&v2),
            action_hash : v2.action_hash,
            proposer    : v0,
            expires_ms  : arg2,
        };
        0x2::event::emit<Proposed>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    public fun proposer(arg0: &Proposal) : address {
        arg0.proposer
    }

    public fun remove_admin(arg0: &mut Board, arg1: &mut Proposal, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        take(arg0, arg1, governance_hash(arg0, b"remove_admin", arg2), arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg2), 1);
        assert!(0x2::vec_set::length<address>(&arg0.admins) > 1, 12);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
        arg0.epoch = arg0.epoch + 1;
        let v1 = AdminsChanged{
            board : 0x2::object::id<Board>(arg0),
            who   : arg2,
            added : false,
            by    : 0x2::tx_context::sender(arg4),
            epoch : arg0.epoch,
        };
        0x2::event::emit<AdminsChanged>(v1);
    }

    public fun runner(arg0: &Board) : address {
        arg0.runner
    }

    public fun set_runner(arg0: &mut Board, arg1: &mut Proposal, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        take(arg0, arg1, governance_hash(arg0, b"set_runner", arg2), arg3);
        assert!(arg2 != @0x0, 14);
        let v1 = RunnerChanged{
            board : 0x2::object::id<Board>(arg0),
            from  : arg0.runner,
            to    : arg2,
        };
        0x2::event::emit<RunnerChanged>(v1);
        arg0.runner = arg2;
    }

    public fun solo_wait_ms(arg0: &Board) : u64 {
        arg0.solo_wait_ms
    }

    public fun state(arg0: &Proposal) : u8 {
        arg0.state
    }

    fun take(arg0: &Board, arg1: &mut Proposal, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(arg1.board == 0x2::object::id<Board>(arg0), 8);
        assert!(arg1.epoch == arg0.epoch, 9);
        assert!(arg1.state != 2, 6);
        assert!(arg1.state == 1, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg1.expires_ms, 3);
        assert!(arg2 == arg1.action_hash, 4);
        arg1.state = 2;
        arg1.consumed_ms = v0;
    }

    // decompiled from Move bytecode v7
}

