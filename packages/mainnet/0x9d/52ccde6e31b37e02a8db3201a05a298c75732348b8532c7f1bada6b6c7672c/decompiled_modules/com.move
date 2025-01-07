module 0x9d52ccde6e31b37e02a8db3201a05a298c75732348b8532c7f1bada6b6c7672c::com {
    struct COM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COM>(arg0, 9, b"COM", b"competitio", b"between the winners", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79ced834-0e5b-4644-a0a9-2aa7b6a70c24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COM>>(v1);
    }

    // decompiled from Move bytecode v6
}

