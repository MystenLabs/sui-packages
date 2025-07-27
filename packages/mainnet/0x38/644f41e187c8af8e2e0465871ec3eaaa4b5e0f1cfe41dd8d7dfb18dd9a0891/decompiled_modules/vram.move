module 0x38644f41e187c8af8e2e0465871ec3eaaa4b5e0f1cfe41dd8d7dfb18dd9a0891::vram {
    struct VRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRAM>(arg0, 6, b"VRAM", b"VRAM ON SUI", b"VRAM.FUN is currently in token-gated beta. To access the platform, you need:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibp35qjmavkk3gcwbu5qjk47kvaru25zgacaffheamyvmxiqkfk34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VRAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

