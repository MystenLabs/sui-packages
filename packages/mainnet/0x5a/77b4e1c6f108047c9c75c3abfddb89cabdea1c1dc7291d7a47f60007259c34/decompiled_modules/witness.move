module 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::witness {
    struct BucketV2PSM has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2PSM {
        BucketV2PSM{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

