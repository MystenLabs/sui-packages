module 0x12e1f0b8b63bd4d9190f4c13d127886cdb5fabd497f316149ba604a9af2f6052::suisun {
    struct SUISUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUN>(arg0, 6, b"Suisun", b"SuiSun", b"Let the sun rise on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734954290902.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

