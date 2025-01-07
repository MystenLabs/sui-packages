module 0x973778211d3856e431c9d5d1706dda972284f9d610b5362a458e78f8a41bc126::bonfi {
    struct BONFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONFI>(arg0, 6, b"BONFI", b"Bonfire", b"Bonfire: Real Burn, Real Scarcity, Real Supply Shock. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rr_F_Gv_Yb3_400x400_3bb11d86a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

