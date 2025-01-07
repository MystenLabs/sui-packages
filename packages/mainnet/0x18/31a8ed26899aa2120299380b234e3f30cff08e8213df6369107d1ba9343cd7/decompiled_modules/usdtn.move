module 0x1831a8ed26899aa2120299380b234e3f30cff08e8213df6369107d1ba9343cd7::usdtn {
    struct USDTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTN>(arg0, 9, b"USDTN", b"ERRORS", b"404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0fb40d7d-9281-43d0-9c1a-72f1fc9b57ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

