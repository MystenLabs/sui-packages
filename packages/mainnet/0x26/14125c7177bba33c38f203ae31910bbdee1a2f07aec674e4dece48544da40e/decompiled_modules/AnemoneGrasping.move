module 0x2614125c7177bba33c38f203ae31910bbdee1a2f07aec674e4dece48544da40e::AnemoneGrasping {
    struct ANEMONEGRASPING has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANEMONEGRASPING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANEMONEGRASPING>(arg0, 0, b"COS", b"Anemone Grasping", b"Wrapped in the tentacles of Legba... unbound... become forever...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Anemone_Grasping.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANEMONEGRASPING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANEMONEGRASPING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

