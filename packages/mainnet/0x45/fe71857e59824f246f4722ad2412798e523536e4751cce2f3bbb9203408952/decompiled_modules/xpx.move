module 0x45fe71857e59824f246f4722ad2412798e523536e4751cce2f3bbb9203408952::xpx {
    struct XPX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XPX>, arg1: 0x2::coin::Coin<XPX>) {
        0x2::coin::burn<XPX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XPX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XPX>>(0x2::coin::mint<XPX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPX>(arg0, 9, b"XPX", b"XPX", b"tester", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

