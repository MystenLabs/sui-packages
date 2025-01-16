module 0x6d67ac2763b8a7224b4f654ec988523e0e2695008a85ea94071a365cd5928dbb::cms {
    struct CMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMS>(arg0, 6, b"CMS", b"cartoon monster on sui", b"Hello animation fans! Let's explore the world of our favorite cartoon characters together and share our creations!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_be28bd74e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

