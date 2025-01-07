module 0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::test {
    struct Msg has copy, drop {
        msg: u8,
    }

    public fun seq_emit(arg0: u8, arg1: &0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::Indexer) {
        if (0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::check(arg1, arg0)) {
            let v0 = Msg{msg: arg0};
            0x2::event::emit<Msg>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

