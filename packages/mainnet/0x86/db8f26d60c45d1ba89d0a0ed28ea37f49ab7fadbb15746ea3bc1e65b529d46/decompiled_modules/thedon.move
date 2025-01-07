module 0x86db8f26d60c45d1ba89d0a0ed28ea37f49ab7fadbb15746ea3bc1e65b529d46::thedon {
    struct THEDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEDON>(arg0, 9, b"THEDON", b"The Donald", b"Rogan and Trump 2024!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/961587fd-51c6-44cb-a8da-38bb436c863b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

