module 0xef8b56a5c4b9fd814693e223fdbc22522f75af02a5b3d6c133c8e2d39406f945::wld {
    struct WLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLD>(arg0, 9, b"WLD", b"Wrapped Worldcoin", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WLD>>(v0);
    }

    // decompiled from Move bytecode v6
}

