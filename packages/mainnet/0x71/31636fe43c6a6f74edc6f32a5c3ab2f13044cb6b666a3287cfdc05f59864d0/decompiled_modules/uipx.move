module 0x7131636fe43c6a6f74edc6f32a5c3ab2f13044cb6b666a3287cfdc05f59864d0::uipx {
    struct UIPX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UIPX>, arg1: 0x2::coin::Coin<UIPX>) {
        0x2::coin::burn<UIPX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UIPX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UIPX>>(0x2::coin::mint<UIPX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: UIPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UIPX>(arg0, 9, b"UIPX", b"UIPX", b"TESTING", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UIPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UIPX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

