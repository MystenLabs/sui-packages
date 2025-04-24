module 0xa91e2679c85fbdb2354751edabb0c67bcb2e34ef77f309590aa1f20478716b8d::reatard {
    struct REATARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: REATARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REATARD>(arg0, 6, b"REATARD", b"RETARDcoin", b"Me like to do da Cha Cha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745518114894.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REATARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REATARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

