module 0x93f4771dcac389dd97bd5d3930c05ba3ecce7bf20733c3cc5b5cd4cfe21710f6::normie {
    struct NORMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORMIE>(arg0, 6, b"NORMIE", b"NORMIE ON SUI", b"On a mission to onboard the next 1,000,000 $NORMIES TO SUI CHAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_cvbd04_400x400_44dbebac03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORMIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

