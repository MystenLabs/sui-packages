module 0x546c3592f436e38e93a84f48fe0597dd59a987f639a089f3091669a38e2e6849::suiracha {
    struct SUIRACHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRACHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRACHA>(arg0, 6, b"SUIRACHA", b"Suiracha", b"The hottest sauce on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3379_f466e752b2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRACHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRACHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

