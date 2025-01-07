module 0xaf30b6ce83835dd0e6a1888dc3c73640181de4d7da885597b4eb3a14e3df4abb::cwif {
    struct CWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWIF>(arg0, 6, b"CWIF", b"Cat Wif Hat", b"CatWifHat is a cool meme token on Sui. Its all about fun vibes, cute art, and crypto hype, bringing together peeps from the web and the crypto fam worldwide!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catwif_b875dd0def.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

