module 0xf9910ab955f1b5f0ebad6101b4d75603569468abcfeae4348c5c47d5f2e89503::USDTS {
    struct USDTS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDTS>, arg1: 0x2::coin::Coin<USDTS>) {
        0x2::coin::burn<USDTS>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDTS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDTS>>(0x2::coin::mint<USDTS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTS>(arg0, 9, b"USDT", b"USDT", b"DATA TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/F4KH86XW/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

