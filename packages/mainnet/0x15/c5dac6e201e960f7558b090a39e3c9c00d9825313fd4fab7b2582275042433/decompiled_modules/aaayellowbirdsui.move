module 0x15c5dac6e201e960f7558b090a39e3c9c00d9825313fd4fab7b2582275042433::aaayellowbirdsui {
    struct AAAYELLOWBIRDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAYELLOWBIRDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAYELLOWBIRDSUI>(arg0, 6, b"AAAyellowbirdsui", b"AAA Yellow Bird", x"57656c6c206974206c6f6f6b73206c696b652074686520706f70756c6172206d656d6520224141412059656c6c6f77204269726422206973206e6f77206f6e2074686520537569204e6574776f726b212020204a6f696e206f75722054656c656772616d2068747470733a2f2f742e6d652f41414159454c4c4f57424952445f5355490a436865636b206f7574206f7572207765627369746521202068747470733a2f2f61616179656c6c6f77626972642e63617272642e636f2f230a547769747465722068747470733a2f2f782e636f6d2f6161617962697264737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2982ef69a008160cb67ef0a0e8af43de_b94c68551d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAYELLOWBIRDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAYELLOWBIRDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

