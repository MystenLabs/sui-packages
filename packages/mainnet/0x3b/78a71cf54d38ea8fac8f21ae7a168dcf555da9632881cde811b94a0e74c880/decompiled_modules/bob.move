module 0x3b78a71cf54d38ea8fac8f21ae7a168dcf555da9632881cde811b94a0e74c880::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"BOB THE BLOB", b"In the depths of the digital ocean, there's a mystical blob-like reef that no fish dares to swim near except for Bob, the bravest fish in all the seas. Bob isn't just any fish. He's a curious, odd-looking blobfish who's determined to find his place in a world that keeps changing around him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo2_9ddf1be050.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

