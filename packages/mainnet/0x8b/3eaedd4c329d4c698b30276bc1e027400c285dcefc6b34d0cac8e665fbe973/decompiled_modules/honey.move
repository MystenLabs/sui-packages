module 0x8b3eaedd4c329d4c698b30276bc1e027400c285dcefc6b34d0cac8e665fbe973::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 9, b"HONEY", b"HON", b"fun = fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67840beb-b0d2-4943-902d-2d6b34e8a7be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

