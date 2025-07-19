module 0xd04213a556f6fac2ee9770dca14eba5d43db231c120391323ec6209ee2865b94::uncle {
    struct UNCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<UNCLE>(arg0, 6, b"UNCLE", b"uncle", b"uncle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2025_06_03_at_18_42_23_28b0c624eb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNCLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNCLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

