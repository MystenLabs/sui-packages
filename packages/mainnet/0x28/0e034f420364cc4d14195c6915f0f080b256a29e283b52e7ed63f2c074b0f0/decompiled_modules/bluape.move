module 0x280e034f420364cc4d14195c6915f0f080b256a29e283b52e7ed63f2c074b0f0::bluape {
    struct BLUAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUAPE>(arg0, 6, b"BLUAPE", b"BLUAPE SUI", b"$BLUAPE wants to be real! Please help make $BLUAPE real!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_07_08_32_30_ca10399c64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

