module 0xeec42196a01cb14320680e1ef4e6833a0c195e19d2ab85a5f89541b4e93f5af4::sr5 {
    struct SR5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR5>(arg0, 9, b"SR5", b"jy5te", b"j76", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/afddf119c3e98a2ecf39de80f01cbe89blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SR5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

