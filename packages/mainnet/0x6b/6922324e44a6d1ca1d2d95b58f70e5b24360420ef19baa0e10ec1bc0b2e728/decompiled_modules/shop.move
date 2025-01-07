module 0x6b6922324e44a6d1ca1d2d95b58f70e5b24360420ef19baa0e10ec1bc0b2e728::shop {
    struct SHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOP>(arg0, 6, b"SHOP", b"SUI Hop", b"SUI hop the sea. With U.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_HOP_f36b4482e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

