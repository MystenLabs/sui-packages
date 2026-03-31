module 0x146ad82c83967a350ddeb930860b0338362b22bb51fcd91461923f060597b88f::spear {
    struct SPEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEAR>(arg0, 6, b"SPEAR", b"Spear Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPEAR>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEAR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPEAR>>(v2);
    }

    // decompiled from Move bytecode v6
}

