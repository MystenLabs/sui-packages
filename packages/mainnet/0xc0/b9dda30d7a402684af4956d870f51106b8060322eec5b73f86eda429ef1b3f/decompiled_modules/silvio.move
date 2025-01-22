module 0xc0b9dda30d7a402684af4956d870f51106b8060322eec5b73f86eda429ef1b3f::silvio {
    struct SILVIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILVIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILVIO>(arg0, 6, b"SILVIO", b"Silvio AI Berlusconi", b"Former italian prime minister in your pocket, will be your mentor and is going to make you a milionaire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737579068710.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILVIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILVIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

