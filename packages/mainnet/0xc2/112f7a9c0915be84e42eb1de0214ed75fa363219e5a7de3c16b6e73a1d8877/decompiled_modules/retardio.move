module 0xc2112f7a9c0915be84e42eb1de0214ed75fa363219e5a7de3c16b6e73a1d8877::retardio {
    struct RETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIO>(arg0, 6, b"RETARDIO", b"RETARDIO on sui", b"Only degen retardio here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/retardio_logo_logo_1db41710fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

