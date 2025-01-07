module 0xf3a9c42bced2306afa8ca0d4b4771cfb6f1aaa64d18ff0b566d8a7120aaae7d5::ayahuasca {
    struct AYAHUASCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYAHUASCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYAHUASCA>(arg0, 6, b"Ayahuasca", b"Ayahuasca Coin", b"Surely there is a Ayahuasca coin by now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ayahuasca_prep_f4fdbfb407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYAHUASCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYAHUASCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

