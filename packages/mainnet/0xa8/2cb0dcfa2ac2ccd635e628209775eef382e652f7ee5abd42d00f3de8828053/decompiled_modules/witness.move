module 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::witness {
    struct BucketV2CDP has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2CDP {
        BucketV2CDP{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

