module 0x84ef7bae98f35ee6bbd750c3f474f2b9e5658e16b5bfa4a67038ecdf6e520da5::rice {
    struct RICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICE>(arg0, 9, b"RICE", b"Ricefield", b"Main food of Asian people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdd0d9ed-38bc-4320-8cb2-3784b419b275.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

