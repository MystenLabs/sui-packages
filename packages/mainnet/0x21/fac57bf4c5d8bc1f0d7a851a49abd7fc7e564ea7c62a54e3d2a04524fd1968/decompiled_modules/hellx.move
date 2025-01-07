module 0x21fac57bf4c5d8bc1f0d7a851a49abd7fc7e564ea7c62a54e3d2a04524fd1968::hellx {
    struct HELLX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLX>, arg1: 0x2::coin::Coin<HELLX>) {
        0x2::coin::burn<HELLX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HELLX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HELLX>>(0x2::coin::mint<HELLX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HELLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLX>(arg0, 6, b"Hellx", b"HELLX", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

