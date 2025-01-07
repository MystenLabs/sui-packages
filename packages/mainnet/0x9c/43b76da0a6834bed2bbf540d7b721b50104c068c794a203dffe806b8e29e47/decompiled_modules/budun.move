module 0x9c43b76da0a6834bed2bbf540d7b721b50104c068c794a203dffe806b8e29e47::budun {
    struct BUDUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDUN>(arg0, 6, b"BUDUN", b"BUDUN SUI", b"I'm your daddy, bring me Boden and Tremp. I will let them taste my Doddy oil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_27_10_39_48_678ced6be2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

