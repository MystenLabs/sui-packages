module 0x327852069fb6a29af9be2596dc55a9054b48c3f861c89f2b6cb9ffc4fdb51dd4::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISM>(arg0, 6, b"TISM", b"TISM on Turbos", b"Please be patient I have $TISM ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731076245708.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TISM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

