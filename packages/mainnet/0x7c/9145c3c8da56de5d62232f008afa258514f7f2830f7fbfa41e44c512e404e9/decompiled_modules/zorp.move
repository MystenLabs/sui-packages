module 0x7c9145c3c8da56de5d62232f008afa258514f7f2830f7fbfa41e44c512e404e9::zorp {
    struct ZORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORP>(arg0, 6, b"ZORP", b"ZORP on Sui", b"The friendly alien for planet solana looking for a friends in Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0854_bfd0a8a3ef_9e80fc8cd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

