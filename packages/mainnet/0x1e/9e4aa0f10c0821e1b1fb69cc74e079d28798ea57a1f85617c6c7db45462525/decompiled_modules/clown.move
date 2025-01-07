module 0x1e9e4aa0f10c0821e1b1fb69cc74e079d28798ea57a1f85617c6c7db45462525::clown {
    struct CLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWN>(arg0, 6, b"CLOWN", b"CLOWN SUI", b"Clown on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004628_77c84076cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

