module 0xfb7c48341748a35d81963016072ecf966851ae1f4dac8c38c30409f3e68de3bf::tws {
    struct TWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWS>(arg0, 9, b"TWS", b"Test", b"Tester ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db23edcf-dfd8-41aa-aea1-986b804899e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

