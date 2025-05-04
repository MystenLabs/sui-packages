module 0x927b78a2e7ee2f57d271ca4dcc99399f457ed97eeebf5087834ec5d0b1a02e47::zabsui_sui {
    struct ZABSUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZABSUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZABSUI_SUI>(arg0, 9, b"zabsuiSUI", b"imanita Staked SUI", b"for all user", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/3fba6885-c208-453d-a749-9088f39364d1/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZABSUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZABSUI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

