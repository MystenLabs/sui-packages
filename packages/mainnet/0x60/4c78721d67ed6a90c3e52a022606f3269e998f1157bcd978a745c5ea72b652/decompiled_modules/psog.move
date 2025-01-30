module 0x604c78721d67ed6a90c3e52a022606f3269e998f1157bcd978a745c5ea72b652::psog {
    struct PSOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSOG>(arg0, 6, b"PSOG", b"Phantom is SOGGED", b"Only Seal Dog and Phantom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gie_C480ao_A_Ai_Z3_P_b5e6eb2088.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

