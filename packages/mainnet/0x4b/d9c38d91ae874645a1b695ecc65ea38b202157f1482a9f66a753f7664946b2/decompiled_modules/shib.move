module 0x4bd9c38d91ae874645a1b695ecc65ea38b202157f1482a9f66a753f7664946b2::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"Shiba Inu", b"Buy Shiba Inu today! Best meme coin on SUI! Buy low and keep holding for the bull run!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5411_50d5db678c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

