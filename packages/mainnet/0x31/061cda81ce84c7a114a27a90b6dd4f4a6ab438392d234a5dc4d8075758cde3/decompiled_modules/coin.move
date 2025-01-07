module 0x31061cda81ce84c7a114a27a90b6dd4f4a6ab438392d234a5dc4d8075758cde3::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 6, b"WUSDC", b"WUSDC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::coin::mint_and_transfer<COIN>(&mut v2, 1000000000000000, @0x42617f619df21e21b1b71c0cbcd021198b748a01ed04dcaeb0a5e23b198a2d86, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

