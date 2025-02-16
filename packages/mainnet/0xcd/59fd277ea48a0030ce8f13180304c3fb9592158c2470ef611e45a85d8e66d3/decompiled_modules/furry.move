module 0xcd59fd277ea48a0030ce8f13180304c3fb9592158c2470ef611e45a85d8e66d3::furry {
    struct FURRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURRY>(arg0, 6, b"FURRY", b"Furry", b"Meet Furry, the very first SUICAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_e_I_cran_2025_02_16_a_I_20_54_36_7a3e41bec1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

