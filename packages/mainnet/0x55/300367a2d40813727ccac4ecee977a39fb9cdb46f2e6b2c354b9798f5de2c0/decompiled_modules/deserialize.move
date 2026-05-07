module 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::deserialize {
    public fun deserialize_i32(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::Cursor<u8>) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64 {
        let v0 = deserialize_u32(arg0);
        if (v0 >> 31 == 1) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::from_u64(((18446744069414584320 + (v0 as u64)) as u64))
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::from_u64((v0 as u64))
        }
    }

    public fun deserialize_i64(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::Cursor<u8>) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64 {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::from_u64(deserialize_u64(arg0))
    }

    public fun deserialize_u16(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::Cursor<u8>) : u16 {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes::take_u16_be(arg0)
    }

    public fun deserialize_u32(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::Cursor<u8>) : u32 {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes::take_u32_be(arg0)
    }

    public fun deserialize_u64(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::Cursor<u8>) : u64 {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes::take_u64_be(arg0)
    }

    public fun deserialize_u8(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::Cursor<u8>) : u8 {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes::take_u8(arg0)
    }

    public fun deserialize_vector(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::cursor::Cursor<u8>, arg1: u64) : vector<u8> {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::bytes::take_bytes(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

