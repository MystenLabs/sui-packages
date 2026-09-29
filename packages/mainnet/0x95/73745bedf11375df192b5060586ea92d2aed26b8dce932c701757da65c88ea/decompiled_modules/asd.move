module 0x9573745bedf11375df192b5060586ea92d2aed26b8dce932c701757da65c88ea::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 9, b"asd", b"asd", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASD>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

