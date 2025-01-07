module 0x41022a2f773920f6e4be671145ca2651a31e27ab7e53c434ccf06f7265c16d49::cirmons {
    struct CIRMONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIRMONS>(arg0, 6, b"CIRMONS", b"Cirmons On Sui", b"The most adorable miniature monster on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LMHRO_Yiv_400x400_005099f854.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRMONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIRMONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

