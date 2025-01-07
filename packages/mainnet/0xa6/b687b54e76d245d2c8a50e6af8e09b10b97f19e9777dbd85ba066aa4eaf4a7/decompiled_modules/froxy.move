module 0xa6b687b54e76d245d2c8a50e6af8e09b10b97f19e9777dbd85ba066aa4eaf4a7::froxy {
    struct FROXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROXY>(arg0, 6, b"Froxy", b"FroxySUI", b"Froxy_SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_EP_Zz2_Mo_400x400_3ab37bf410.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

