module 0x48b12f4241ff28262005c0d9642a8ef04069b061e4d1ed3f1512287a9eaaf7a1::mythicdrake {
    struct MYTHICDRAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYTHICDRAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742379356770.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<MYTHICDRAKE>(arg0, 6, b"MDR", b"MythicDrake", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYTHICDRAKE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYTHICDRAKE>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MYTHICDRAKE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYTHICDRAKE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

