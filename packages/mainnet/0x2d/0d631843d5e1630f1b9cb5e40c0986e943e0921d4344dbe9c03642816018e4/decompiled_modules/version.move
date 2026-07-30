module 0x2d0d631843d5e1630f1b9cb5e40c0986e943e0921d4344dbe9c03642816018e4::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

