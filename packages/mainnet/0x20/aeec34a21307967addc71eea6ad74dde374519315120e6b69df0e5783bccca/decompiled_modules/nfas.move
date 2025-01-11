module 0x20aeec34a21307967addc71eea6ad74dde374519315120e6b69df0e5783bccca::nfas {
    struct NFAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFAS>(arg0, 6, b"NFAs", b"Not a Financial Advice", b"Do not buy this token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3074_2a691c35c9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

