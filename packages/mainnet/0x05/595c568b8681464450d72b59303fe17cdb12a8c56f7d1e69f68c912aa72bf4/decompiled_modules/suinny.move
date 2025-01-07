module 0x5595c568b8681464450d72b59303fe17cdb12a8c56f7d1e69f68c912aa72bf4::suinny {
    struct SUINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINNY>(arg0, 6, b"SUINNY", b"Suinny The Sun", b"$SUINNY is a token that embodies the unstoppable energy of a blue sun, radiating innovation and growth on the SUI network. Just like the sun never stops shining, $SUINNY is a force of nature in the crypto world, bringing light to new opportunities and warming up your portfolio with bright prospects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_04_05_13_28_A_cartoon_style_blue_sun_character_with_a_friendly_smile_large_eyes_and_rays_of_light_emanating_from_its_head_like_sunbeams_The_character_has_a_pla_3b76a24dd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

