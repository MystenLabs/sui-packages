module 0xfdf11e6a535a7ebc9ee7eb52c05cd6ce06045c16b7f6aa229e28adf475557077::aimaya {
    struct AIMAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIMAYA>(arg0, 6, b"AIMAYA", b"MayaAI by SuiAI", b"Maya AI - It's flawless, the best assistant for everything. Maya can help you in your most difficult cases, as well as give you a huge amount of emotions.With Maya AI you won't get bored!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Leonardo_Diffusion_XL_girl_with_pink_hair_beautiful_cute_face_0_0b183a9d39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIMAYA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMAYA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

