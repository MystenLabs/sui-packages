module 0x771dbabf3c7a7f45ff929a62b1e91e151d9c4e239e32025821d7d463b98a0aeb::fallenlove {
    struct FALLENLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALLENLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALLENLOVE>(arg0, 6, b"FallenLove", b"KNIGHT", b"When the knight falls dark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5704_d92a669c09.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALLENLOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALLENLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

