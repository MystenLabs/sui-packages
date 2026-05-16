module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::soulbound {
    struct ParticipationBadge has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        minted_at_ms: u64,
    }

    public fun form_id(arg0: &ParticipationBadge) : 0x2::object::ID {
        arg0.form_id
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ParticipationBadge {
        ParticipationBadge{
            id            : 0x2::object::new(arg3),
            form_id       : arg0,
            submission_id : arg1,
            minted_at_ms  : arg2,
        }
    }

    public fun minted_at_ms(arg0: &ParticipationBadge) : u64 {
        arg0.minted_at_ms
    }

    public fun submission_id(arg0: &ParticipationBadge) : 0x2::object::ID {
        arg0.submission_id
    }

    public(friend) fun transfer_to_sender(arg0: ParticipationBadge, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<ParticipationBadge>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

