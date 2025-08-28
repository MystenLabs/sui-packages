module 0x3e29df454c0a711f0423a98b4a83df74d23c3a59ec016adedd02585922e15012::witness {
    struct BucketV2Saving has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2Saving {
        BucketV2Saving{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

