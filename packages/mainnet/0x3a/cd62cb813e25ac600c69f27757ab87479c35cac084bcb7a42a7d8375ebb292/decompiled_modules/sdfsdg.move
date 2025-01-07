module 0x3acd62cb813e25ac600c69f27757ab87479c35cac084bcb7a42a7d8375ebb292::sdfsdg {
    struct SDFSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSDG>(arg0, 6, b"SDFSDG", b"bcbxcbcx", b"asfsafas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731010947347.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDFSDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

