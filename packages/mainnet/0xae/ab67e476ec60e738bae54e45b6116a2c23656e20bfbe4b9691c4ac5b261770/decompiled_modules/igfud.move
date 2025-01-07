module 0xaeab67e476ec60e738bae54e45b6116a2c23656e20bfbe4b9691c4ac5b261770::igfud {
    struct IGFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGFUD>(arg0, 6, b"IGFUD", b"Ignore Fud", b"Ignore Fud ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731144203106.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IGFUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGFUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

