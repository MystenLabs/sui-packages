module 0x3c32120348da2ce052329f9963297d5fca913a3f775f5fa9a86424239ea97f38::ever {
    struct EVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EVER>(arg0, 6, b"EVER", b"Ever", b"Embrace everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/79212_1a57ea7c22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

