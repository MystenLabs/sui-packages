module 0xee8fa9d554400322327ec497d402a3528c7e4904fd2494f9ba202bba23435d09::athism {
    struct ATHISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATHISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATHISM>(arg0, 6, b"ATHism", b"Autistic Dolphin", x"417574697374696320646f6c7068696e2074686174207468696e6b732069742773207370656c6c65642041544869736d2e204f682077616974206c6f6f6b206174207468617420776520537569206174204154482120446a644b6a4a4a4a24736a736a6b0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AT_Hismm_d07ceec402_077c7912ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATHISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATHISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

