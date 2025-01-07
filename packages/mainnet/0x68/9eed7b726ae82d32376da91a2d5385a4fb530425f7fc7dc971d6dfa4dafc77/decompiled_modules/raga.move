module 0x689eed7b726ae82d32376da91a2d5385a4fb530425f7fc7dc971d6dfa4dafc77::raga {
    struct RAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGA>(arg0, 6, b"RAGA", b"Remake America Great Again", b"ReMake America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fotor_ai_2024110116057_71107769c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

