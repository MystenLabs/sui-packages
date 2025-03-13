module 0xc99ce3454f90ead6d691c7742308058ef93c23f7926a986fb98011916ae0dd45::leader_board {
    struct LeaderBoard has store, key {
        id: 0x2::object::UID,
        unique: u32,
    }

    struct LeaderBoardCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_board(arg0: &LeaderBoardCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LeaderBoard{
            id     : 0x2::object::new(arg1),
            unique : 0,
        };
        0x2::transfer::share_object<LeaderBoard>(v0);
    }

    public fun get_history(arg0: &LeaderBoard) : u32 {
        arg0.unique
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LeaderBoardCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LeaderBoardCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun write_history(arg0: &mut LeaderBoard) {
        arg0.unique = arg0.unique + 1;
    }

    // decompiled from Move bytecode v6
}

