module 0x316f5cd6d62b4bce3435834db20ef67752963c85f5f1cc8fe15561b0bd58ba74::turbomat {
    struct TURBOMAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOMAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOMAT>(arg0, 6, b"TURBOMAT", b"TURBO MAT DOG", b"The original Matsui TURBO DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987732312.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOMAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOMAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

