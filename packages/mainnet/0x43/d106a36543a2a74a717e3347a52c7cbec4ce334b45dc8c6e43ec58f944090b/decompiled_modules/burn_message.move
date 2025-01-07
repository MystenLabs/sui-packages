module 0x43d106a36543a2a74a717e3347a52c7cbec4ce334b45dc8c6e43ec58f944090b::burn_message {
    struct BurnMessage has copy, drop {
        version: u32,
        burn_token: address,
        mint_recipient: address,
        amount: u256,
        message_sender: address,
    }

    public fun amount(arg0: &BurnMessage) : u256 {
        arg0.amount
    }

    public fun burn_token(arg0: &BurnMessage) : address {
        arg0.burn_token
    }

    public(friend) fun from_bytes(arg0: &vector<u8>) : BurnMessage {
        validate_raw_message(arg0);
        BurnMessage{
            version        : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::deserialize::deserialize_u32_be(arg0, 0, 4),
            burn_token     : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::deserialize::deserialize_address(arg0, 4, 32),
            mint_recipient : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::deserialize::deserialize_address(arg0, 36, 32),
            amount         : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::deserialize::deserialize_u256_be(arg0, 68, 32),
            message_sender : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::deserialize::deserialize_address(arg0, 100, 32),
        }
    }

    public fun message_sender(arg0: &BurnMessage) : address {
        arg0.message_sender
    }

    public fun mint_recipient(arg0: &BurnMessage) : address {
        arg0.mint_recipient
    }

    fun validate_raw_message(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 132, 0);
    }

    public fun version(arg0: &BurnMessage) : u32 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

