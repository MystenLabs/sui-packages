module 0x8db60cc21cfb5251beb7baa557d13008713cb9140306adbb16d6b381a6f21302::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 9, b"RICH", b"Rich", b"Rich Coin (RICH) is a meme-inspired cryptocurrency that represents the essence of opulence and extravagance. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee3eebd7-dbf1-4875-9de9-ddf86fdec5a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

