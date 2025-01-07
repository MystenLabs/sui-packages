module 0x55c3a6dec8ecbbe52c416611c3df218343f78db0698a6bdb27b1aa7bb49f7248::unidog {
    struct UNIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIDOG>(arg0, 6, b"UNIDOG", b"Unidog", b"Its a Dog, its a Unicorn--nope, its a Unidog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_22_121007_fb6fb5f081.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

