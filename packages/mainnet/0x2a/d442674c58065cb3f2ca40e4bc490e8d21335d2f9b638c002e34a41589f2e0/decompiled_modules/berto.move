module 0x2ad442674c58065cb3f2ca40e4bc490e8d21335d2f9b638c002e34a41589f2e0::berto {
    struct BERTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERTO>(arg0, 6, b"BERTO", b"Berto King", b"We the best!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731922761179.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BERTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

