module 0xbe0aa54f5fc57271822fcc3f0e491fb014a42e484e781ba902ec27b49e38acfc::sboobs {
    struct SBOOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOOBS>(arg0, 6, b"Sboobs", b"Sui BOOBS", b"great boobs on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Sdd_G_Ni_XUAA_1_Axx_57503da84e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

