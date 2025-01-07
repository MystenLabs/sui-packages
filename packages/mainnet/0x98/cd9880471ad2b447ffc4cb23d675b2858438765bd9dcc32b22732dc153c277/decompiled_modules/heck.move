module 0x98cd9880471ad2b447ffc4cb23d675b2858438765bd9dcc32b22732dc153c277::heck {
    struct HECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HECK>(arg0, 6, b"HECK", b"The heck", b"The heck i just deploy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731402553267.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HECK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HECK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

