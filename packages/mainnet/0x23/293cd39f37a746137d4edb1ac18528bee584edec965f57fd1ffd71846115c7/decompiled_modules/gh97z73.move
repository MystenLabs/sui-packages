module 0x23293cd39f37a746137d4edb1ac18528bee584edec965f57fd1ffd71846115c7::gh97z73 {
    struct GH97Z73 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GH97Z73, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GH97Z73>(arg0, 0, b"GH97Z73", b"Sui Blue Gift Owner H97Z73", b"Sui Blue Gift mainnet Gift owner smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GH97Z73>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GH97Z73>>(0x2::coin::mint<GH97Z73>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GH97Z73>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

