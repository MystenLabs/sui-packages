module 0x1ab82300130d0ba2025f30830d66358828679e4170d52c5e8489fc5abcba65ca::kappi {
    struct KAPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPI>(arg0, 9, b"KAPPI", b"KAPPI On Sui", x"4865792c2049e280996d204b617070692c20796f757220667269656e646c79204b617070612066726f6d204a6170616e65736520666f6c6b6c6f72652c206e6f77206368696c6c696e67206f6e207468652053554920626c6f636b636861696e2e20546869732074696d652c2049e28099766520676f7420736f6d657468696e67207370656369616c20666f7220796f7520e2809420244b415050492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.kappi.fun/_next/image?url=%2Flogo.jpg&w=2048&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAPPI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAPPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

