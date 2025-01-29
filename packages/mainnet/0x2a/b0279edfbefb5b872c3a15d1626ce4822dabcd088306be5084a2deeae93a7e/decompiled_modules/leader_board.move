module 0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::leader_board {
    struct LeaderBoards<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        addresses: 0x2::linked_table::LinkedTable<address, 0x2::object::ID>,
    }

    struct LeaderBoard has store, key {
        id: 0x2::object::UID,
        history: 0x1::ascii::String,
    }

    struct LeaderBoardCap has store, key {
        id: 0x2::object::UID,
    }

    struct LEADER_BOARD has drop {
        dummy_field: bool,
    }

    public fun add_address(arg0: &LeaderBoardCap, arg1: &mut LeaderBoards<LEADER_BOARD>, arg2: address, arg3: 0x2::object::ID) {
        assert!(!0x2::linked_table::contains<address, 0x2::object::ID>(&arg1.addresses, arg2), 9223372376157192193);
        0x2::linked_table::push_back<address, 0x2::object::ID>(&mut arg1.addresses, arg2, arg3);
    }

    public fun create_board(arg0: &LeaderBoardCap, arg1: &mut LeaderBoards<LEADER_BOARD>, arg2: address, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::linked_table::contains<address, 0x2::object::ID>(&arg1.addresses, arg2), 9223372277372944385);
        let v0 = LeaderBoard{
            id      : 0x2::object::new(arg4),
            history : arg3,
        };
        add_address(arg0, arg1, arg2, 0x2::object::id<LeaderBoard>(&v0));
        0x2::transfer::public_transfer<LeaderBoard>(v0, arg2);
    }

    public fun create_boards<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : LeaderBoards<T0> {
        LeaderBoards<T0>{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::linked_table::new<address, 0x2::object::ID>(arg1),
        }
    }

    fun init(arg0: LEADER_BOARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LeaderBoardCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LeaderBoardCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = create_boards<LEADER_BOARD>(arg0, arg1);
        0x2::transfer::public_transfer<LeaderBoards<LEADER_BOARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun modify_address(arg0: &LeaderBoardCap, arg1: &mut LeaderBoards<LEADER_BOARD>, arg2: address, arg3: 0x2::object::ID) {
        *0x2::linked_table::borrow_mut<address, 0x2::object::ID>(&mut arg1.addresses, arg2) = arg3;
    }

    public fun remove_address(arg0: &LeaderBoardCap, arg1: &mut LeaderBoards<LEADER_BOARD>, arg2: address) {
        0x2::linked_table::remove<address, 0x2::object::ID>(&mut arg1.addresses, arg2);
    }

    public fun write_history(arg0: &mut LeaderBoard, arg1: 0x1::ascii::String) {
        arg0.history = arg1;
    }

    // decompiled from Move bytecode v6
}

