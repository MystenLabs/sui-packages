module 0xd39a71378465bf0f71e3c747b41f27b622a4c84a94ba3a2e4961e227aea186a1::tina {
    struct TINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINA>(arg0, 6, b"TINA", b"Tina Cheng", b"Dedicated to Tina Cheng, managing partner at Cherubic Ventures and a blockchain enthusiast.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tina_Cheng_Coin_e070a8781d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

