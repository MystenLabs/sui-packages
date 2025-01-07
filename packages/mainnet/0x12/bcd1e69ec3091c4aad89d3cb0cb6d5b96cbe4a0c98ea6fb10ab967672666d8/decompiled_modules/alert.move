module 0x12bcd1e69ec3091c4aad89d3cb0cb6d5b96cbe4a0c98ea6fb10ab967672666d8::alert {
    struct LogAssert has copy, drop {
        error: u64,
    }

    public fun alert(arg0: bool, arg1: u64) {
        if (!arg0) {
            let v0 = LogAssert{error: arg1};
            0x2::event::emit<LogAssert>(v0);
            assert!(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

