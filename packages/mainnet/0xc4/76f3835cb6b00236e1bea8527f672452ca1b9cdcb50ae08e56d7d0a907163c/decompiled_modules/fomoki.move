module 0xc476f3835cb6b00236e1bea8527f672452ca1b9cdcb50ae08e56d7d0a907163c::fomoki {
    struct FOMOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOKI>(arg0, 6, b"FOMOKI", b"FOMOki", b"FOMOki is a mischievous, community-driven memecoin built on the SUI blockchain, designed to fuel excitement and FOMO with surprise rewards and burns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fomoki_SUI_daad507ff0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

