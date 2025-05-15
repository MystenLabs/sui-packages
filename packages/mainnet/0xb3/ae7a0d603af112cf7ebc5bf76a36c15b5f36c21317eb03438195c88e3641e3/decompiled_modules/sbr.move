module 0xb3ae7a0d603af112cf7ebc5bf76a36c15b5f36c21317eb03438195c88e3641e3::sbr {
    struct SBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBR>(arg0, 6, b"SBR", b"Suibasaur", b"Poke is Poke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkaysyprcxjre6lougknyn3sv3oji4sjh2jdnl2mdx3n4lizbyqu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

