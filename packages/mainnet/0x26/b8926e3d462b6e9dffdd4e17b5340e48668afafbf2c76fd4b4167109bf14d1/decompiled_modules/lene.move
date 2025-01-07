module 0x26b8926e3d462b6e9dffdd4e17b5340e48668afafbf2c76fd4b4167109bf14d1::lene {
    struct LENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENE>(arg0, 9, b"LENE", b"jend", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57114aea-6aa3-4656-860e-40bc717542c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

