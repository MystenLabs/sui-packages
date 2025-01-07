module 0x42a407c31da67e9197c0c20dddec3341b628734074599a639a30bc7cc97591eb::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEAN>(arg0, 6, b"OCEAN", b"Ocean Family", b"We are all is family ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ocean_family_light_blue_theme_e3136ed0c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

