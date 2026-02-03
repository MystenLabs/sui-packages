module 0xd08ded088c669e51aee2570c65cabcbd56a747b6d62fd4a2f480fcfcd6099c9::memo {
    struct MemoEvent has copy, drop {
        content: vector<u8>,
    }

    public entry fun write(arg0: vector<u8>) {
        let v0 = MemoEvent{content: arg0};
        0x2::event::emit<MemoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

