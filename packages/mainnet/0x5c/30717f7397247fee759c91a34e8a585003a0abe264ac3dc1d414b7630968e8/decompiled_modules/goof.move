module 0x5c30717f7397247fee759c91a34e8a585003a0abe264ac3dc1d414b7630968e8::goof {
    struct GOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOF>(arg0, 6, b"GOOF", b"Goofy sui", x"546865206772656174657374206669736865726d616e206f6620746865200a407375696e6574776f726b0a206f6365616e2072647920746f2024474f4f462020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goof_f14dba4db2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

