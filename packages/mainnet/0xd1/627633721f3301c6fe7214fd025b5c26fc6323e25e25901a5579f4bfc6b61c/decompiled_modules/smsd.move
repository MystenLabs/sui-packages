module 0xd1627633721f3301c6fe7214fd025b5c26fc6323e25e25901a5579f4bfc6b61c::smsd {
    struct SMSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMSD>(arg0, 6, b"SMSD", b"sorrymomsorrydad", b"Just a coin to remind us how we failed our parents ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1756508404599.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

