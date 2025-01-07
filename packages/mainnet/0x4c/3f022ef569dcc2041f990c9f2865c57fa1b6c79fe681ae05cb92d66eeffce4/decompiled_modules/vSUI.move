module 0x4c3f022ef569dcc2041f990c9f2865c57fa1b6c79fe681ae05cb92d66eeffce4::vSUI {
    struct VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSUI>(arg0, 9, b"syvSUI", b"SY vSUI", b"SY volo vSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

