module 0x7e842edd05051d161f1804b362b96da2e3f86e18c0dbf86f2ea036e4e2244b31::higher {
    struct HIGHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGHER>(arg0, 6, b"HIGHER", b"HIGH", b"MFER ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/532_2fedebea8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

