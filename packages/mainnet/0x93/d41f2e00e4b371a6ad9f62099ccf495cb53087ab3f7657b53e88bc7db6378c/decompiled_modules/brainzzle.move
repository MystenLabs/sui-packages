module 0x93d41f2e00e4b371a6ad9f62099ccf495cb53087ab3f7657b53e88bc7db6378c::brainzzle {
    struct BRAINZZLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINZZLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BRAINZZLE>(arg0, 6, b"BRAINZZLE", b"Brainzzle by SuiAI", b"Initializing.....Systems online", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cerebro_d29f3a9fb4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAINZZLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINZZLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

