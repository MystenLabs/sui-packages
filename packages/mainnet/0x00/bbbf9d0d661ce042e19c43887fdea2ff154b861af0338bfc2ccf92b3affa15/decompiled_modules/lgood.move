module 0xbbbf9d0d661ce042e19c43887fdea2ff154b861af0338bfc2ccf92b3affa15::lgood {
    struct LGOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGOOD>(arg0, 9, b"LGOOD", b"LOOKINGOOD", b"LOOKING GOOD BARBIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60839abe-5280-4716-b2d7-f98df600d7a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

