module 0x4307a4a0256a3ec1b440393eb80739286b8d4a733f51308a4d3dd31a82f8a2c::zenos {
    struct ZENOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENOS>(arg0, 6, b"Zenos", b"Zenosonsui", b"Where fun meets future- empowering one coin at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_bd1f56e1de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZENOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

