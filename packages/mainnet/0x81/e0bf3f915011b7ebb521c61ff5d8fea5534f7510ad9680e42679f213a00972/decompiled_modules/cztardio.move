module 0x81e0bf3f915011b7ebb521c61ff5d8fea5534f7510ad9680e42679f213a00972::cztardio {
    struct CZTARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZTARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZTARDIO>(arg0, 6, b"CZTARDIO", b"4RETARDIOS", b"4 rules: BUY/HODL/RETARDIO/MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_67a1695caa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZTARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZTARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

