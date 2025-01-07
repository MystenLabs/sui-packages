module 0x6182f7a61b22b7f46ea314ac1e14f2d4b45dbb9a1d9c52597a06fcecd744d97e::yoink {
    struct YOINK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YOINK>, arg1: 0x2::coin::Coin<YOINK>) {
        0x2::coin::burn<YOINK>(arg0, arg1);
    }

    fun init(arg0: YOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOINK>(arg0, 2, b"YOINK", b"Yoink Token", b"Yoink! Yoink! Yoink! Yoink! Yoink! Yoink! Yoink! Yoink!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOINK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YOINK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

