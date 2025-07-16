module 0xa4f83e14f6814d6ff30bf48464bfdf931a4ffaac1a001e2e9571bed1f72b764e::dowg {
    struct DOWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWG>(arg0, 6, b"DOWG", b"THE DYSLEXIC DOG", x"444f574720544845204459534c4558494320444f470a0a436f6d6d756e6974793a200a68747470733a2f2f782e636f6d2f692f636f6d6d756e69746965732f31393435353037323039303632303331373430", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6ebucdwq7kccqzllwo7kw3yk73phzibylxhrntx6tjb73j2i4r4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOWG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

