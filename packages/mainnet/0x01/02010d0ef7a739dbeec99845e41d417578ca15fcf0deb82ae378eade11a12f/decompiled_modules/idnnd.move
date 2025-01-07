module 0x102010d0ef7a739dbeec99845e41d417578ca15fcf0deb82ae378eade11a12f::idnnd {
    struct IDNND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDNND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDNND>(arg0, 9, b"IDNND", b"jsnene", b"bxjejn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99f9e0e5-3068-418d-ac43-bf351a7effb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDNND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDNND>>(v1);
    }

    // decompiled from Move bytecode v6
}

