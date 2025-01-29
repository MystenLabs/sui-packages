module 0xa32bfb17a0be5f48ff52e832d9f38ab2b630076f30a0dd0321c800c735b1b898::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 6, b"SNEK", b"snek sui", b"2025 chinese new year snek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_170305_889_c470c9412a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

