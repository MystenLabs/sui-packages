module 0x549784080a2134094935d34dd1617fac283275c5c54c8e8f3ac9589f1aa477eb::plopsui {
    struct PLOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOPSUI>(arg0, 6, b"PlopSui", b"Plop on Sui", b"Official mascot of $SUI chain  plop plop ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flop_bcb9cf1759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

