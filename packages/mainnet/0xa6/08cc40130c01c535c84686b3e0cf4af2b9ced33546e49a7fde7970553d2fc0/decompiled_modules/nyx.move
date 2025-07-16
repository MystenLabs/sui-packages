module 0xa608cc40130c01c535c84686b3e0cf4af2b9ced33546e49a7fde7970553d2fc0::nyx {
    struct NYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYX>(arg0, 6, b"NYX", b"What should we name ", x"576861742073686f756c64207765206e616d65206f7572206d616c65200a4047726f6b0a20636f6d70616e696f6e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752690426262.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

