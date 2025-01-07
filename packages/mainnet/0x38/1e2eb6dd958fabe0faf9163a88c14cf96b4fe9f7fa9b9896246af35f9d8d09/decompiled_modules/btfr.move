module 0x381e2eb6dd958fabe0faf9163a88c14cf96b4fe9f7fa9b9896246af35f9d8d09::btfr {
    struct BTFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTFR>(arg0, 9, b"BTFR", b"BTFather", b"BTFR is a meme coin built on the SUI blockchain. It is based on the popular Grok meme and is based on different blockchains, which are getting ready to work with some other blockchains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4047f902-1eba-4757-bca4-509da7f1f7a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

