module 0x862b3a5a86b83fb1fa4db469c79cb27b5bc08bacd489854b55d1457e9c58762b::mrbeast {
    struct MRBEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRBEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRBEAST>(arg0, 6, b"MRBEAST", b"MR BEAST", b"MR BEAST ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mr_beast_logo_94d8234fed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRBEAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRBEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

