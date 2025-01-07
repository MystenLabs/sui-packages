module 0x8c5c1dc89292edddc4f4e07da21a216b8d8021109fa4dc4a32db705bd2caabde::potuzhno {
    struct POTUZHNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUZHNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUZHNO>(arg0, 9, b"POTUZHNO", b"POTUZHNIST", b"With this meme the power of Potuzhnist always be with you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2192fee5-8d7e-47be-8215-80069ce5fb34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUZHNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTUZHNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

