module 0xa146398494519aff964d797372b1fe37706319ed188f8d67108aa0432c9b53b6::cocktober {
    struct COCKTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCKTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCKTOBER>(arg0, 6, b"COCKTOBER", b"COCKTOBER SUI", b"COCKTOBER is finally here, Happy Swalloween", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rg_M_Brr_IN_400x400_a15c555cc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCKTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCKTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

