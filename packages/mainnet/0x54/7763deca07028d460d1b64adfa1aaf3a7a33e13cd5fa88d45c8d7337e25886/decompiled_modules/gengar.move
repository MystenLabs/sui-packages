module 0x547763deca07028d460d1b64adfa1aaf3a7a33e13cd5fa88d45c8d7337e25886::gengar {
    struct GENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGAR>(arg0, 6, b"Gengar", b"Gen Sui", b"Welcome to the next generation of memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0455_9c6a9ac717.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

