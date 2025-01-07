module 0x5138305bc9265e3f92186d30478661484190ad75a8b5159f64eaeb40e79d9795::fnws {
    struct FNWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNWS>(arg0, 6, b"FNWS", b"SUI FISH NEWS", b"$FNWS bikini bottom television", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fnws_5de2c339d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FNWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

