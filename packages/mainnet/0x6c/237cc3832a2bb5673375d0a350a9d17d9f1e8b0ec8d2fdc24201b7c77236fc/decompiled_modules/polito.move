module 0x6c237cc3832a2bb5673375d0a350a9d17d9f1e8b0ec8d2fdc24201b7c77236fc::polito {
    struct POLITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLITO>(arg0, 6, b"Polito", b"Polito on Sui", x"576f66776f66f09fa6b4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731589188042.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLITO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLITO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

