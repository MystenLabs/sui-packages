module 0x18dd9c5a59620570a07060bd8cce8b6ee0fc02647f1e0db8b8c0f9939443042d::errors {
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

