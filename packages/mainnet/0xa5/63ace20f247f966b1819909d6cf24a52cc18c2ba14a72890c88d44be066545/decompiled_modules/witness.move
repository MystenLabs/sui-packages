module 0xa563ace20f247f966b1819909d6cf24a52cc18c2ba14a72890c88d44be066545::witness {
    struct BucketV2PSM has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2PSM {
        BucketV2PSM{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

