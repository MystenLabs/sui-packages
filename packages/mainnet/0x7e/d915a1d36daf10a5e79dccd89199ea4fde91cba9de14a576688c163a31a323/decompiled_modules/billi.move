module 0x7ed915a1d36daf10a5e79dccd89199ea4fde91cba9de14a576688c163a31a323::billi {
    struct BILLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLI>(arg0, 9, b"BILLI", b"Billion ", b"Awesome ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/309f152c-3bef-44d2-b621-465cf41a44f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

