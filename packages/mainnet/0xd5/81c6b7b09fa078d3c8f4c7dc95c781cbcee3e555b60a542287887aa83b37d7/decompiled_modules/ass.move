module 0xd581c6b7b09fa078d3c8f4c7dc95c781cbcee3e555b60a542287887aa83b37d7::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 6, b"ASS", b"Asani", b"No des", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pramb_1ef72636d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

