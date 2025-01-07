module 0x408cef7c94c68f4c10a4f18af81649ff64d8f2a4d9f2fab0ef67354dcf005227::suikoku {
    struct SUIKOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOKU>(arg0, 6, b"Suikoku", b"SUIKOKU", b"Suikoku is a blockchain project inspired by the strength, loyalty, and resilience of the Shikoku Inu, a native Japanese dog breed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241028_224236_6e60bbcf5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

