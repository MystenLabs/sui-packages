module 0xbc071cc1f714d90f37d92bcf8e41b4b9cc8d2d07267caf0d2b61271580ff0de5::alethea {
    struct ALETHEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALETHEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALETHEA>(arg0, 6, b"ALETHEA", b"ALETHEA CUTE MERMAID", b"Bold, awesomatic, smart, cool, horny, playful, enjoying, QUEEN of the oceans, love water droplets. Even sharks has no chance against $ALETHEA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_13_52_56_fce292fd33.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALETHEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALETHEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

