module 0xc4f5b40aa349c4749a7bcdc4289779e663cc807e9293064e3e2220bf2d2a32d4::refecoin {
    struct REFECOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REFECOIN>, arg1: 0x2::coin::Coin<REFECOIN>) {
        0x2::coin::burn<REFECOIN>(arg0, arg1);
    }

    fun init(arg0: REFECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFECOIN>(arg0, 2, b"refe Coin", b"RC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REFECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REFECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REFECOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

