module 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::set_fee_recipient {
    struct PythFeeRecipient {
        recipient: address,
    }

    public(friend) fun execute(arg0: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::LatestOnly, arg1: &mut 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::State, arg2: vector<u8>) {
        let PythFeeRecipient { recipient: v0 } = from_byte_vec(arg2);
        0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::state::set_fee_recipient(arg0, arg1, v0);
    }

    fun from_byte_vec(arg0: vector<u8>) : PythFeeRecipient {
        let v0 = 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::new<u8>(arg0);
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::destroy_empty<u8>(v0);
        PythFeeRecipient{recipient: 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::external_address::to_address(0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::external_address::take_nonzero(&mut v0))}
    }

    // decompiled from Move bytecode v6
}

