module 0x3dd972fdc3dd1fc19a625365c6857e9fcfd98c4ec2d36efc929e622bd6cf41b9::pt {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT>(arg0, 9, b"PT-nevLP-suiUSDT-USDC-20250827", b"PT-nevLP-suiUSDT-USDC-20250827", b"PT-nevLP-suiUSDT-USDC-20250827", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/ptTokenMmtsuiUsdtUsdc.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

