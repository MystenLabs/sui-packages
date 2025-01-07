module 0xc07e87c3f7049c3ce62e2a3d1551bac4601081656a6636c18d6c17e7b81037fa::mwoo {
    struct MWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWOO>(arg0, 6, b"MWOO", b"Mwoo Deng on Sui", b"I am Mwoo Deng. I bet you have heard about me already.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tu_Zgo_Wo_X_400x400_a3d913849b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

