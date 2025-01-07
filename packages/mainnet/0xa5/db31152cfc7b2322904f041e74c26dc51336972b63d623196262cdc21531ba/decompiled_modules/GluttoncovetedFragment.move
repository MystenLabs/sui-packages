module 0xa5db31152cfc7b2322904f041e74c26dc51336972b63d623196262cdc21531ba::GluttoncovetedFragment {
    struct GLUTTONCOVETEDFRAGMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUTTONCOVETEDFRAGMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUTTONCOVETEDFRAGMENT>(arg0, 0, b"COS", b"Gluttoncoveted Fragment", b"They can smell it... a taste of Aurah... inside...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Gluttoncoveted_Fragment.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLUTTONCOVETEDFRAGMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUTTONCOVETEDFRAGMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

