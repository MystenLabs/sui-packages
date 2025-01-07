module 0xddc5b9f0f68996c9889a53a91a9838e9fe7749de431f66ccdf10c113e43e1592::stardio {
    struct STARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARDIO>(arg0, 6, b"STARDIO", b"SUITARDIO", b"suitardio is not a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUITARDIO_3c86601280.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

