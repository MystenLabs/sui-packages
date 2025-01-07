module 0x585f547ca1562a77a0f82e500c521c5445105a44ad718c1b068257e5ca777e31::mspc {
    struct MSPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSPC>(arg0, 6, b"MSPC", b"MEOWSPACESUI", x"436861742061626f757420796f7572206661766f7269746520636174732c2063617420636f696e7320616e642066656c696e6520667269656e64730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bawl_a464f03618.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

