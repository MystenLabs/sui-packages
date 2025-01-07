module 0xd50d0e2039ed2cdc8a4c1f1ac317c2b9139f77ea6e7ec481310a2d186d3031b9::lusui {
    struct LUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSUI>(arg0, 6, b"LUSUI", b"LUSUI - Official SUI church mascot", b"Official mascot for World SUI church", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LUCE_1_fd6315b31a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

