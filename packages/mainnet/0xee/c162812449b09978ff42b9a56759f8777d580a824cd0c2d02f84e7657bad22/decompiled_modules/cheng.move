module 0xeec162812449b09978ff42b9a56759f8777d580a824cd0c2d02f84e7657bad22::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 6, b"CHENG", b"Evan Cheng the Founder", b"Meet the man behind it all, The Founder of Sui Network, Evan $CHENG. Tribute to the genius who made Sui unstoppable. We will honor Evans vision and take $CHENG to the next level, just like he did with Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_UPA_Revival_art_style_thick_lines_cartoon_design_of_an_40d20f4d_8a89_4f1e_9941_072c5bca090b_ae4748d9c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

