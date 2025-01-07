module 0xb0849bd96cff80a16041c5a794a9c666be2d874b14a2d7ded6b8fa9d98f3f6a1::suiwave {
    struct SUIWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWAVE>(arg0, 9, b"SUIWAVE", b"SUI WAVE", b"The first token $MEME to the WAVE WALLET.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fad2bc8e-628c-44b3-bbe5-6a4789cc0adc-1000063407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

