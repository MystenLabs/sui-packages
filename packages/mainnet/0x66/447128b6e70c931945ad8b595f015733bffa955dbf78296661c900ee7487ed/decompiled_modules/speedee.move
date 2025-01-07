module 0x66447128b6e70c931945ad8b595f015733bffa955dbf78296661c900ee7487ed::speedee {
    struct SPEEDEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDEE>(arg0, 6, b"SPEEDEE", b"McDonald's Mascot", b"DYK that McDonald's original mascot was named Speedee?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732030498877.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEEDEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

