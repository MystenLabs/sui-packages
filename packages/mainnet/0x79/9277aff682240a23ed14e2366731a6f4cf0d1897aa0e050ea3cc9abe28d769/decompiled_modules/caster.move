module 0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::caster {
    public fun cast_to_u8(arg0: 0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::i32::I32) : u8 {
        assert!(0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::i32::abs_u32(arg0) < 256, 0);
        ((0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::i32::abs_u32(0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::i32::add(arg0, 0x799277aff682240a23ed14e2366731a6f4cf0d1897aa0e050ea3cc9abe28d769::i32::from(256))) & 255) as u8)
    }

    // decompiled from Move bytecode v6
}

