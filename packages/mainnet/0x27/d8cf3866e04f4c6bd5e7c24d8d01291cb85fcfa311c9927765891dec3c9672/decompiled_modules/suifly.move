module 0x27d8cf3866e04f4c6bd5e7c24d8d01291cb85fcfa311c9927765891dec3c9672::suifly {
    struct SUIFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLY>(arg0, 9, b"SFLY", b"SuiFly", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFLY>(&mut v2, 1000000000000000000, @0xc1762c4df529015b192bda161ae06f02d4851079ec00ed1696cf1bb57e15d23f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

