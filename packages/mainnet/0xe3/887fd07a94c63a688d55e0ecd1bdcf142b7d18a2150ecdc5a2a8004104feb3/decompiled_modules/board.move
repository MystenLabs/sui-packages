module 0xe3887fd07a94c63a688d55e0ecd1bdcf142b7d18a2150ecdc5a2a8004104feb3::board {
    struct Board has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
        members: 0x2::vec_set::VecSet<address>,
    }

    struct BoardCap has store, key {
        id: 0x2::object::UID,
        board: 0x2::object::ID,
    }

    struct BoardCreated has copy, drop {
        board: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct MemberAdded has copy, drop {
        board: 0x2::object::ID,
        member: address,
    }

    struct MemberRemoved has copy, drop {
        board: 0x2::object::ID,
        member: address,
    }

    public fun add_member(arg0: &mut Board, arg1: &BoardCap, arg2: address) {
        assert!(arg1.board == 0x2::object::id<Board>(arg0), 0);
        assert!(!0x2::vec_set::contains<address>(&arg0.members, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.members, arg2);
        let v0 = MemberAdded{
            board  : 0x2::object::id<Board>(arg0),
            member : arg2,
        };
        0x2::event::emit<MemberAdded>(v0);
    }

    public fun can_write(arg0: &Board, arg1: address) : bool {
        arg1 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : BoardCap {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Board{
            id          : 0x2::object::new(arg2),
            name        : arg0,
            description : arg1,
            owner       : v0,
            members     : 0x2::vec_set::empty<address>(),
        };
        let v2 = 0x2::object::id<Board>(&v1);
        let v3 = BoardCap{
            id    : 0x2::object::new(arg2),
            board : v2,
        };
        let v4 = BoardCreated{
            board : v2,
            owner : v0,
            name  : v1.name,
        };
        0x2::event::emit<BoardCreated>(v4);
        0x2::transfer::share_object<Board>(v1);
        v3
    }

    entry fun create_and_keep(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1, arg2);
        0x2::transfer::public_transfer<BoardCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun description(arg0: &Board) : 0x1::string::String {
        arg0.description
    }

    public fun members(arg0: &Board) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.members)
    }

    public fun name(arg0: &Board) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &Board) : address {
        arg0.owner
    }

    public fun remove_member(arg0: &mut Board, arg1: &BoardCap, arg2: address) {
        assert!(arg1.board == 0x2::object::id<Board>(arg0), 0);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.members, &arg2);
        let v0 = MemberRemoved{
            board  : 0x2::object::id<Board>(arg0),
            member : arg2,
        };
        0x2::event::emit<MemberRemoved>(v0);
    }

    public fun rename(arg0: &mut Board, arg1: &BoardCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(arg1.board == 0x2::object::id<Board>(arg0), 0);
        arg0.name = arg2;
        arg0.description = arg3;
    }

    // decompiled from Move bytecode v7
}

