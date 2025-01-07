module 0x34eeaf386ae2ca7c918d22b10e48a705658221d64c93613278a6398b98560f2::unfk {
    struct UNFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNFK>(arg0, 9, b"UNFK", b"Unf*ck", b"Secret society and meme-game pranking corrupt corporations", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cdc3fb0-da84-4e76-9bea-f57275a0adda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

