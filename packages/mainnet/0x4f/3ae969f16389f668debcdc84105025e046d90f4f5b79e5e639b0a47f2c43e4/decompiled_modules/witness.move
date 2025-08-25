module 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::witness {
    struct BucketV2Flash has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2Flash {
        BucketV2Flash{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

