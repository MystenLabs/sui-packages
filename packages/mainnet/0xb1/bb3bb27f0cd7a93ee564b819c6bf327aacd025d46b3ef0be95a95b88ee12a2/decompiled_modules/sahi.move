module 0xb1bb3bb27f0cd7a93ee564b819c6bf327aacd025d46b3ef0be95a95b88ee12a2::sahi {
    struct SAHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHI>(arg0, 6, b"SAHI", b"Satoshi Hippo", b"SATOSHI NAKAMOTO REVEALED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_ec58574654.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

