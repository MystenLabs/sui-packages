module 0x7fd36acfad6df624e23d85bfc5b9bcfb62ac6b3500d339725ee24c100e32650c::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 6, b"TOKI", b"Toki the Hippo Dog", b"Toki the Hippo Dog is a cross between a Sharpei and a Cocker Spaniel . First of its Kind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ky_Fx_BQ_5z_400x400_ddf0dfbb3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

