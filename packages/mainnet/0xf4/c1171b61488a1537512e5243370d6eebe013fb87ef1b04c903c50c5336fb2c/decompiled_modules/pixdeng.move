module 0xf4c1171b61488a1537512e5243370d6eebe013fb87ef1b04c903c50c5336fb2c::pixdeng {
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

