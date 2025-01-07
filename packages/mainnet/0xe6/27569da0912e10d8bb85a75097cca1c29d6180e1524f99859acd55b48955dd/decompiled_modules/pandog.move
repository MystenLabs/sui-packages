module 0xe627569da0912e10d8bb85a75097cca1c29d6180e1524f99859acd55b48955dd::pandog {
    struct PANDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDOG>(arg0, 6, b"Pandog", b"Panda Dog", b"The funny Panda dog (mini pandas) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2172_4f40f0e88a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

