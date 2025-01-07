module 0x5abc204d9b1f3049e8efbc2f42412fc2343077f1fe066412b30e368f5c980d3::woosh {
    struct WOOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOSH>(arg0, 9, b"WOOSH", b"Woosh", x"576f6f73682120596f752077696c6c2062652061206d696c6c696f6e6169726521f09faa84", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/369e84fd-28fa-4ba9-9d20-fc8b74e3fcba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

