module 0xaf394dbfc6351792ef242deae8a11f8881f61c4d3c120dbc8d014e9c8c7d28e5::reader_board {
    struct READER_BOARD has drop {
        dummy_field: bool,
    }

    struct ReaderBoardCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReaderBoards<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        addresses: 0x2::linked_table::LinkedTable<address, 0x2::object::ID>,
    }

    struct ReaderBoard has store, key {
        id: 0x2::object::UID,
        history: 0x1::ascii::String,
    }

    public fun add_address(arg0: &ReaderBoardCap, arg1: &mut ReaderBoards<READER_BOARD>, arg2: address, arg3: 0x2::object::ID) {
        assert!(!0x2::linked_table::contains<address, 0x2::object::ID>(&arg1.addresses, arg2), 9223372371862224897);
        0x2::linked_table::push_back<address, 0x2::object::ID>(&mut arg1.addresses, arg2, arg3);
    }

    public fun create_board(arg0: &ReaderBoardCap, arg1: &mut ReaderBoards<READER_BOARD>, arg2: address, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::linked_table::contains<address, 0x2::object::ID>(&arg1.addresses, arg2), 9223372273077977089);
        let v0 = ReaderBoard{
            id      : 0x2::object::new(arg4),
            history : arg3,
        };
        add_address(arg0, arg1, arg2, 0x2::object::id<ReaderBoard>(&v0));
        0x2::transfer::public_transfer<ReaderBoard>(v0, arg2);
    }

    public fun create_boards<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : ReaderBoards<T0> {
        ReaderBoards<T0>{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::linked_table::new<address, 0x2::object::ID>(arg1),
        }
    }

    fun init(arg0: READER_BOARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReaderBoardCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ReaderBoardCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = create_boards<READER_BOARD>(arg0, arg1);
        0x2::transfer::public_transfer<ReaderBoards<READER_BOARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun modify_address(arg0: &ReaderBoardCap, arg1: &mut ReaderBoards<READER_BOARD>, arg2: address, arg3: 0x2::object::ID) {
        *0x2::linked_table::borrow_mut<address, 0x2::object::ID>(&mut arg1.addresses, arg2) = arg3;
    }

    public fun remove_address(arg0: &ReaderBoardCap, arg1: &mut ReaderBoards<READER_BOARD>, arg2: address) {
        0x2::linked_table::remove<address, 0x2::object::ID>(&mut arg1.addresses, arg2);
    }

    public fun write_history(arg0: &mut ReaderBoard, arg1: 0x1::ascii::String) {
        arg0.history = arg1;
    }

    // decompiled from Move bytecode v6
}

