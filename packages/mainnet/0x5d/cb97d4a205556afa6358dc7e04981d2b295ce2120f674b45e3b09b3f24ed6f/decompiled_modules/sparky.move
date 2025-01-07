module 0x5dcb97d4a205556afa6358dc7e04981d2b295ce2120f674b45e3b09b3f24ed6f::sparky {
    struct SPARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARKY>(arg0, 6, b"Sparky", b"Sparky Dog", b"Bringing the Spark back to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I3g_JQOO_9_400x400_4b40a5ba19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

