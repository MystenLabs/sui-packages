module 0x3953cd92a83be533ec8123b5e739a53f68aa110a9706edc2440e59f5e711d783::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"Sui Season", b"Sui Season has arrived! Get ready to ride the wave, because next stop is PumpTober!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_26_21_46_42_A_cartoon_drawing_of_a_Sui_token_with_a_fun_and_meme_like_appearance_The_token_has_big_cartoonish_eyes_and_a_wide_cheeky_grin_to_give_it_personalit_5441a876f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

