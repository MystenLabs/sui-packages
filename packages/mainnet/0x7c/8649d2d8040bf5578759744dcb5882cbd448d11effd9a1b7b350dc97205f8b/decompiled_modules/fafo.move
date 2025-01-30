module 0x7c8649d2d8040bf5578759744dcb5882cbd448d11effd9a1b7b350dc97205f8b::fafo {
    struct FAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFO>(arg0, 6, b"FAFO", b"FuckAroundAndFoundOut", x"0a20425245414b494e473a205472756d70206a75737420706f73746564207468697320746f2054727574682e204641464f21202020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gi_Po8_Z_Na_AAAY_Ony_2c1f9142b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

