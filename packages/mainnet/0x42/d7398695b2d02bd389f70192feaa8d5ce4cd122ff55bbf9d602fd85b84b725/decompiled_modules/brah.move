module 0x42d7398695b2d02bd389f70192feaa8d5ce4cd122ff55bbf9d602fd85b84b725::brah {
    struct BRAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAH>(arg0, 6, b"BRAH", b"Brah SUI", b"Meet $BRAH, the lazy green monster that doesn't give a damn about anything or anyone. $BRAH is sick of watching meme tokens recently bleed to zero and be left with a true $BRAH moment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_16_13_12_27_ef466e0623.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

