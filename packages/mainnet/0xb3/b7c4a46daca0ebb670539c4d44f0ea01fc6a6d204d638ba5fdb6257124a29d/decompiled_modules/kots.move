module 0xb3b7c4a46daca0ebb670539c4d44f0ea01fc6a6d204d638ba5fdb6257124a29d::kots {
    struct KOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOTS>(arg0, 6, b"KOTS", b"King Of The Sea", b"Celebrating all the community for using movepump.com. This is a community fan token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_08_16_58_29_A_humorous_meme_style_image_titled_King_of_the_Sea_showing_an_overconfident_small_fish_wearing_a_crown_proudly_puffing_out_its_chest_as_it_floats_i_fab4b1848e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

