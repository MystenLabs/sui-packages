module 0x31525a0a024efe7d646a57e230a0ffa1ffa555ba0c33a0de8c224bef1c4275c5::hihe {
    struct HIHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHE>(arg0, 6, b"HIHE", b"HIHIHEHE", b"\"The joy of 'hihihehe' in life is so simple! Sometimes, all it takes is a cheeky grin and a small moment to turn an entire day brighter. This meme is a reminder to find happiness in the little things, embracing life with innocence and humor. Let laughter spread and light up everything around you!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7794defd_a0c9_4817_8b44_238173a36d0a_e505d0741a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

