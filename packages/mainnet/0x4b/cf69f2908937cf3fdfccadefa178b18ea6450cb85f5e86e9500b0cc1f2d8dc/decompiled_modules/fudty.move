module 0x4bcf69f2908937cf3fdfccadefa178b18ea6450cb85f5e86e9500b0cc1f2d8dc::fudty {
    struct FUDTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDTY>(arg0, 9, b"FUDTY", b"FUDv2", b"FUDTY", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUDTY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

