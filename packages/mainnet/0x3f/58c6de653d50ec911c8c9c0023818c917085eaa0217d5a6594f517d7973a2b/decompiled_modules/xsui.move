module 0x3f58c6de653d50ec911c8c9c0023818c917085eaa0217d5a6594f517d7973a2b::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 6, b"XSUI", b"Xorsui", b"XORSUI Alien explorer from the Sui Network  Master of cosmic blockchain tech  Connecting galaxies through decentralized systems | Innovating the future, one star at a time  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P6j_Z2i_ZZ_Sheah_Py_Q_Tnb_XA_80cbe68746.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

