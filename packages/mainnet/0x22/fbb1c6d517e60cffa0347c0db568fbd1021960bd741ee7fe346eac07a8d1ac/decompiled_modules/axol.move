module 0x22fbb1c6d517e60cffa0347c0db568fbd1021960bd741ee7fe346eac07a8d1ac::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOL>(arg0, 6, b"AXOL", b"Axol on Sui", x"4d6565742041584f4cf09fa68e2c207468652063757465737420616d7068696269616e20212041584f4c206973206d6f7265207468616e206a75737420616e2061646f7261626c65206d6173636f74e280946974277320612073796d626f6c206f6620696e6e6f766174696f6e20696e207468652063727970746f2073706163652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735841655887.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

