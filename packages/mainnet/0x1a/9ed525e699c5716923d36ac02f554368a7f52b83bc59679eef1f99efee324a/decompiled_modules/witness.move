module 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::witness {
    struct BucketV2CDP has drop {
        dummy_field: bool,
    }

    public(friend) fun witness() : BucketV2CDP {
        BucketV2CDP{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

