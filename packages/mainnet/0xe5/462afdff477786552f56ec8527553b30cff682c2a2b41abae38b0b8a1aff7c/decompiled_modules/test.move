module 0xe5462afdff477786552f56ec8527553b30cff682c2a2b41abae38b0b8a1aff7c::test {
    struct Msg has copy, drop {
        msg: u8,
    }

    public fun seq_emit(arg0: u8, arg1: &0xe5462afdff477786552f56ec8527553b30cff682c2a2b41abae38b0b8a1aff7c::sequencer::Indexer) {
        if (0xe5462afdff477786552f56ec8527553b30cff682c2a2b41abae38b0b8a1aff7c::sequencer::check(arg1, arg0)) {
            let v0 = Msg{msg: arg0};
            0x2::event::emit<Msg>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

