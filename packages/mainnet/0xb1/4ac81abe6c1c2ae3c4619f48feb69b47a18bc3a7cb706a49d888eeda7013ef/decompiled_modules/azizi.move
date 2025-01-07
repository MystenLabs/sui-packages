module 0xb14ac81abe6c1c2ae3c4619f48feb69b47a18bc3a7cb706a49d888eeda7013ef::azizi {
    struct AZIZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZIZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZIZI>(arg0, 6, b"Azizi", b"Azizi - Precious Treasure", b"Baby rhino - means precious treasure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3012_616240de09.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZIZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZIZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

