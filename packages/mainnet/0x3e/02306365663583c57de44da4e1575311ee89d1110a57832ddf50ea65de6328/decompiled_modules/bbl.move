module 0x3e02306365663583c57de44da4e1575311ee89d1110a57832ddf50ea65de6328::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBL>(arg0, 6, b"BBL", b"BUBL", b"bublsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954342190.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

