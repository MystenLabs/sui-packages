module 0xbe456b5d06c19ada53a8a006630629b5b404e24ed3be8e0a780ee0093277b061::zenos {
    struct ZENOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENOS>(arg0, 6, b"ZENOS", b"ZENOSONSUI", b"Where fun meets future- empowering the revolution, one coin at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_625925cc83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZENOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

