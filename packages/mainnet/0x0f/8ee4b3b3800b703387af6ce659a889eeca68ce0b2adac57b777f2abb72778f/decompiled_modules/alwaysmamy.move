module 0xf8ee4b3b3800b703387af6ce659a889eeca68ce0b2adac57b777f2abb72778f::alwaysmamy {
    struct ALWAYSMAMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALWAYSMAMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALWAYSMAMY>(arg0, 9, b"ALWAYSMAMY", b"MOM", b"Thanks For Mamy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd0dcb3a-abf6-40af-ba26-ca802f77034c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALWAYSMAMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALWAYSMAMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

