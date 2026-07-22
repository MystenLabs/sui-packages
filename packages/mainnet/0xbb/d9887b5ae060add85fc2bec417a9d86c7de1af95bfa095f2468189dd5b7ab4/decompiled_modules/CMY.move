module 0xbbd9887b5ae060add85fc2bec417a9d86c7de1af95bfa095f2468189dd5b7ab4::CMY {
    struct CMY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CMY>, arg1: 0x2::coin::Coin<CMY>) {
        0x2::coin::burn<CMY>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CMY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CMY>>(0x2::coin::mint<CMY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMY>(arg0, 4, b"CMY", b"Cognitive Machine Yield", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/cmy_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

