module 0x1f917d2da0a728b851b51dba17ef156ee68d6cf205b21ee35fce984dc654dc15::voting_option {
    struct VotingOption has copy, drop, store {
        pos0: 0x1::string::String,
    }

    public(friend) fun abstain_option() : VotingOption {
        VotingOption{pos0: 0x1::string::utf8(b"Abstain")}
    }

    public fun default_options() : 0x2::vec_set::VecSet<VotingOption> {
        let v0 = 0x2::vec_set::empty<VotingOption>();
        0x2::vec_set::insert<VotingOption>(&mut v0, abstain_option());
        0x2::vec_set::insert<VotingOption>(&mut v0, yes_option());
        0x2::vec_set::insert<VotingOption>(&mut v0, no_option());
        v0
    }

    public(friend) fun new(arg0: 0x1::string::String) : VotingOption {
        VotingOption{pos0: arg0}
    }

    public(friend) fun no_option() : VotingOption {
        VotingOption{pos0: 0x1::string::utf8(b"No")}
    }

    public(friend) fun threshold_not_reached() : VotingOption {
        VotingOption{pos0: 0x1::string::utf8(b"Threshold not reached")}
    }

    public(friend) fun tie_rejected() : VotingOption {
        VotingOption{pos0: 0x1::string::utf8(b"Vote rejected due to tie")}
    }

    public fun value(arg0: &VotingOption) : 0x1::string::String {
        arg0.pos0
    }

    public(friend) fun yes_option() : VotingOption {
        VotingOption{pos0: 0x1::string::utf8(b"Yes")}
    }

    // decompiled from Move bytecode v6
}

