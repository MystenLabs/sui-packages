module 0x62f76a9cdfdc8026fc467a7323fa2b5acd8223a2fb4c6fd03ffead471be00d39::suiden {
    struct SUIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEN>(arg0, 6, b"SUIDEN", b"Suiden", b"In the enchanting land of Suiden, where the northern lights danced across the sky and the vast forests whispered ancient secrets, there lived a young girl named Elin. She had always been fascinated by the stories her grandmother told her about the mythical creatures that roamed the woodselves, trolls, and the elusive frost giants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_25_at_19_37_21_5b8ed35bb8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

