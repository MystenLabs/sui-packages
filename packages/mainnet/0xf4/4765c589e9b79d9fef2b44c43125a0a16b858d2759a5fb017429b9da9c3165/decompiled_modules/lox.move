module 0xf44765c589e9b79d9fef2b44c43125a0a16b858d2759a5fb017429b9da9c3165::lox {
    struct LOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOX>(arg0, 9, b"LOX", b"LOX", b"LOX Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOX>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

