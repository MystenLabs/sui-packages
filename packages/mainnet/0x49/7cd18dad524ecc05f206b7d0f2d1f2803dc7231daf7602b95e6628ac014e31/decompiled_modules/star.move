module 0x497cd18dad524ecc05f206b7d0f2d1f2803dc7231daf7602b95e6628ac014e31::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"Staryu", b"STARYU brings the nostalgic vibes of the ocean straight to your wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifft4kvl4r6ty3ziapsprddad5qvybhxm5cymand6fdnwnqyespkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

