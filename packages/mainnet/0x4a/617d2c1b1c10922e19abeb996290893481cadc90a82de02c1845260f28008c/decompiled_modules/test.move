module 0x4a617d2c1b1c10922e19abeb996290893481cadc90a82de02c1845260f28008c::test {
    struct Msg has copy, drop {
        msg: u8,
    }

    public fun seq_emit(arg0: u8, arg1: &0x4a617d2c1b1c10922e19abeb996290893481cadc90a82de02c1845260f28008c::sequencer::Indexer) {
        if (0x4a617d2c1b1c10922e19abeb996290893481cadc90a82de02c1845260f28008c::sequencer::check(arg1, arg0)) {
            let v0 = Msg{msg: arg0};
            0x2::event::emit<Msg>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

