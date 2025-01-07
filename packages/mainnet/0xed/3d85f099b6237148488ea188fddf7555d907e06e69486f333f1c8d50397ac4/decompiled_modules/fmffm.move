module 0xed3d85f099b6237148488ea188fddf7555d907e06e69486f333f1c8d50397ac4::fmffm {
    struct FMFFM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMFFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMFFM>(arg0, 9, b"FMFFM", b"Yawjwjw", b"Dkdksm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8bbcef1-f241-4998-b745-7cfabdb2456f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMFFM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMFFM>>(v1);
    }

    // decompiled from Move bytecode v6
}

