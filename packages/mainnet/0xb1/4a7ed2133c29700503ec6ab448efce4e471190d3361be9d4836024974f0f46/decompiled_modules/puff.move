module 0xb14a7ed2133c29700503ec6ab448efce4e471190d3361be9d4836024974f0f46::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Puff", x"57652061726520505546462e205765206172652067726f77696e67207769746820657665727920505546462e0a57652061726520646f6d696e6174696e672074686520776f726c642e204c65747320476f6f6f6f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unbenanntes3_removebg_preview_e251920421.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

