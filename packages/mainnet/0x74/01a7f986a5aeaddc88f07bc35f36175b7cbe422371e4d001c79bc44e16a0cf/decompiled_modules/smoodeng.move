module 0x7401a7f986a5aeaddc88f07bc35f36175b7cbe422371e4d001c79bc44e16a0cf::smoodeng {
    struct SMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOODENG>(arg0, 6, b"Smoodeng", b"SUIMOODENG", b"SUI Moo Deng makes a grand entrance into the world of Sui Network, strapping on its dollar-fueled rocket... and aims straight for the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_nh_cha_p_m_A_n_h_A_nh_2024_10_07_102552_de97d57a78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

