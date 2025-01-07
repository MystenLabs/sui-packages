module 0x770981974d2e9afe4efbdaa96ac8f9802f8f29ac961fc460d5db8962440d8140::lorya {
    struct LORYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORYA>(arg0, 6, b"LORYA", b"Loryaslime", b"AI - Powered on-chain analytics for targeted growth .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044669_b1f0107b75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

