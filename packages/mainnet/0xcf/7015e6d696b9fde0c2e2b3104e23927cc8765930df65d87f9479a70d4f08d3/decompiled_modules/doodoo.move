module 0xcf7015e6d696b9fde0c2e2b3104e23927cc8765930df65d87f9479a70d4f08d3::doodoo {
    struct DOODOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODOO>(arg0, 6, b"DOODOO", b"Sui BabyShark", x"4261627920736861726b2c20646f6f20646f6f20646f6f20646f6f20646f6f20646f6f0a4261627920736861726b2c20646f6f20646f6f20646f6f20646f6f20646f6f20646f6f0a4261627920736861726b2c20646f6f20646f6f20646f6f20646f6f20646f6f20646f6f0a4261627920736861726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BABYSHARK_1_7ebcaa6593.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

