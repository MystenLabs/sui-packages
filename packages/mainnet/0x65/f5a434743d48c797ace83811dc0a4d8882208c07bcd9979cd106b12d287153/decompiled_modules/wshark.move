module 0x65f5a434743d48c797ace83811dc0a4d8882208c07bcd9979cd106b12d287153::wshark {
    struct WSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSHARK>(arg0, 9, b"WSHARK", b"WAVE SHARK", b"MEME for WAVE lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de9fe761-fd6c-4b4c-97bf-29a903820e04-IMG_7597.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

