module 0xd9f96518dc4e32dfd3608fd812076c28d3548b7cdf564f39b43ed8234495430a::brudd {
    struct BRUDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUDD>(arg0, 6, b"BRUDD", b"Brudd on sui", b"The Leading Meme coin on SUI. BRUDD is the Legendary Character created by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000123465_8d1da18fd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

