module 0x3bb2e08be941ee910fc36bc64e538d33adbe837c03fe098effc525c8888507a7::Acoin {
    struct ACOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACOIN>(arg0, 9, b"COINA", b"Acoin", b"Coin A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3GW9HN8JJG364GTJ62N3RCG.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

