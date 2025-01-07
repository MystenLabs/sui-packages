module 0x5260446dabc95701977a3b93e3ea9771e0e47ee841f7ab7cc1dd06f73a526a62::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 9, b"BSUI", b"Bitcoinsui", b"Bitcoins sui is the new opportunity for being a new millionaire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1aec961a-6758-4fcc-9289-a0d886c8e6e0-1000157869.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

