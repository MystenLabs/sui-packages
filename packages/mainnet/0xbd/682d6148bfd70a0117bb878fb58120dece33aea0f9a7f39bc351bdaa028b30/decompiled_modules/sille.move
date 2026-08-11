module 0xbd682d6148bfd70a0117bb878fb58120dece33aea0f9a7f39bc351bdaa028b30::sille {
    struct SILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLE>(arg0, 6, b"SILLE", x"53696c6cc3a920536e61636b73", b"Silie as she goes lads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1786427077046.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

