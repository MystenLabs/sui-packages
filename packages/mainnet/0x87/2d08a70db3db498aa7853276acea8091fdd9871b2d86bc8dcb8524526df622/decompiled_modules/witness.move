module 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::witness {
    struct BucketV2Saving has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2Saving {
        BucketV2Saving{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

