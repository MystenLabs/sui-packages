module 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::error {
    public fun already_claimed() : u64 {
        10001
    }

    public fun invalid_proof() : u64 {
        10002
    }

    public fun invalid_time() : u64 {
        10000
    }

    // decompiled from Move bytecode v6
}

