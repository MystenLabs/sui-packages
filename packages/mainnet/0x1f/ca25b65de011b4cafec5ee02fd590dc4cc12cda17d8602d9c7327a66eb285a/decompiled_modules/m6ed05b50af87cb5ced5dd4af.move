module 0x1fca25b65de011b4cafec5ee02fd590dc4cc12cda17d8602d9c7327a66eb285a::m6ed05b50af87cb5ced5dd4af {
    public fun f570df7eefdc3f5385d90aab0(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::VAA {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

