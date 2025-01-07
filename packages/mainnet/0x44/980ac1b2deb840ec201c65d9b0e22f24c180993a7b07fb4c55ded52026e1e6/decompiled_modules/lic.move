module 0x44980ac1b2deb840ec201c65d9b0e22f24c180993a7b07fb4c55ded52026e1e6::lic {
    struct LIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIC>(arg0, 6, b"LIC", b"Light Cat", b"Shine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/712827650327fdb6a1f5b7de677efbed_bc5f0f9f2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

