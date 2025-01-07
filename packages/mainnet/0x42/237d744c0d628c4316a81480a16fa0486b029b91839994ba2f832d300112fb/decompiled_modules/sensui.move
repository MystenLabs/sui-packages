module 0x42237d744c0d628c4316a81480a16fa0486b029b91839994ba2f832d300112fb::sensui {
    struct SENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSUI>(arg0, 6, b"SENSUI", b"Sensui", b"The Blue Master", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_19_10_24_09_A_cartoon_style_kung_fu_sensei_in_the_style_of_Adventure_Time_keeping_a_playful_cartoonish_look_but_in_an_aggressive_martial_arts_stance_The_charac_ef51259289.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

