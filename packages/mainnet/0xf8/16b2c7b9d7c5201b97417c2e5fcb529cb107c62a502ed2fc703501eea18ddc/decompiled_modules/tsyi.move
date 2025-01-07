module 0xf816b2c7b9d7c5201b97417c2e5fcb529cb107c62a502ed2fc703501eea18ddc::tsyi {
    struct TSYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSYI>(arg0, 6, b"TSYI", b"TS", b"Let's face TS head-on!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ts_ff36196915.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

