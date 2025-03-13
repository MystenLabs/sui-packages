module 0x9aaac78d8ba81aa0b14020d42bb9529ab0b5c9272da69d412f8b12a841243caf::shaSUI {
    struct SHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHASUI>(arg0, 6, b"syshaSUI", b"SY shaSUI", b"SY scallop shaSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

