module 0x248d4a99672653e7b645228a93fe1690531b9f27bc687a4d49456e51851e6252::movemonk {
    struct MOVEMONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEMONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEMONK>(arg0, 6, b"MOVEMONK", b"MOVE MONKFISH", b"MOVEMONK the spooky fish from $SUI ocean comes from a deep, dark and cold ocean zone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/822_F1_E72_F209_4647_BBE_3_515_DCCBB_880_C_199a921300.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEMONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEMONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

