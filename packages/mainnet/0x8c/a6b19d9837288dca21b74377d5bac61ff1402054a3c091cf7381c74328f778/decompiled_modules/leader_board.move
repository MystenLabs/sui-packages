module 0x8ca6b19d9837288dca21b74377d5bac61ff1402054a3c091cf7381c74328f778::leader_board {
    struct LeaderBoard has store, key {
        id: 0x2::object::UID,
        histories: 0x2::linked_table::LinkedTable<address, 0x1::ascii::String>,
    }

    struct LeaderBoardCap has store, key {
        id: 0x2::object::UID,
    }

    public fun remove(arg0: &LeaderBoardCap, arg1: &mut LeaderBoard, arg2: address) {
        0x2::linked_table::remove<address, 0x1::ascii::String>(&mut arg1.histories, arg2);
    }

    public fun add(arg0: &LeaderBoardCap, arg1: &mut LeaderBoard, arg2: 0x1::ascii::String, arg3: address) {
        0x2::linked_table::push_back<address, 0x1::ascii::String>(&mut arg1.histories, arg3, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LeaderBoardCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LeaderBoardCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = LeaderBoard{
            id        : 0x2::object::new(arg0),
            histories : 0x2::linked_table::new<address, 0x1::ascii::String>(arg0),
        };
        0x2::transfer::share_object<LeaderBoard>(v1);
    }

    public fun write(arg0: &mut LeaderBoard, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        *0x2::linked_table::borrow_mut<address, 0x1::ascii::String>(&mut arg0.histories, 0x2::tx_context::sender(arg2)) = arg1;
    }

    // decompiled from Move bytecode v6
}

