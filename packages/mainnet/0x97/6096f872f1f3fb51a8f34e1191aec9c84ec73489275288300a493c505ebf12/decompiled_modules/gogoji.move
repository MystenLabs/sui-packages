module 0x976096f872f1f3fb51a8f34e1191aec9c84ec73489275288300a493c505ebf12::gogoji {
    struct GOGOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGOJI>(arg0, 9, b"GOGOJI", b"GOGO", b"Muje testnet mila", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8d557d8-4f0e-4dd4-8bce-10404b8e48ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

