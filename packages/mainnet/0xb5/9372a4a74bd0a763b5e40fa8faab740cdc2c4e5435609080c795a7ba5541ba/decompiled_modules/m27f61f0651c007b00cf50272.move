module 0xb59372a4a74bd0a763b5e40fa8faab740cdc2c4e5435609080c795a7ba5541ba::m27f61f0651c007b00cf50272 {
    public fun fe5022db1df8ac0fc2ff765f4(arg0: &0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::VAA {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

