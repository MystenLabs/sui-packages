module 0x3d8bad06ecb38b25005fa9ef09095d41df7ef171d30ca70b0ce8ce629c5971ca::suimen {
    struct SUIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEN>(arg0, 6, b"SUIMEN", b"Suimen", b"Semen + SUI = $SUIMEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sperm_1x1_69518f9031.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

