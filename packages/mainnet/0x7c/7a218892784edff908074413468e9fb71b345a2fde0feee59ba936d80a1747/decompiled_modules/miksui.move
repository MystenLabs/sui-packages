module 0x7c7a218892784edff908074413468e9fb71b345a2fde0feee59ba936d80a1747::miksui {
    struct MIKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKSUI>(arg0, 6, b"Miksui", b"Mika sui", b"Miksui is meme of vcs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfxlox7bn3elxh3ys5gvo4rigablaiagnul5fqaoc3us22rjhujy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

