module 0x7f8953f494d530123d9acc4ab36ebc873c248005e407fb7c66c11efd7f442777::kikucat {
    struct KIKUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKUCAT>(arg0, 6, b"KIKUCAT", b"KIKU CAT AND FISH", b"Cat and fish is good potential, Kiku Cat brings a fun and relaxed vibe, aiming to make a big impact with its unique charm and ambitious goals. Kiku Cat huge potential returns for its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/296_B0307_CA_1_B_4_CEC_9011_065_EE_27_A1_E55_dcd2ddc316.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

