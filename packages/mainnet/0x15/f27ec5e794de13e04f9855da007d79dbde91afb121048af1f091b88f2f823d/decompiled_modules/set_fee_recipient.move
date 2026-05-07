module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::set_fee_recipient {
    struct PythFeeRecipient {
        recipient: address,
    }

    public(friend) fun execute(arg0: &0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::LatestOnly, arg1: &mut 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::State, arg2: vector<u8>) {
        let PythFeeRecipient { recipient: v0 } = from_byte_vec(arg2);
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::set_fee_recipient(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : PythFeeRecipient {
        let v0 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::new<u8>(arg0);
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::destroy_empty<u8>(v0);
        PythFeeRecipient{recipient: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::to_address(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::external_address::take_nonzero(&mut v0))}
    }

    // decompiled from Move bytecode v7
}

