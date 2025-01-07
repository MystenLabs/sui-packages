module 0x547a69d797dab92be3452f2dc36d72a2bf9ce92875ca7e3b528fbd4db9853971::MistdashWings {
    struct MISTDASHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTDASHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTDASHWINGS>(arg0, 0, b"COS", b"Mistdash Wings", b"The Valley plunges through you... even as you ascend...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Mistdash_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MISTDASHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTDASHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

