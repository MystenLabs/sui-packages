module 0xd0c2c3f7a4ae8240dce807d61868ae6d6ea253f1b7bf6ef93646a5980cbc1d51::mcquuen {
    struct MCQUUEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCQUUEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCQUUEN>(arg0, 6, b"MCQUUEN", b"MCQUEEN", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950574937.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCQUUEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCQUUEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

