module 0xc22fbdb3c8f6d320ceb32c9600e4821349b15ff9f4f786506402674c6081ad10::chppa {
    struct CHPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHPPA>(arg0, 9, b"CHPPA", b"CHOPPA", b"Choppa token is a meme token, choppa is a slang word meaning automatic weapon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e1b7da9-5366-443e-b583-b4a36cabaa6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

