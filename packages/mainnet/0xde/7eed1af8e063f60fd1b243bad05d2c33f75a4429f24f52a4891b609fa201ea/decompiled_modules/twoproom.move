module 0xde7eed1af8e063f60fd1b243bad05d2c33f75a4429f24f52a4891b609fa201ea::twoproom {
    struct Room has store, key {
        id: 0x2::object::UID,
        player1: address,
        player2: 0x1::option::Option<address>,
    }

    public entry fun create_room(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Room{
            id      : 0x2::object::new(arg0),
            player1 : 0x2::tx_context::sender(arg0),
            player2 : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Room>(v0);
    }

    public fun is_full(arg0: &Room) : bool {
        0x1::option::is_some<address>(&arg0.player2)
    }

    public entry fun join_room(arg0: &mut Room, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.player2), 0);
        arg0.player2 = 0x1::option::some<address>(0x2::tx_context::sender(arg1));
    }

    public fun player1(arg0: &Room) : address {
        arg0.player1
    }

    public fun player2(arg0: &Room) : 0x1::option::Option<address> {
        arg0.player2
    }

    // decompiled from Move bytecode v6
}

