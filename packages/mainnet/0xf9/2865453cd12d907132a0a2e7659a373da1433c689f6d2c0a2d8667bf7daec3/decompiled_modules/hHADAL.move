module 0xf92865453cd12d907132a0a2e7659a373da1433c689f6d2c0a2d8667bf7daec3::hHADAL {
    struct HHADAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHADAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHADAL>(arg0, 9, b"hHADAL", b"hHADAL Coin", b"hHADAL Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/hhadal_55a9949838_61093.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHADAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHADAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

