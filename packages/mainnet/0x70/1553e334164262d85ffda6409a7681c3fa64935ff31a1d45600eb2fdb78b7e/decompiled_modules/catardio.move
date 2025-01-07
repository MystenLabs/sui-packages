module 0x701553e334164262d85ffda6409a7681c3fa64935ff31a1d45600eb2fdb78b7e::catardio {
    struct CATARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATARDIO>(arg0, 6, b"CATARDIO", b"Catardio", b"Welcome to $CATARDIO, We are all CATARDED in our own ways.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731630120165.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATARDIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATARDIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

