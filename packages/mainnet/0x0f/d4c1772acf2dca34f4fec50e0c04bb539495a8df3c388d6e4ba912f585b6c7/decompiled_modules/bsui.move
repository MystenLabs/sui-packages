module 0xfd4c1772acf2dca34f4fec50e0c04bb539495a8df3c388d6e4ba912f585b6c7::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"Bullish SUI", b"Skyrocket SUI into new ATH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_candle_fa594da384.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

