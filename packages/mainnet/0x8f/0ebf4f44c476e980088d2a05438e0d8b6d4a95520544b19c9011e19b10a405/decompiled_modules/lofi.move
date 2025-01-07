module 0x8f0ebf4f44c476e980088d2a05438e0d8b6d4a95520544b19c9011e19b10a405::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", b"LOFII", b"Lofi On Suiai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7348_0aee821c86.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOFI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

