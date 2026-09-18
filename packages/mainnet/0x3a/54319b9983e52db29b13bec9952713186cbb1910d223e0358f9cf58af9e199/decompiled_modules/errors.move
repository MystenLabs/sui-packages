module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors {
    public(friend) fun already_migrated() : u64 {
        23014
    }

    public(friend) fun already_stopped() : u64 {
        23005
    }

    public(friend) fun auth_already_assigned() : u64 {
        23011
    }

    public(friend) fun auth_not_assigned() : u64 {
        23012
    }

    public(friend) fun invalid_params() : u64 {
        23001
    }

    public(friend) fun max_rate() : u64 {
        23002
    }

    public(friend) fun must_transition_to_next() : u64 {
        23009
    }

    public(friend) fun next_rewards_queued() : u64 {
        23006
    }

    public(friend) fun no_queued_rewards() : u64 {
        23008
    }

    public(friend) fun no_rewards_started() : u64 {
        23010
    }

    public(friend) fun not_ended() : u64 {
        23007
    }

    public(friend) fun only_authority() : u64 {
        23004
    }

    public(friend) fun unauthorized() : u64 {
        23003
    }

    public(friend) fun wrong_version() : u64 {
        23013
    }

    // decompiled from Move bytecode v7
}

