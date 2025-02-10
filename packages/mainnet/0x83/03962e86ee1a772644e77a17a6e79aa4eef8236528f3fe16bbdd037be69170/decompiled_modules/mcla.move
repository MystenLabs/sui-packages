module 0x8303962e86ee1a772644e77a17a6e79aa4eef8236528f3fe16bbdd037be69170::mcla {
    struct MCLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCLA>(arg0, 6, b"MCLA", b"Minecraft Lava Block", b"The Minecraft Lava Block. That's about it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739184868741.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

