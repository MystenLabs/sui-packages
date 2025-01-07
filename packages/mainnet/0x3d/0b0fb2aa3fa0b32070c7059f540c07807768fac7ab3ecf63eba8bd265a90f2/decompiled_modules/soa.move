module 0x3d0b0fb2aa3fa0b32070c7059f540c07807768fac7ab3ecf63eba8bd265a90f2::soa {
    struct SOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOA>(arg0, 9, b"SOA", b"Saski", x"49e280996d206a75737420747279696e67206e6f7420746f6f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/354c0059-b58e-41d2-8946-7118ef47ecfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

