module 0x1b81940830d9da4a078f5ada7e84fb6a5359760f88a3dbe6da792f4a6fdccdfd::caster {
    public fun cast_to_u8(arg0: 0x1b81940830d9da4a078f5ada7e84fb6a5359760f88a3dbe6da792f4a6fdccdfd::i32::I32) : u8 {
        assert!(0x1b81940830d9da4a078f5ada7e84fb6a5359760f88a3dbe6da792f4a6fdccdfd::i32::abs_u32(arg0) < 256, 0);
        ((0x1b81940830d9da4a078f5ada7e84fb6a5359760f88a3dbe6da792f4a6fdccdfd::i32::abs_u32(0x1b81940830d9da4a078f5ada7e84fb6a5359760f88a3dbe6da792f4a6fdccdfd::i32::add(arg0, 0x1b81940830d9da4a078f5ada7e84fb6a5359760f88a3dbe6da792f4a6fdccdfd::i32::from(256))) & 255) as u8)
    }

    // decompiled from Move bytecode v6
}

