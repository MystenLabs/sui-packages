module 0x4d2e5dc4dae9110ead2b9fbc66f6a12eb38d9dd3fd8ece59bf845b316a533cb0::tuning {
    struct TUNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNING>(arg0, 6, b"TUNING", b"Tuning", b"TUNING ARRIVED RUNNING AT 300 KM/H TO BE THE OFFICIAL TURBOS MASCOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951988073.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUNING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

