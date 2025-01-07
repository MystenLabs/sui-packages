module 0xa6cc6b647ea203c6a4d3800042789e1512b0c2ce315a70ae753639cda8e01647::spunk {
    struct SPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNK>(arg0, 6, b"SPUNK", b"Sui Punk Club", b"CRYPTOPUNKS WERE PUT INTO SUI TO GIVE BIRTH TO NEW BASTARD CHILDREN. NOW THEY ARE DEGENERATING THE WORLD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/874ab899_22ce_4ea3_aff5_7b2a6369b4d1_v2_webp_90c1d013f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

