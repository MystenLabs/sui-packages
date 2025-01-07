module 0xa1dc16ada5b89cab2dada8d826bbbcaed6889b59b4cc3db3be65d7358b720980::test {
    struct Msg has copy, drop {
        msg: u8,
    }

    public fun seq_emit(arg0: u8, arg1: &0xa1dc16ada5b89cab2dada8d826bbbcaed6889b59b4cc3db3be65d7358b720980::sequencer::Indexer) {
        if (0xa1dc16ada5b89cab2dada8d826bbbcaed6889b59b4cc3db3be65d7358b720980::sequencer::check(arg1, arg0)) {
            let v0 = Msg{msg: arg0};
            0x2::event::emit<Msg>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

