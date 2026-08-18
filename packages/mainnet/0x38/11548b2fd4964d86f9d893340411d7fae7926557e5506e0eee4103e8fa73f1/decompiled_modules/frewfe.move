module 0x3811548b2fd4964d86f9d893340411d7fae7926557e5506e0eee4103e8fa73f1::frewfe {
    struct FREWFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREWFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREWFE>(arg0, 6, b"FREWFE", b"wfee", b"fwrf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREWFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREWFE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

