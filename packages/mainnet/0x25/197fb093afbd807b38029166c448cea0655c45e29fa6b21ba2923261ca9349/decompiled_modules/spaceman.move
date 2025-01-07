module 0x25197fb093afbd807b38029166c448cea0655c45e29fa6b21ba2923261ca9349::spaceman {
    struct SPACEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEMAN>(arg0, 6, b"SPACEMAN", b"Spaceman Spiff", b"The fearless Spaceman Spiff, interplanetaryblockchain, explorer extraordinaire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735053734508.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACEMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

