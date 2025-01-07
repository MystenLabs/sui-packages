module 0x7648ccbd91b230e57a9a18db3b23fdd899ded6452f90052303ea41bc928135::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFROG>(arg0, 6, b"HOPFROG", b"HopFrog", b"First Frog on Hop Fun But Now We Go To Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001546104.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPFROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

