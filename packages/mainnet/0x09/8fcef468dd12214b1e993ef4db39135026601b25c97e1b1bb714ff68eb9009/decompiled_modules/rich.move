module 0x98fcef468dd12214b1e993ef4db39135026601b25c97e1b1bb714ff68eb9009::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 9, b"RICH", b"Rich", b"Rich Coin (RICH) is a meme-inspired cryptocurrency that represents the essence of opulence and extravagance. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bff3a2ba-f6c7-418b-87e7-679a23e1e73e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

