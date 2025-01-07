module 0x643bfe58019bdcda34db29ee956e36330ddb858c20d1772f3e1612bf1cc87148::heysui {
    struct HEYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEYSUI>(arg0, 9, b"HEYSUI", b"Heysuioi", b"Heysuioi is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99b2d500-84c0-46f3-9c02-ba3f022f1111.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

