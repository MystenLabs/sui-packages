module 0xf63d544b5f988b72835a89d65bf1b1fe84eb02a6346a3bc055884648a48715e6::crofart {
    struct CROFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROFART>(arg0, 6, b"CROFART", b"Cronje Fart", b"Just a Cronje Fart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiepmbsxttmk7rivgfvsbq5dsydqidgoj7g5rynpljz3umfjluhn6m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROFART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROFART>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

