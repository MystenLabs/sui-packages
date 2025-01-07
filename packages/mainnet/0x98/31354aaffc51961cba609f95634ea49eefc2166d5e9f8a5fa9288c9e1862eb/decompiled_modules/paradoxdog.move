module 0x9831354aaffc51961cba609f95634ea49eefc2166d5e9f8a5fa9288c9e1862eb::paradoxdog {
    struct PARADOXDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARADOXDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARADOXDOG>(arg0, 6, b"Paradoxdog", b"PARADOX D09", b"paradox dog d09", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rgrrtbgrgrt_6227bead70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARADOXDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARADOXDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

