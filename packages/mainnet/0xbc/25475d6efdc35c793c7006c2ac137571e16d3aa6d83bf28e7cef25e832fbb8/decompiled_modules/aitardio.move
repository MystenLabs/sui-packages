module 0xbc25475d6efdc35c793c7006c2ac137571e16d3aa6d83bf28e7cef25e832fbb8::aitardio {
    struct AITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AITARDIO>(arg0, 6, b"AITARDIO", b"AI RETARDIO", b"AI is not what it once was, Retardio has taken over,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7783_61de1ffdd5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

