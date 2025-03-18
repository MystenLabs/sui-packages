module 0xced8dfd89ac32dd9ad5356455b8bca9a6e0b32d143ab61a1a6899d0e980782f8::pumptoken {
    struct PUMPTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742294313021.avif"));
        let (v1, v2) = 0x2::coin::create_currency<PUMPTOKEN>(arg0, 6, b"PT", b"PumpToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<PUMPTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMPTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

