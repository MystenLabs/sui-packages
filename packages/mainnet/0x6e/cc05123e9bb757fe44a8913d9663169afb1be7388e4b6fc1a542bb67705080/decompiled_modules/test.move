module 0x6ecc05123e9bb757fe44a8913d9663169afb1be7388e4b6fc1a542bb67705080::test {
    struct Msg has copy, drop {
        msg: u8,
    }

    public fun seq_emit(arg0: u8, arg1: &0x6ecc05123e9bb757fe44a8913d9663169afb1be7388e4b6fc1a542bb67705080::sequencer::Indexer) {
        if (0x6ecc05123e9bb757fe44a8913d9663169afb1be7388e4b6fc1a542bb67705080::sequencer::check(arg1, arg0)) {
            let v0 = Msg{msg: arg0};
            0x2::event::emit<Msg>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

