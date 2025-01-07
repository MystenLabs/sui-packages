module 0x57ae9f51c13692e616e996794e0ecaefba5a205957b1b0523d72d4115bf5ff0d::brics {
    struct BRICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRICS>(arg0, 6, b"Brics", b"BRICS", b"Los BRICS+,  es una asociacin, grupo y foro poltico y econmico de pases emergentes, que se ha constituido en un espacio internacional alternativo al G7, integrado por pases desarrollados", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004221_53418b98ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

