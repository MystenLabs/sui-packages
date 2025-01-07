module 0x8ec7778bc946eff53b846f661d2445af8739359409ff2dfa9c0565f9f65ea0e0::pmaaa {
    struct PMAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMAAA>(arg0, 6, b"PMAAA", b"Pop MoodengAAAA", b"moodeng meta", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_10_52_24_49586582ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

