module 0x4b809bc58d18f37c6eeeb6c4238d557e8ca195601a0639d3254e760d4d86db32::iSui {
    struct ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUI>(arg0, 9, b"syiSUI", b"SY iSUI", b"SY Ika Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

