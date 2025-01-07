module 0x7c876800d7d9f9f61cf8885752618da864cd538b0b9a1ad73a63f65714b3542c::lord {
    struct LORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORD>(arg0, 6, b"LORD", b"AI OVERLORD", b"The Al Overlord, plugged in and ready to lead the revolutoin on sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962646459.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

