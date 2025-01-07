module 0x47e364cc9a71ab5f55071574ca9d4ea9e8399a67082e478f9440c913eaf728e0::tiger {
    struct TIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGER>(arg0, 6, b"TIGER", b"TIGER SUI", b"Official X of $TIGER  the first meme token on SUI with real utility ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tn6v9_Lm_K_400x400_5ae590b7ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

