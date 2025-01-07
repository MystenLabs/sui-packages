module 0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::sprint_game {
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
            duration   : 1000000,
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

    public fun duration(arg0: &SprintGame) : &u64 {
        &arg0.duration
    }

    public entry fun end_game(arg0: &0x2::clock::Clock, arg1: &mut SprintGame, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.end_time = 0x2::clock::timestamp_ms(arg0);
        arg1.duration = arg1.end_time - arg1.start_time;
    }

    public fun end_time(arg0: &SprintGame) : &u64 {
        &arg0.end_time
    }

    public fun id(arg0: &SprintGame) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun player(arg0: &SprintGame) : &address {
        &arg0.player
    }

    public fun start_time(arg0: &SprintGame) : &u64 {
        &arg0.start_time
    }

    // decompiled from Move bytecode v6
}

