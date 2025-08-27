module 0xf51f9eb63574a1d12b62295599ac4f8231197f95b3cce9a516daba64f419d06::witness {
    struct BucketV2Flash has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2Flash {
        BucketV2Flash{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

