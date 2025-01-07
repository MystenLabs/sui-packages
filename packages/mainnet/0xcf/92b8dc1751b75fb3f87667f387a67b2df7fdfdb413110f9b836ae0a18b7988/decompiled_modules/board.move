module 0xcf92b8dc1751b75fb3f87667f387a67b2df7fdfdb413110f9b836ae0a18b7988::board {
    struct Round has copy, drop, store {
        stage: u64,
        last_update_date: u64,
    }

    public(friend) fun current_stage(arg0: &Round) : &u64 {
        &arg0.stage
    }

    public(friend) fun new_board() : Round {
        Round{
            stage            : 0,
            last_update_date : 0,
        }
    }

    public(friend) fun update_stage(arg0: &mut Round, arg1: u64, arg2: u64) {
        arg0.stage = arg1;
        arg0.last_update_date = arg2;
    }

    // decompiled from Move bytecode v6
}

