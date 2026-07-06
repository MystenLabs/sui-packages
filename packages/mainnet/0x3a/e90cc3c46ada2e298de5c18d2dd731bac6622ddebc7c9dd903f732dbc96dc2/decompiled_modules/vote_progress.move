module 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::vote_progress {
    struct VoteProgress has copy, drop, store {
        yes: u64,
        no: u64,
        abstain: u64,
        no_with_veto: u64,
        total_stake: u64,
    }

    public fun abstain(arg0: &VoteProgress) : u64 {
        arg0.abstain
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : VoteProgress {
        VoteProgress{
            yes          : arg0,
            no           : arg1,
            abstain      : arg2,
            no_with_veto : arg3,
            total_stake  : arg4,
        }
    }

    public fun no(arg0: &VoteProgress) : u64 {
        arg0.no
    }

    public fun no_with_veto(arg0: &VoteProgress) : u64 {
        arg0.no_with_veto
    }

    public fun total_stake(arg0: &VoteProgress) : u64 {
        arg0.total_stake
    }

    public fun yes(arg0: &VoteProgress) : u64 {
        arg0.yes
    }

    // decompiled from Move bytecode v7
}

