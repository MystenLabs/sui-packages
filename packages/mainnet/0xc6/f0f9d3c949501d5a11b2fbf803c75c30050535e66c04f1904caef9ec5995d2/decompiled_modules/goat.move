module 0xc6f0f9d3c949501d5a11b2fbf803c75c30050535e66c04f1904caef9ec5995d2::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"goat", x"54686520666972737420476f617473657573204d6178696d75732024474f4154206f6e2045544820636861696e2e4669727374204c50206275726e7420616e642072656e6f756e6365642024474f41542e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000355_eaecf36011.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

