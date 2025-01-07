module 0x891e3e41c8cbff8b4d4c0fe6770e19a140cebc30993a00e93bcaf7758b584b20::suipred {
    struct SUIPRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRED>(arg0, 6, b"SUIPRED", b"Predator", b"HES ON THE HUNT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_2_U4_Muaw_AA_6sce_9fadf724c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

