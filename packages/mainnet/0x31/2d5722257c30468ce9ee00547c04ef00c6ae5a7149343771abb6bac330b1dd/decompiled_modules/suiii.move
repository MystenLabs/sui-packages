module 0x312d5722257c30468ce9ee00547c04ef00c6ae5a7149343771abb6bac330b1dd::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIII>(arg0, 9, b"SUIII", b"CR7-SUIIII", b"A meme coin inspired by the celebration of the greatest footballer of all time. ~SUIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17e9ff44-2310-4973-9d6c-4b41c2480f05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

