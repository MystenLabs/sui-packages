module 0x7065e177721e20522ad5f5548329785f1f645bade082d88cb91f55aa4e62cffc::tsts {
    struct TSTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTS>(arg0, 6, b"TSTS", b"test ", b"dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763375430917.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

