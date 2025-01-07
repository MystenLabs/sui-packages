module 0x7734394fc236700df649ff81ae3f0e8bd25df6d95756c30563b439e6142b97fb::bmoodeng {
    struct BMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOODENG>(arg0, 6, b"Bmoodeng", b"Baby Moodeng", b"Baby Moodeng ($BabyMoodeng) inspired by its mother token, Moodeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_12_35_31_86d3c9d3fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

