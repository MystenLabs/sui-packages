module 0x283ea1dc7ddba203b18e61eddaf131a356f0b15d262bb985fe319575168a9c0e::sndmc {
    struct SNDMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNDMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNDMC>(arg0, 9, b"SNDMC", b"Stsnw", b"Smdml", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/398cfd86-bf11-4052-bcce-21e340a5bd6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNDMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNDMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

