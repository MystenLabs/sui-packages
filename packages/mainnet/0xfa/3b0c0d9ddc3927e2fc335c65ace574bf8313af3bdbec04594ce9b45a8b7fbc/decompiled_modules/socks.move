module 0xfa3b0c0d9ddc3927e2fc335c65ace574bf8313af3bdbec04594ce9b45a8b7fbc::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 6, b"SOCKS", b"Ai Santa Socks", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOCKS>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOCKS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SOCKS>>(v2);
    }

    // decompiled from Move bytecode v6
}

