module 0xf74cad890be1e323212cdd00cb644f776f5bf4cbce6df455b7584d630e0fba73::putin {
    struct PUTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUTIN>(arg0, 6, b"PUTIN", b"VLODIMIR", b"Best history teacher ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MW_DJ_519_E_Pc7_FX_20150413113709_NS_31e30490d1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

