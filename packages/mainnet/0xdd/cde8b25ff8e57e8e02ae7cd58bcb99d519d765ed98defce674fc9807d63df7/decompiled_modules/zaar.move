module 0xddcde8b25ff8e57e8e02ae7cd58bcb99d519d765ed98defce674fc9807d63df7::zaar {
    struct ZAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAAR>(arg0, 6, b"ZAAR", b"ORDZAAR", b"A simple & permissionless way for artists to launch on #Ordinals ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RE_SEP_02_551bf6a80c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

