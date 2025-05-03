module 0x3840e32a59d167cda1fdc0af97a96e8fac54864b901472db0ad21599f0ae72b::xpp {
    struct XPP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XPP>, arg1: 0x2::coin::Coin<XPP>) {
        0x2::coin::burn<XPP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XPP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XPP>>(0x2::coin::mint<XPP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPP>(arg0, 9, b"XPP", b"XPP", b"XPP is the test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

