module 0x8c492429239e3e72bd75378ef749055f0683e66f45caaef2ced532432aa380d7::gdsag {
    struct GDSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSAG>(arg0, 9, b"GDSAG", b"DAG", b"SAF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee46aded-dc52-4930-ab4e-859ad4cfa6c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

