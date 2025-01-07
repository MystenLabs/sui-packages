module 0xf2ab43e11eef270c2862b0e688b6ea6107f14626093b556a5984daea659f576a::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SUID>(arg0, 6, b"SUID", b"Sui Do It", b"Just Sui Do It! A motivational meme coin for those ready to take risks without overthinking. Let's get rich or laugh trying!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_05_19_13_52_A_humorous_and_motivational_meme_coin_design_with_the_slogan_Just_Sui_Do_It_in_a_bold_and_catchy_style_The_visual_should_include_a_cartoon_charact_179bac05db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SUID>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v2);
    }

    // decompiled from Move bytecode v6
}

