module 0xc3f9eae6537695ffbcb0649e1ada2a22d7d5682e4246ecd51144475788a88563::oneye {
    struct ONEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEYE>(arg0, 9, b"ONEYE", b"Zuko", b"Zuko the famous shiba inu with one eye.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6668504-08a4-4930-b791-b57c0dbf88ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

