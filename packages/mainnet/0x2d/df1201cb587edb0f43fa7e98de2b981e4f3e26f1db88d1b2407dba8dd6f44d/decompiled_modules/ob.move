module 0x2ddf1201cb587edb0f43fa7e98de2b981e4f3e26f1db88d1b2407dba8dd6f44d::ob {
    struct OB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OB>(arg0, 6, b"OB", b"OctoBull", b"make it and forget it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032659_778876b65e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OB>>(v1);
    }

    // decompiled from Move bytecode v6
}

