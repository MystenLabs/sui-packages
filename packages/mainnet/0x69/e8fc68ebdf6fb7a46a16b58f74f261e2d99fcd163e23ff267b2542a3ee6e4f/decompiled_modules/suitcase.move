module 0x69e8fc68ebdf6fb7a46a16b58f74f261e2d99fcd163e23ff267b2542a3ee6e4f::suitcase {
    struct SUITCASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCASE>(arg0, 6, b"SUITCASE", b"I LIKE MY SUITCASE!", b"I LIKE MY SUITCASE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1688_ee47ea11c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITCASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

