module 0xf0acb5caf46ede14177db0baf40a443761bc40153b3e5dd868a7e14437df2dfb::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"Pdog", b"Pdoge", b"PlayDoge is a mobile game that combines the beloved Tamagotchi virtual pet experience with the cutting-edge digital economy of cryptocurrency. Nurture your PlayDoge by feeding, entertaining, training, and ensuring it gets enough sleep. Dive into classic 8-bit side-scrolling adventures, relive the '90s nostalgia, and earn crypto along the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_6_a58d9c823c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

