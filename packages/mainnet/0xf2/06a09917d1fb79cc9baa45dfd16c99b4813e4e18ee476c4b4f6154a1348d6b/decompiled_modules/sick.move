module 0xf206a09917d1fb79cc9baa45dfd16c99b4813e4e18ee476c4b4f6154a1348d6b::sick {
    struct SICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICK>(arg0, 6, b"SICK", b"SuiSick", b"Felling SuiSick af from all the ruggs these days ngl..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihrn6vxr7d2czatrzvpr2xzo3hat7b5v6ouiimovppyelni27gkui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

