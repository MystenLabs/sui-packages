module 0xe75bd6d9dee2cc66f29ea32a7a4a4161e591b327be3022fec7416dd8dad139b6::wuckduck {
    struct WUCKDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUCKDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUCKDUCK>(arg0, 6, b"WUCKDUCK", b"DUCK AGENT", b"WUCKDUCK THE AGENT DUCK WITH MOON MISSION on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigflfbbzuv5mvw4ulmyet5nsdvvnp2scqvswed47uylt6yl6z7lgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUCKDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WUCKDUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

