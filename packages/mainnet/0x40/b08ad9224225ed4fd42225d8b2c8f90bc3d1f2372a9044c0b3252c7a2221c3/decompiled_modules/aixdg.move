module 0x40b08ad9224225ed4fd42225d8b2c8f90bc3d1f2372a9044c0b3252c7a2221c3::aixdg {
    struct AIXDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXDG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIXDG>(arg0, 6, b"AIXDG", b"aixdg", b"AIXDG monitors CT discussions and utilizes its proprietary engine to identify high-momentum opportunities while engaging with games on the Sui Network...Holders of the AIXDG token gain exclusive access to its advanced analytics platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aixdg_6fd1a904b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIXDG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXDG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

