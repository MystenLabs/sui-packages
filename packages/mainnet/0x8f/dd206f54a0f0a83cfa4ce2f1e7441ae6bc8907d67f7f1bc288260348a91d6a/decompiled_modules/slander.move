module 0x8fdd206f54a0f0a83cfa4ce2f1e7441ae6bc8907d67f7f1bc288260348a91d6a::slander {
    struct SLANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLANDER>(arg0, 6, b"SLANDER", b"SUILANDER", b"Top Model Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilander_27db0a9940.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

