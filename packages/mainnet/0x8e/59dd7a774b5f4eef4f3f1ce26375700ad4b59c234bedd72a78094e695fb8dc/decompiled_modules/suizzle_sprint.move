module 0x8e59dd7a774b5f4eef4f3f1ce26375700ad4b59c234bedd72a78094e695fb8dc::suizzle_sprint {
    struct SprintGame has store, key {
        id: 0x2::object::UID,
        player: address,
        start_time: u64,
        end_time: u64,
        duration: u64,
    }

    public entry fun create_game(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SprintGame{
            id         : 0x2::object::new(arg1),
            player     : v0,
            start_time : 0x2::clock::timestamp_ms(arg0),
            end_time   : 0,
            duration   : 0,
        };
        0x2::transfer::transfer<SprintGame>(v1, v0);
    }

    public entry fun delete_game(arg0: SprintGame) {
        let SprintGame {
            id         : v0,
            player     : _,
            start_time : _,
            end_time   : _,
            duration   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun end_game(arg0: &0x2::clock::Clock, arg1: &mut SprintGame, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.end_time = 0x2::clock::timestamp_ms(arg0);
        arg1.duration = arg1.end_time - arg1.start_time;
    }

    // decompiled from Move bytecode v6
}

