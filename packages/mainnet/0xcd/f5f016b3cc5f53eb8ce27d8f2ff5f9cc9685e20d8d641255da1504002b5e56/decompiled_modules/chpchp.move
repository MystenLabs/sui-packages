module 0xcdf5f016b3cc5f53eb8ce27d8f2ff5f9cc9685e20d8d641255da1504002b5e56::chpchp {
    struct CHPCHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHPCHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHPCHP>(arg0, 9, b"CHPCHP", b"ChopChop", b"Financial institute ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bdbf005-6e03-49c6-8e7e-4f9b4842698f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHPCHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHPCHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

