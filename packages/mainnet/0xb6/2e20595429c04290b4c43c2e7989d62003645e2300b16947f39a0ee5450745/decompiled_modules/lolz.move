module 0xb62e20595429c04290b4c43c2e7989d62003645e2300b16947f39a0ee5450745::lolz {
    struct LOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLZ>(arg0, 9, b"LOLZ", b"LOLZ COIN", b"LOLZ is the ultimate meme coin designed for fun and laughter in the crypto space!Get ready to LOL with your investment!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99bec8c1-4116-4957-8aa7-59f87d95c350.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

