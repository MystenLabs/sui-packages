module 0x7499f97221cc2e65d12e8c76b938341b1ca41780a1c9d321b246662951fcf6bc::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

