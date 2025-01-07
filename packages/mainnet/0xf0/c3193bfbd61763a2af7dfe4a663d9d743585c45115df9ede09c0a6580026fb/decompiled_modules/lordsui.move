module 0xf0c3193bfbd61763a2af7dfe4a663d9d743585c45115df9ede09c0a6580026fb::lordsui {
    struct LORDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORDSUI>(arg0, 9, b"LORDSUI", b"Lord Sui", b"meme sui to the moon lfg lfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d7c7909-9dc5-41c5-a92e-36766f45c402.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LORDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

