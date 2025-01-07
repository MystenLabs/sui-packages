module 0x4a6c12b935bcb9d84af43ea839c7e3a2b15f3c1d1e4126a057798225e36509c8::doggod {
    struct DOGGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGOD>(arg0, 6, b"DOGGOD", b"DOG DOG DOG DOG", b"dog and god", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7959be8313974bdc4115b048743f887_61e8891119.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

