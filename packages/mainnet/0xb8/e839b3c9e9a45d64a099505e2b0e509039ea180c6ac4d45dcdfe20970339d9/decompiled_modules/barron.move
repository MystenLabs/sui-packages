module 0xb8e839b3c9e9a45d64a099505e2b0e509039ea180c6ac4d45dcdfe20970339d9::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"Barron", b"Barron Meme", b"Rumor has it this was launched by Barron himself. Most likely the future President of America and Time Traveler. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737496266598.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARRON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

