module 0x32dda096b428496a6e08d7120656b81d0c1669f914e9656d17a9b06b8985a3f1::tiffany {
    struct TIFFANY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIFFANY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TIFFANY>(arg0, 6, b"TIFFANY", b"Tiffany Trump by SuiAI", b"Join the community. This is history in the making under Suai.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0097_3c2cedff5c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TIFFANY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIFFANY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

