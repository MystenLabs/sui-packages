module 0xcacb6977b4b21359becba4c437354a19971c441ac2e6c7c0e1d0a24524c1e70f::pepedance {
    struct PEPEDANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDANCE>(arg0, 6, b"PEPEDANCE", b"Pepe Dance", b"DANCE DANCE DANCE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731964788170.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEDANCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDANCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

