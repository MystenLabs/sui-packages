module 0x9185a11eeed71b0d8084a0f70289b2547e07185b986059394b6d036307331882::board {
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

