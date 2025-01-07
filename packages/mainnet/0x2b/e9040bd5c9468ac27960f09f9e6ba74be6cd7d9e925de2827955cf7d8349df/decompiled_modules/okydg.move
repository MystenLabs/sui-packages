module 0x2be9040bd5c9468ac27960f09f9e6ba74be6cd7d9e925de2827955cf7d8349df::okydg {
    struct OKYDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKYDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKYDG>(arg0, 6, b"OKYDG", b"OKAY DOG", b"okay dog on sui woooooooooooooof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731719974165.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKYDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKYDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

