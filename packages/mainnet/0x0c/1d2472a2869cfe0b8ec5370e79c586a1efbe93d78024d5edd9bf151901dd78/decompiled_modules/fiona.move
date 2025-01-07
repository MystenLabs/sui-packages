module 0xc1d2472a2869cfe0b8ec5370e79c586a1efbe93d78024d5edd9bf151901dd78::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 6, b"FIONA", b"FIONA SUI", b"The most famous hippo and the ambassador for her species. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731431041598.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIONA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

