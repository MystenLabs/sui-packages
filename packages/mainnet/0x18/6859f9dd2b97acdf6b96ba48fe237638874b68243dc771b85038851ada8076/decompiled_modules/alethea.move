module 0x186859f9dd2b97acdf6b96ba48fe237638874b68243dc771b85038851ada8076::alethea {
    struct ALETHEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALETHEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALETHEA>(arg0, 6, b"ALETHEA", b"ALETHEA CUTE MERMAID", x"414c4554484541205448452043555445204d41524d414944204f4e20535549204e4554574f524b21200a524541445920544f20424520544845204d455441", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_13_52_56_4c7b0a2503.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALETHEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALETHEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

