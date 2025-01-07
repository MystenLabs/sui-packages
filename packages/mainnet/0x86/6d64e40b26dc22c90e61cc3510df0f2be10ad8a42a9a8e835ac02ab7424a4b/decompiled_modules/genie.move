module 0x866d64e40b26dc22c90e61cc3510df0f2be10ad8a42a9a8e835ac02ab7424a4b::genie {
    struct GENIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIE>(arg0, 6, b"GENIE", b"GENIE Tate SUI", b"The real GENIE on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_A2b_Foy_400x400_06c4664f7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

