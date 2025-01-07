module 0x3f54c82720f508cbde392e2e425ec1a457dda8be8da467a60cb751b55cd36af9::seiro {
    struct SEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEIRO>(arg0, 6, b"SEIRO", b"Seiro", b"ahhsjskala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731328872144.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEIRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEIRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

