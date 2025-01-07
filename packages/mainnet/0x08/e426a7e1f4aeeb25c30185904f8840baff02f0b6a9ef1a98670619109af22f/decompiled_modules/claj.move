module 0x8e426a7e1f4aeeb25c30185904f8840baff02f0b6a9ef1a98670619109af22f::claj {
    struct CLAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAJ>(arg0, 6, b"CLAJ", b"Jolina Angelie is Cora Loft is pure", b"This is the story of a powerful woman whose beauty emanated from her namesake and strength from the life she lived.  She's a survivor and now comes back digitally with a twist to her name and her story.  If you are inspired by bad ass women who are afraid of no man then this is your meme.   If she can find a few followers she'll be around for a long time. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/encrypto8965_Skyscrapers_in_the_background_low_opacity_cyberp_05883ab1_ee09_48f0_b254_8c15c44aecc5_1_b800ff4244.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

