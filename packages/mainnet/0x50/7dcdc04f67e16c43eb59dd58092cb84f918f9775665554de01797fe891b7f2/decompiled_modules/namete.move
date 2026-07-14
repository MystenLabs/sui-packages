module 0x507dcdc04f67e16c43eb59dd58092cb84f918f9775665554de01797fe891b7f2::namete {
    struct NAMETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMETE>(arg0, 6, b"NAMETE", b"name test", b"name test name test name test ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784018652457.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMETE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMETE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

