module 0xca3163f5b15ce214595ad22d478197482ccbb70d3e3b34678720b82be62bcf88::poppump {
    struct POPPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPUMP>(arg0, 6, b"Poppump", b"Poppump ", b"MARKET IS PUMPING.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953217019.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPPUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

