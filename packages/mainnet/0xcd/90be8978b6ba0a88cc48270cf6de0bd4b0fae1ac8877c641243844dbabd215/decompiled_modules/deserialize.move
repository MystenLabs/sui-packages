module 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::deserialize {
    public fun deserialize_i32(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::Cursor<u8>) : 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::I64 {
        let v0 = deserialize_u32(arg0);
        if (v0 >> 31 == 1) {
            0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::from_u64(((18446744069414584320 + (v0 as u64)) as u64))
        } else {
            0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::from_u64((v0 as u64))
        }
    }

    public fun deserialize_i64(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::Cursor<u8>) : 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::I64 {
        0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::from_u64(deserialize_u64(arg0))
    }

    public fun deserialize_u16(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::Cursor<u8>) : u16 {
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::bytes::take_u16_be(arg0)
    }

    public fun deserialize_u32(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::Cursor<u8>) : u32 {
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::bytes::take_u32_be(arg0)
    }

    public fun deserialize_u64(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::Cursor<u8>) : u64 {
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::bytes::take_u64_be(arg0)
    }

    public fun deserialize_u8(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::Cursor<u8>) : u8 {
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::bytes::take_u8(arg0)
    }

    public fun deserialize_vector(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::cursor::Cursor<u8>, arg1: u64) : vector<u8> {
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::bytes::take_bytes(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

