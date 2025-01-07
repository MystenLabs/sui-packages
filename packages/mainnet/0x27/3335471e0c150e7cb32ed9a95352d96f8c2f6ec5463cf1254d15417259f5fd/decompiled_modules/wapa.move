module 0x273335471e0c150e7cb32ed9a95352d96f8c2f6ec5463cf1254d15417259f5fd::wapa {
    struct WAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAPA>(arg0, 6, b"WAPA", b"WaPa", b"Ride the waves with $WAPAwhere ocean vibes crash into blockchain power. Dive in and make a splash! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345345_5d30c16657.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

