module 0x2808d3eb3135bca0f145c0cefb645ff20ed250dac160c4255073e068c8c8e0ec::selfie {
    struct SELFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFIE>(arg0, 6, b"SELFIE", b"SelfieDogCoin", b"taking picture at sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/selfie_dogie_1450c17e85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

