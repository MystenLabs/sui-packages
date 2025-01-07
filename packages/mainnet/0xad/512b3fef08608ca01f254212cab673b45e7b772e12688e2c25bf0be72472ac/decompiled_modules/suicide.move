module 0xad512b3fef08608ca01f254212cab673b45e7b772e12688e2c25bf0be72472ac::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUICIDE", b"Suicidal Fwog", b"This suicidal fwog just got rekt on his 100x long. He has now lost the will to live. We commemorate this coin to the suicidal fwog. He might be gone, but he lives on inside of us. Join the $SUICIDE gang now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUICIDE_pic_848eccdf99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

