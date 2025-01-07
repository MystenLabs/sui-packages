module 0xa698e1220afaf328f8b9ec571949ab60af291e8756e91f4b7cab1305241d83ab::twench {
    struct TWENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWENCH>(arg0, 6, b"TWENCH", b"FIRST TWENCH SUI", b"FIRST TWENCH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/112_f2bb9292b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

