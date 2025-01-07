module 0x81219ea44659c423328c685f1ec38ae8b6711aa040e5a97b77d9da5437a48fab::real {
    struct REAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAL>(arg0, 9, b"REAL", b"Kachalla", b"A  very potent far reaching meme coin with lots of portfolio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdfacbfe-d1ab-4626-85ba-1b70a5d1f04e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

