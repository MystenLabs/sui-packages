module 0xf1b930bc0708bcb212a716281675a2147851566b8db516cb132922eb35767d2b::futor {
    struct FUTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTOR>(arg0, 6, b"FUTOR", b"FUCKGATOR", b"HOP FUCKKKK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_03_19_45_06_A_logo_for_a_memecoin_named_Fucktor_The_logo_should_be_humorous_playful_and_edgy_reflecting_the_fun_meme_like_nature_of_the_coin_Include_eleme_9c443ffaa3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

