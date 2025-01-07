module 0x259c0d87d9079ed0fd6ae8286780fe6fd7337756e88c0e853e460883bc3a2a7f::gogoji {
    struct GOGOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGOJI>(arg0, 9, b"GOGOJI", b"GOGO", b"Muje testnet mila", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ee0f723-ef2b-4b66-b5cd-59711b228b16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

