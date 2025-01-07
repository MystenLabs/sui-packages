module 0xa460e490b4c1e6f586e6fa1751d22ed38b0a7b6abc2772383129619a7e663301::booby {
    struct BOOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBY>(arg0, 6, b"BOOBY", b"Blue-Footed Booby", b"Blue-Footed Booby on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Zffrk65_400x400_955878c0c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

