module 0x8b7b78f58eec0cf0891eda6d7202881f30cc52ba049b25c2d47331b983ae3eff::hsui {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 6, b"HSUI", b"SuiCuneOnSui", b"Suicine, HSUI, and all name and likeness regarding (Hereafter referred to as 'The Project') in all forms provide no promise of financial gain. In addition, one should not expect to profit from participation in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_002435_5f27bf417b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

