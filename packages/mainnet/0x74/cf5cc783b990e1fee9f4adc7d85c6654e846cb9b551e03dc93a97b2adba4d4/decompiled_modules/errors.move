module 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors {
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

    public(friend) fun authority_already_assigned() : u64 {
        23015
    }

    public(friend) fun authority_not_assigned() : u64 {
        23016
    }

    public(friend) fun invalid_params() : u64 {
        23001
    }

    public(friend) fun last_authority_not_removable() : u64 {
        23017
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

    public(friend) fun timelock_already_enabled() : u64 {
        23019
    }

    public(friend) fun timelock_ticket_required() : u64 {
        23018
    }

    public(friend) fun unauthorized() : u64 {
        23003
    }

    public(friend) fun wrong_timelock_cap() : u64 {
        23020
    }

    public(friend) fun wrong_version() : u64 {
        23013
    }

    // decompiled from Move bytecode v7
}

