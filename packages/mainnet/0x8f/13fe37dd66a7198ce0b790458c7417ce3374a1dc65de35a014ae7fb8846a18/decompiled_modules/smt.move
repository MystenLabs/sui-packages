module 0x8f13fe37dd66a7198ce0b790458c7417ce3374a1dc65de35a014ae7fb8846a18::smt {
    struct SMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMT>(arg0, 9, b"SMT", b"SComms-Tec", b"SCOMMS-Tech organisational   Token built for Utilise Scomms Ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ada828c7-647d-419b-b023-ea1a224cdf48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

