module 0x9095d9f9c59400e96e613ebe31a05c5a95d43087d41ab0720c186ebc212e52fa::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"RONDA", b"its RONDAAA", x"69747320676f6e6e6120626520524f4e444120616e6420726f6e646120697320546865206669727374207265616c20646f67206f6e207375692e200a68747470733a2f2f6c696e6b74722e65652f726f6e64616f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_O3j7mma_400x400_d6d7a0b484.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

