module 0xaede92385591f460b0582f60436536eefa37461287e488e304fc0b2d9e4e347c::holiday_sui {
    struct HOLIDAY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLIDAY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLIDAY_SUI>(arg0, 9, b"holidaySUI", b"Holiday Staked SUI", b"A way to make money by staking these for the holidays", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/1ae36e87-9dfc-41ce-9364-27945b41151d/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLIDAY_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLIDAY_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

