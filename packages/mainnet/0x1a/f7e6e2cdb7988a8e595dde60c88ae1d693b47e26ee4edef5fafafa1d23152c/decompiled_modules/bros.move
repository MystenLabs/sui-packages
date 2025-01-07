module 0x1af7e6e2cdb7988a8e595dde60c88ae1d693b47e26ee4edef5fafafa1d23152c::bros {
    struct BROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROS>(arg0, 6, b"Bros", b"bros", b"Bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731083816279.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

