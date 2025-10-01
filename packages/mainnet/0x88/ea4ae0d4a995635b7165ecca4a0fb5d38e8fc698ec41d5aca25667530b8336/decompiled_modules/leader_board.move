module 0x88ea4ae0d4a995635b7165ecca4a0fb5d38e8fc698ec41d5aca25667530b8336::leader_board {
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

    public fun drop_board(arg0: &LeaderBoardCap, arg1: LeaderBoard) {
        let LeaderBoard {
            id     : v0,
            unique : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LeaderBoardCap{id: 0x2::object::new(arg0)};
        create_board(&v0, arg0);
        0x2::transfer::transfer<LeaderBoardCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun write_board(arg0: &mut LeaderBoard) {
        arg0.unique = arg0.unique + 1;
    }

    public fun write_history(arg0: &LeaderBoardCap, arg1: &mut LeaderBoard) {
        arg1.unique = arg1.unique + 1;
    }

    // decompiled from Move bytecode v6
}

