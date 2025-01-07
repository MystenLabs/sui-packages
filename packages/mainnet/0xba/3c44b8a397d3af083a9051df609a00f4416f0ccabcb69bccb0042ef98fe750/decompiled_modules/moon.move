module 0xba3c44b8a397d3af083a9051df609a00f4416f0ccabcb69bccb0042ef98fe750::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"MOON BAGS", b"Grab your bags and let's moon this! No jeets, if you have to sell for burger money, do it politely without killing this chart!  Dont be a douche.  Socials will come later while we duke it out on move pump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_22_15_54_53_A_poorly_drawn_money_bag_in_a_cartoonish_style_the_bag_is_blue_with_a_white_moon_illustration_on_its_side_The_design_should_look_amateurish_and_inte_dded2d16a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

