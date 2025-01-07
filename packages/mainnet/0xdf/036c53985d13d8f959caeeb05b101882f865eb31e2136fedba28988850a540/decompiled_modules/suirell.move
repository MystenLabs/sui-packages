module 0xdf036c53985d13d8f959caeeb05b101882f865eb31e2136fedba28988850a540::suirell {
    struct SUIRELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRELL>(arg0, 6, b"SUIRELL", b"Suirrel", b"Suirrel is the Official 'Unofficial' Mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_fix_bcdbcf938c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

