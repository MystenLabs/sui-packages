module 0x71b1bfda1723a4a7abaf7fb85e3edc131f2b53d0aaa2a18848b323c37d410683::longcat {
    struct LONGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONGCAT>(arg0, 6, b"LongCat", b"Sui's Longest Cat", b"The Longest Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbt_OIP_Wo_Ak0_C_t_01092c6344.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

