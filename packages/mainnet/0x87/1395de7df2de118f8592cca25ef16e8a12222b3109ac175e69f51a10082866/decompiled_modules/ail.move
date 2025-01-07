module 0x871395de7df2de118f8592cca25ef16e8a12222b3109ac175e69f51a10082866::ail {
    struct AIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIL>(arg0, 6, b"AIL", b"AILUROS", b"Ailuros is the Greek name for the ancient Egyptian cat goddess Bastet, revered as the goddess of home, fertility, and protector of women and children. Often depicted as a lioness or a domestic cat, Ailuros symbolized grace, beauty, and protection. Cats were sacred in ancient Egypt, and Bastet was celebrated for her ability to keep evil spirits and diseases at bay. Temples were built in her honor, where worshippers would offer statues and mummified cats to seek her favor and protection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/24773_C08_AF_3_A_4943_8_C80_DD_79_F1588950_41ba2999a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

