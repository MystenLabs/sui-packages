module 0xbffb0d09413f2c8979602e8e7301cb01173884b13c22b34ca08cdedb8c463759::ncat {
    struct NCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCAT>(arg0, 9, b"NCAT", b"Naiive", b"Cat fall in love with BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d53836d0-2b17-4c2d-8491-ee0051d0ac12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

