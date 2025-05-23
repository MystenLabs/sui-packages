module 0xfa494f7d4508c088cb191a4b5e7400998e06400d22a52e5ef53b8b357fbdc90e::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 6, b"MSTR", b"STRATEGY", b"SUI STRATEGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747971140794.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

