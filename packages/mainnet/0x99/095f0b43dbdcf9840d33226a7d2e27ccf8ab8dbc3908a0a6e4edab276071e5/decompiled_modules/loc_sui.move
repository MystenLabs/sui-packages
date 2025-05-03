module 0x99095f0b43dbdcf9840d33226a7d2e27ccf8ab8dbc3908a0a6e4edab276071e5::loc_sui {
    struct LOC_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOC_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOC_SUI>(arg0, 9, b"locSUI", b"Loco Staked SUI", b"The best LST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/1a98296b-09da-4134-9e3a-07bc78bb4eed/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOC_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOC_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

