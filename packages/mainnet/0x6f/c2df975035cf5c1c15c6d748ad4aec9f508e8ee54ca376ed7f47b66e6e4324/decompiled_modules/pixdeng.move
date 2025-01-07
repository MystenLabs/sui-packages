module 0x6fc2df975035cf5c1c15c6d748ad4aec9f508e8ee54ca376ed7f47b66e6e4324::pixdeng {
    struct PIXDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXDENG>(arg0, 6, b"PixDeng", b"PIXEL MOO DENG", b"Pixel Moo Deng makes a grand entrance into the world of Sui Network, strapping on its dollar-fueled rocket... and aims straight for the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_nh_cha_p_m_A_n_h_A_nh_2024_10_07_213302_0972d2b15e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

