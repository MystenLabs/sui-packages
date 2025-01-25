module 0xb40eca4c42530293b325017fd63e63db034e60191d65aa23c017d4efb3ddcb3c::elonmusk {
    struct ELONMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUSK>(arg0, 9, b"ELONMUSK", b"ElonToken", b"ElonToken is not just a meme coin; it is a platform for tech enthusiasts to celebrate Elon Musk's influence in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67d90829-454b-40ae-bf66-3190b7182918.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

