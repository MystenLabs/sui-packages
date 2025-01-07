module 0xc8571ec218f0b665cfcb7b7052c128503d0b191b070b27ad5fe91eca939a4c5e::pigo {
    struct PIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGO>(arg0, 6, b"PIGO", b"PIGEonSUI", x"5049474f20546f6b656e3a204120706967656f6e2d696e7370697265642063727970746f63757272656e6379206f6e205375692c206275696c7420666f722073696d706c696369747920616e6420636f6d6d756e6974792e20466c792068696768776974685069676f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_140233_489_70115a74f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

