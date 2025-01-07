module 0x142556a54944963eefecc0c9ad05b69f8fdd740c3c833b93f13fc3954176f128::hallow {
    struct HALLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOW>(arg0, 6, b"HALLOW", b"HallowKitty", b"Cute Halloween Kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_drawn_flat_halloween_cat_illustration_23_2149070335_adadec7f2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

