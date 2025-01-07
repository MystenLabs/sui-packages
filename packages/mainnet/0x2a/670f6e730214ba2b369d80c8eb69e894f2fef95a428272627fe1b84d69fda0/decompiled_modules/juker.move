module 0x2a670f6e730214ba2b369d80c8eb69e894f2fef95a428272627fe1b84d69fda0::juker {
    struct JUKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUKER>(arg0, 9, b"JUKER", b"Sui Juker", x"476f7468756de2809973207269736964656e742063756d656469616e2c20706172742d74696d65206368616f7320656e74687573696173732e202068747470733a2f2f6a756b65722e70726f202068747470733a2f2f742e6d652f5375694a756b6572202068747470733a2f2f782e636f6d2f5375694a756b6572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUKER>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUKER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

