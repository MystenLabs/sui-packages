module 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::caster {
    public fun cast_to_u8(arg0: 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::i32::I32) : u8 {
        assert!(0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::i32::abs_u32(arg0) < 256, 0);
        ((0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::i32::abs_u32(0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::i32::add(arg0, 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::i32::from(256))) & 255) as u8)
    }

    // decompiled from Move bytecode v6
}

