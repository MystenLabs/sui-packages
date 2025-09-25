module 0xf9ac2a5a3ebccbaddde4ffacaa375025202b569dcf118f42d664cfb35a3c9984::caster {
    public fun cast_to_u8(arg0: 0xf9ac2a5a3ebccbaddde4ffacaa375025202b569dcf118f42d664cfb35a3c9984::i32::I32) : u8 {
        assert!(0xf9ac2a5a3ebccbaddde4ffacaa375025202b569dcf118f42d664cfb35a3c9984::i32::abs_u32(arg0) < 256, 0);
        ((0xf9ac2a5a3ebccbaddde4ffacaa375025202b569dcf118f42d664cfb35a3c9984::i32::abs_u32(0xf9ac2a5a3ebccbaddde4ffacaa375025202b569dcf118f42d664cfb35a3c9984::i32::add(arg0, 0xf9ac2a5a3ebccbaddde4ffacaa375025202b569dcf118f42d664cfb35a3c9984::i32::from(256))) & 255) as u8)
    }

    // decompiled from Move bytecode v6
}

