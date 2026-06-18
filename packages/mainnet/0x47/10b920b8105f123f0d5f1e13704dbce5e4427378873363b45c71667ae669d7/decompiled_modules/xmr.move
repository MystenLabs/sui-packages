module 0x4710b920b8105f123f0d5f1e13704dbce5e4427378873363b45c71667ae669d7::xmr {
    struct XMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMR>(arg0, 6, b"XMR", b"Monero", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XMR>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XMR>>(v2);
    }

    // decompiled from Move bytecode v6
}

