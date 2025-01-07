module 0xad8eaf2283b1e6fae0552f3bd654d2c895b53710be4d3f3e256d335b0ca3ee49::sbl {
    struct SBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBL>(arg0, 9, b"SBL", b"Sui Blood", x"4361727279696e672074686520626c6f6f64206f66205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e6393ba-9677-4337-b30d-dfeb51a27fc3-GZDSE-ZXgAAeZxM.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

