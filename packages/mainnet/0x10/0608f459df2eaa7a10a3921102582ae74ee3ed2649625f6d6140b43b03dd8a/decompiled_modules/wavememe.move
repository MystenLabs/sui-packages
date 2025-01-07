module 0x100608f459df2eaa7a10a3921102582ae74ee3ed2649625f6d6140b43b03dd8a::wavememe {
    struct WAVEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEMEME>(arg0, 9, b"WAVEMEME", b"WaveMeme ", b"WaveMeme (Salmon) is a community-driven token aimed to be the number meme token in Wavewallet meme culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ec5487e-f402-4e62-8cb4-9824b5cc9a3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

