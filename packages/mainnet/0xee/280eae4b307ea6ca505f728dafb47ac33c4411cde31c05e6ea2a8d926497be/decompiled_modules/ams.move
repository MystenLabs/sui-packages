module 0xee280eae4b307ea6ca505f728dafb47ac33c4411cde31c05e6ea2a8d926497be::ams {
    struct AMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMS>(arg0, 6, b"AMS", b"ALPHA META SIGMA", b"ALPHA META SIGMA Sui water company", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_33_fda993139b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

