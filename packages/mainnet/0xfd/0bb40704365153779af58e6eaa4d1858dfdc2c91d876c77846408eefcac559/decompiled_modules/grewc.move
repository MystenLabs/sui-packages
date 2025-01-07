module 0xfd0bb40704365153779af58e6eaa4d1858dfdc2c91d876c77846408eefcac559::grewc {
    struct GREWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREWC>(arg0, 6, b"GREWC", b"Green hair girl with cat", b"What are you looking at?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/57e07099e129317a0b1a989ea407b196_91a3c6b376.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

