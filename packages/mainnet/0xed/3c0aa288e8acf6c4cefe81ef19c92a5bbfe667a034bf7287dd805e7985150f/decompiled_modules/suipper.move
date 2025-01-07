module 0xed3c0aa288e8acf6c4cefe81ef19c92a5bbfe667a034bf7287dd805e7985150f::suipper {
    struct SUIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SUIPPER>(arg0, 0, b"$SUIP", b"SUIPPER", b"I'm tired of all the f**cking rugs, suipper no swipping!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPPER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPPER>>(0x2::coin::mint<SUIPPER>(&mut v3, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPPER>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SUIPPER>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

