module 0x2fe319c13bd523c0a73d2af5827f9924eba4d79fe01cad9f217ba3e9d19cc5cb::pt {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT>(arg0, 9, b"PT-nevLP-suiUSDT-USDC-20250820", b"PT-nevLP-suiUSDT-USDC-20250820", b"PT-nevLP-suiUSDT-USDC-20250820", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/ptTokenMmtsuiUsdtUsdc.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

