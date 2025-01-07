module 0x8324b8e3fb03d91d775afa974f7c6974d899338e3f255bcdd26bd049fa483a93::errors {
    public fun insufficient_funds() : u64 {
        1004
    }

    public fun unauthorized() : u64 {
        1003
    }

    public fun version_mismatch() : u64 {
        1001
    }

    public fun zero_coin_amount() : u64 {
        1002
    }

    // decompiled from Move bytecode v6
}

