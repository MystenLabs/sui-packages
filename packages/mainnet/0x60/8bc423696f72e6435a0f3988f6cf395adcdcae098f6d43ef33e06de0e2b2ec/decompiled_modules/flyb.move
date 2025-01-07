module 0x608bc423696f72e6435a0f3988f6cf395adcdcae098f6d43ef33e06de0e2b2ec::flyb {
    struct FLYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYB>(arg0, 9, b"FLYB", b"FLY BIRD", b"Talk about birds flying in the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bee55687-2bc3-451c-8a15-972b101cf089.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLYB>>(v1);
    }

    // decompiled from Move bytecode v6
}

