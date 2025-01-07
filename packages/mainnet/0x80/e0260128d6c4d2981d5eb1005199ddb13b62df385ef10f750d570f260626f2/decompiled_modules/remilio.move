module 0x80e0260128d6c4d2981d5eb1005199ddb13b62df385ef10f750d570f260626f2::remilio {
    struct REMILIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMILIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMILIO>(arg0, 6, b"REMILIO", b"Remilio Sui", x"7765206172652072656d696c696f2e2073747564792072656d696c696f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_09_11_18_51_cb686ad984.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMILIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMILIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

