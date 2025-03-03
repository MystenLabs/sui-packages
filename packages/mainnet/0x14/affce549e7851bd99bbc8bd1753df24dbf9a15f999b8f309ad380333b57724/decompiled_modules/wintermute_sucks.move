module 0x14affce549e7851bd99bbc8bd1753df24dbf9a15f999b8f309ad380333b57724::wintermute_sucks {
    struct Stashed has copy, drop, store {
        note: vector<u8>,
    }

    public entry fun wintermute_sucks(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Stashed{note: b"TriArbSuccess"};
        0x2::event::emit<Stashed>(v0);
    }

    // decompiled from Move bytecode v6
}

