module 0xe7137185e7f9702852cb150715ac605874f30daf442e078682f6b853d3e84361::ottie {
    struct OTTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTIE>(arg0, 6, b"OTTIE", b"OTTIE SUI", b"Official $OTTIE on turbos finance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969160584.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

