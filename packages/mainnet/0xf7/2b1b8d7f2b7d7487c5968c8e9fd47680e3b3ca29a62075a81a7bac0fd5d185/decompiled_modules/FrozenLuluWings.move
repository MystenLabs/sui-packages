module 0xf72b1b8d7f2b7d7487c5968c8e9fd47680e3b3ca29a62075a81a7bac0fd5d185::FrozenLuluWings {
    struct FROZENLULUWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZENLULUWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROZENLULUWINGS>(arg0, 0, b"COS", b"Frozen LuluWings", b"When not used for flight, they make for excellent snow shovels.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Frozen_LuluWings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROZENLULUWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROZENLULUWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

