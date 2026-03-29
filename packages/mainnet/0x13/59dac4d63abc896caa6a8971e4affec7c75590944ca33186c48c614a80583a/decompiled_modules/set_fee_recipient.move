module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::set_fee_recipient {
    struct PythFeeRecipient {
        recipient: address,
    }

    public(friend) fun execute(arg0: &0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::LatestOnly, arg1: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg2: vector<u8>) {
        let PythFeeRecipient { recipient: v0 } = from_byte_vec(arg2);
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::set_fee_recipient(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : PythFeeRecipient {
        let v0 = 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::new<u8>(arg0);
        0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::cursor::destroy_empty<u8>(v0);
        PythFeeRecipient{recipient: 0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::external_address::to_address(0x913c5b4adfe7d198b085e1f8d2682c9ae08e9673bcd4bcbd023a9f9ad62cf665::external_address::take_nonzero(&mut v0))}
    }

    // decompiled from Move bytecode v6
}

