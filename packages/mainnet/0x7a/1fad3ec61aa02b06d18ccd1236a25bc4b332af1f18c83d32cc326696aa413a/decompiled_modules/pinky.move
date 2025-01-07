module 0x7a1fad3ec61aa02b06d18ccd1236a25bc4b332af1f18c83d32cc326696aa413a::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 6, b"Pinky", b"Pinky on sui", b"Pinky the pinable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_8_4c0b91d365.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

