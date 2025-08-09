module 0x8630c82c22743756f0f8ce012107b68a26a3422bf67b759d967a16d2178c5cc4::lgrock {
    struct LGROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGROCK>(arg0, 6, b"LGROCK", b"Little Grock", b"Little Grock is the underdog meme champion rising fast in the Sui ecosystem, blending raw energy, chaotic charm, and unstoppable community power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejotngkcxwqnfblmo4gpwmvks2t4r7fkuvuerse3p2vt4foy3mxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LGROCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

