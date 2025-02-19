module 0x54c7f8e440fd71373cf1bc4b410b288a74db9d843eb0427d716aa846e9f6a5ab::hiroshi {
    struct HIROSHI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIROSHI>, arg1: 0x2::coin::Coin<HIROSHI>) {
        0x2::coin::burn<HIROSHI>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIROSHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HIROSHI>>(0x2::coin::mint<HIROSHI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HIROSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIROSHI>(arg0, 9, b"HIROSHI", b"HIROSHI", b"Not Reaching !!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIROSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIROSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

