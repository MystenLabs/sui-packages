module 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::bytes {
    fun push_reverse<T0: drop>(arg0: &mut vector<u8>, arg1: T0) {
        let v0 = 0x1::bcs::to_bytes<T0>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(arg0, v0);
    }

    public fun push_u128_be(arg0: &mut vector<u8>, arg1: u128) {
        push_reverse<u128>(arg0, arg1);
    }

    public fun push_u16_be(arg0: &mut vector<u8>, arg1: u16) {
        push_reverse<u16>(arg0, arg1);
    }

    public fun push_u256_be(arg0: &mut vector<u8>, arg1: u256) {
        push_reverse<u256>(arg0, arg1);
    }

    public fun push_u32_be(arg0: &mut vector<u8>, arg1: u32) {
        push_reverse<u32>(arg0, arg1);
    }

    public fun push_u64_be(arg0: &mut vector<u8>, arg1: u64) {
        push_reverse<u64>(arg0, arg1);
    }

    public fun push_u8(arg0: &mut vector<u8>, arg1: u8) {
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    public fun take_bytes(arg0: &mut 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::Cursor<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u8>(&mut v0, 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::poke<u8>(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    public fun take_u128_be(arg0: &mut 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::Cursor<u8>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::poke<u8>(arg0) as u128);
            v1 = v1 + 1;
        };
        v0
    }

    public fun take_u16_be(arg0: &mut 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::Cursor<u8>) : u16 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 2) {
            let v2 = v0 << 8;
            v0 = v2 + (0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::poke<u8>(arg0) as u16);
            v1 = v1 + 1;
        };
        v0
    }

    public fun take_u256_be(arg0: &mut 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::Cursor<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 + (0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::poke<u8>(arg0) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun take_u32_be(arg0: &mut 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::Cursor<u8>) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            let v2 = v0 << 8;
            v0 = v2 + (0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::poke<u8>(arg0) as u32);
            v1 = v1 + 1;
        };
        v0
    }

    public fun take_u64_be(arg0: &mut 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::Cursor<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 + (0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::poke<u8>(arg0) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun take_u8(arg0: &mut 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::Cursor<u8>) : u8 {
        0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::cursor::poke<u8>(arg0)
    }

    // decompiled from Move bytecode v6
}

