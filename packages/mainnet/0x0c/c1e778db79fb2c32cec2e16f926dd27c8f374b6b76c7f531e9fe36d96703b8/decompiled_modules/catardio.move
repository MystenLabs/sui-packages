module 0xcc1e778db79fb2c32cec2e16f926dd27c8f374b6b76c7f531e9fe36d96703b8::catardio {
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

