module 0x37de3c13c4b643a83853c9ee9c5fa2c0bd7b43bf48cdcf856da6117ad35ff648::onco {
    struct ONCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONCO>(arg0, 9, b"ONCO", b"OneCoin", b"One coin trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf91078f-044a-4cff-8dd1-f640896b005c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

