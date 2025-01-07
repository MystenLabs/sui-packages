module 0x5901f42550c8cd6bbc32834e988ae50b1277248d46f142ad8fdb3f453ce4fe3c::zbr {
    struct ZBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZBR>(arg0, 9, b"ZBR", b"Zebra", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZBR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZBR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

