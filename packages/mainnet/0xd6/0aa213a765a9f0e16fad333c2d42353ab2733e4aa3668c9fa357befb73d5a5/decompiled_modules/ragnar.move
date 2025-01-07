module 0xd60aa213a765a9f0e16fad333c2d42353ab2733e4aa3668c9fa357befb73d5a5::ragnar {
    struct RAGNAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGNAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGNAR>(arg0, 6, b"Ragnar", b"RagnarCatSui", b"A weed addict cat coming to sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731686059879.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAGNAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGNAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

