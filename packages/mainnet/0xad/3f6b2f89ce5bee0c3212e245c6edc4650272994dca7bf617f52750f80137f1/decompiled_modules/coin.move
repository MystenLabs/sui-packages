module 0xad3f6b2f89ce5bee0c3212e245c6edc4650272994dca7bf617f52750f80137f1::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"SDOG", b"SUIDOG", b"The ultimate dog meme on SUI. Every blockchain deserves its loyal companion, and Wrapped Suidog is here to brighten SUI following the hype of $SUIDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://207.148.66.213:4137/uploads/dog_143eab2683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

