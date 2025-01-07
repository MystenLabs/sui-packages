module 0x8e9f4eb4f89ecef23d5be5652782a48ab82b445c33b1e22ce2b958a1e211c357::lucy {
    struct LUCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCY>(arg0, 6, b"LUCY", b"LUCY with QUANT", b"It's dinner time for $LUCY ! After a nice rug pull, $QUANT is proud to feed Lucy with some caviar and champagne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc3hw_RB_Ws_AAK_0l_N_a617520585.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

