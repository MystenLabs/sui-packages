module 0xd6d125db44dc5212b03f0779ab399cd723fe42b60fc223e1bbe27652bdca5e3d::miggles {
    struct MIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGGLES>(arg0, 6, b"Miggles", b"Mr.Miggles", b"Mr miggles is a Cat of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965491458.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGGLES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGGLES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

