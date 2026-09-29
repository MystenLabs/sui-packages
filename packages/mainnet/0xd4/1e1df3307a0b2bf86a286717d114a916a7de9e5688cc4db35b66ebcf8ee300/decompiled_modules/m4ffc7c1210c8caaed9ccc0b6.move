module 0xd41e1df3307a0b2bf86a286717d114a916a7de9e5688cc4db35b66ebcf8ee300::m4ffc7c1210c8caaed9ccc0b6 {
    public fun f5a004bf5f77728eb9756c011(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::VAA {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

