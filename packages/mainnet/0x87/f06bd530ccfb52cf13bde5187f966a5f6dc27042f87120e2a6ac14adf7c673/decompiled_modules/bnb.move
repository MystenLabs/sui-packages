module 0x87f06bd530ccfb52cf13bde5187f966a5f6dc27042f87120e2a6ac14adf7c673::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 9, b"BNB", b"Binance", b"Binance great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8ed83f8-ee7a-474b-a3fa-48db3af4e8c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

