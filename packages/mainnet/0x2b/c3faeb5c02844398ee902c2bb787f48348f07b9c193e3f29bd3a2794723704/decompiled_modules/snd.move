module 0x2bc3faeb5c02844398ee902c2bb787f48348f07b9c193e3f29bd3a2794723704::snd {
    struct SND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SND>(arg0, 6, b"SND", b"SantaDoge", b" Meet SantaDoge, the jolly meme token ready to bring festive cheer to your wallet! $SND is here to spread the holiday spirit with a cheerful Shiba Inu in a Santa hat, surrounded by Christmas magic like snowflakes, sparkling lights, and wrapped gifts. Get in on the fun before the season ends and join the Christmas crypto celebration!  Don't miss your chance to ride the holiday wave with $SND  the token that's as festive as your Christmas spirit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_27_18_57_40_A_playful_and_festive_cartoon_style_logo_featuring_a_Shiba_Inu_dog_wearing_a_red_Santa_Claus_hat_surrounded_by_Christmas_decorations_like_snowflakes_4467c33cae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SND>>(v1);
    }

    // decompiled from Move bytecode v6
}

