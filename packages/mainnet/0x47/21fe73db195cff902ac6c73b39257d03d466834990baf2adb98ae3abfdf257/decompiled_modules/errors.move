module 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::errors {
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

