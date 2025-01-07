module 0x4c3f022ef569dcc2041f990c9f2865c57fa1b6c79fe681ae05cb92d66eeffce4::afSUI {
    struct AFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFSUI>(arg0, 9, b"syafSUI", b"SY afSUI", b"SY afSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

