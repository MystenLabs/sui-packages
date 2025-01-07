module 0x93c39f906d3268327cdc0012970857e01c692adce7a3eb774d4d6fee6c65410d::error {
    public fun airdrop_closed() : u64 {
        10005
    }

    public fun already_claimed() : u64 {
        10001
    }

    public fun insufficient_balance() : u64 {
        10003
    }

    public fun invalid_proof() : u64 {
        10002
    }

    public fun invalid_receipent() : u64 {
        10004
    }

    public fun invalid_signature() : u64 {
        10006
    }

    public fun invalid_time() : u64 {
        10000
    }

    // decompiled from Move bytecode v6
}

