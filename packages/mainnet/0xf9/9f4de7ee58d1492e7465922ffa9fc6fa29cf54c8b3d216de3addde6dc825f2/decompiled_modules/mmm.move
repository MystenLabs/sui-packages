module 0xf99f4de7ee58d1492e7465922ffa9fc6fa29cf54c8b3d216de3addde6dc825f2::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 6, b"MMM", b"MonkeyManMIX", x"4974732074686520666972737420616e64206f6e6c7920224d495822206d656d6520696e2074686520756e6976657273652e0a497473206e6f74206120646f67202c206e6f74206120636174202c206e6f7420612068756d616e206f7220616e696d616c2e0a4974732053796d62696f746963206d6978206f6620616e696d616c20616e642068756d616e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731577452874.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

