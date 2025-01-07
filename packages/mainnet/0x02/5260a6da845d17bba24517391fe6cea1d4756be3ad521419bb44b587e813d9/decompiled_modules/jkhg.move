module 0x25260a6da845d17bba24517391fe6cea1d4756be3ad521419bb44b587e813d9::jkhg {
    struct JKHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKHG>(arg0, 9, b"JKHG", b"ASDAS", b"VBCCD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ccdadbd-a64e-4755-bae7-68300596cb4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

